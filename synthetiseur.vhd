library ieee ;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
	
	ENTITY synthetiseur is PORT ( 
      LEDR : buffer bit_vector (9 downto 0);
		MAX10_CLK1_50 : in std_logic;
		KEY : in  bit_vector(1 downto 0);
		SW : in std_logic_vector(9 downto 0);
		GPIO : buffer std_logic_vector (35 downto 0);
		Arduino : in std_logic_vector (15 downto 0)	
		); 
    END synthetiseur;
	  
	 
	 
	 
	 
	 ARCHITECTURE fonction of synthetiseur is 
	 
	 signal compteur : integer range 0 to 105;
	 signal horl100 : std_logic;
	 Signal adressfal : integer range 0 to 43;
	 Signal SDI : std_logic;
	 Signal CSDAC : std_logic;
	 Signal SCK : std_logic;
	 Signal CSADC : std_logic;
	 Signal SCKADC : std_logic;
	 Signal adressADC : integer range 0 to 34;
	 Signal SAADC : std_logic;
	 signal horl800 : std_logic;
	 Signal CSMCP : std_logic;
	 Signal SI : std_logic;
	 Signal CLK : std_logic;
	 Signal adressMCP : integer range 0 to 130;
	 Signal ramp : std_logic_vector ( 11 downto 0);
	 signal compteur1 : integer range 0 to 65;
	 Signal compteurmult : integer range 0 to 3;
	 
	 
	 Begin
	 
			horloge : Process(MAX10_CLK1_50)
			begin
			if rising_edge(Max10_clk1_50) 
				then compteur <= compteur +1;
			
			
			if compteur > 100 then
				compteur <= 0;
				horl100 <= not horl100;
			end if ;
			if compteur1 > 30 then
				compteur1 <= 0;
				horl800 <= not horl800;
				GPIO(8) <= horl800;
			end if ;		

			end if ;		
			end process horloge;
			
			Test : Process(horl800,ramp)
			begin
			if rising_edge(horl800)
			then
			ramp <= ramp + '1';
			GPIO(9) <= ramp(1);
			end if;
			
			
			
			
			
			end process test;
			
			--DACramp : process(horl800,ramp)
			--begin 
			--if rising_edge (horl800) then
			--	ramp <= ramp + '1';
			--	GPIO(9) <= ramp(11);
			--end if ;
			--end process DACramp;

			
			
			
			
			

			DACTRAM : Process(horl100)
			
			begin
			if rising_edge(horl100)
				then adressfal <= adressfal + 1;
				case adressfal is
				when 0 => CSDAC <= '0'; SDI <= '1';   --choix de la voie B
				When 1 => SCK <= '1';
				When 2 => SDI <= '0'; SCK<='0';
				when 3 => SCK <= '1'; 
				when 4 => SCK <= '0'; SDI <='1';
				when 5 => SCK <= '1'; 
				when 6 => SCK <= '0';
				when 7 => SCK <= '1';
				when 8 => SCK <= '0'; SDI <= SW(0);   
				When 9 => SCK <= '1'; 
				When 10 => SCK <= '0'; SDI <= SW(1);
				when 11 => SCK <= '1'; 
				when 12 => SCK <= '0'; SDI <= SW(2);
				when 13 => SCK <= '1'; 
				when 14 => SCK <= '0'; SDI <= SW(3);
				when 15 => SCK <= '1'; 
				When 16 => SCK <= '0'; SDI <= SW(4);
				When 17 => SCK <= '1'; 
				when 18 => SCK <= '0'; SDI <= SW(5);
				when 19 => SCK <= '1'; 
				when 20 => SCK <= '0'; SDI <= SW(6);
				when 21 => SCK <= '1'; 
				when 22 => SCK <= '0'; SDI <= SW(7);
				when 23 => SCK <= '1'; 
				when 24 => SCK <= '0'; SDI <= SW(8);
				when 25 => SCK <= '1'; 
				when 26 => SCK <= '0'; SDI <= SW(9);
				when 27 => SCK <= '1'; 
				when 28 => SCK <= '0'; SDI <= '1';
				when 29 => SCK <= '1'; 
				when 30 => SCK <= '0'; SDI <= '1';
				when 31 => SCK <= '1'; CSDAC <= '0';
				when 32 => SCK <= '0';
				when 33 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 34 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 35 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 36 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 37 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 38 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 39 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 40 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 41 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 42 => SCK <= '0'; SDI <= '0'; CSDAC <= '1';
				when 43 => SCK <= '0'; SDI <= '0'; CSDAC <= '1'; adressfal <= 0;
				when others => SCK <= '0';
				end case;
			end if;
			GPIO(0) <= SCK;
			GPIO(1) <= SDI;

			GPIO(2) <= CSDAC;
			end process DACTRAM;
				
			
			MULTENV : Process(horl100,Arduino(0))
			begin
			if rising_edge (horl100)
			then compteurmult <= compteurmult +1;
				case compteurmult is
				when 0 => GPIO(3) <='0'; GPIO(4) <= '0';
				when 1 => GPIO(3) <='1'; GPIO(4) <= '0'; --LEDR(1) <= Arduino(0);
				when 2 => GPIO(3) <='0'; GPIO(4) <= '1'; --LEDR(2) <= Arduino(0);
				when 3 => GPIO(3) <='1'; GPIO(4) <= '1'; --LEDR(3) <= Arduino(0);
				when others => GPIO(3) <='0'; GPIO(4) <= '0';
				end case;
			end if;			
			end process MULTENV;
			
			MULTT : Process(Arduino(2),compteurmult,LEDR)
			begin
			if compteurmult = 0 then
				if rising_edge (Arduino(2)) then 
				LEDR(0) <= '1';
				LEDR(1) <= '0';
				end if;
			end if;			
			end process MULTT;
			
			MULTF : Process(Arduino(2),compteurmult,LEDR)
			begin
			if compteurmult = 0 then
				if falling_edge (Arduino(2)) then 
				LEDR(2) <= '0';
				LEDR(3) <= '1';
				end if;
			end if;	
			
			
			end process MULTF;
			
			
			
			
			
			
			
			
			
			
			ADC : Process (horl100)		
			begin
			if rising_edge (horl100)
				then adressADC <= adressADC + 1;
				case adressADC is
				when 0 => CSADC <= '1';
				when 1 => SCKADC <= '1'; SAADC <= '0';
				when 2 => SCKADC <= '0';
				when 3 => SCKADC <= '1';
				when 4 => SCKADC <= '0';
				when 5 => SCKADC <= '1';
				when 6 => SCKADC <= '0';
				when 7 => SCKADC <= '1';
				when 8 => SCKADC <= '0';
				when 9 => SCKADC <= '1';
				when 10 => SCKADC <= '0';
				when 11 => SCKADC <= '1';
				when 12 => SCKADC <= '0';
				when 13 => SCKADC <= '1';
				when 14 => SCKADC <= '0';
				when 15 => SCKADC <= '1';
				when 16 => SCKADC <= '0';
				when 17 => SCKADC <= '0';
				when 18 => SCKADC <= '1';
				when 19 => SCKADC <= '0';
				when 20 => SCKADC <= '1'; CSADC <= '0';
				when 21 => SCKADC <= '0';
				when 22 => SCKADC <= '1';
				when 23 => SCKADC <= '0';
				when 24 => SCKADC <= '0';
				when 25 => SCKADC <= '1'; 
				when 26 => SCKADC <= '0';
				when 27 => SCKADC <= '1'; 
				when 28 => SCKADC <= '0';
				when 29 => SCKADC <= '1'; 
				when 30 => SCKADC <= '0';
				when 31 => SCKADC <= '1';
				when 32 => SCKADC <= '0';
				when 33 => SCKADC <= '1';
				when 34 => SCKADC <= '0'; adressADC <= 0; CSADC <= '1';
				when others => SCKADC <= '0';
				end case;
			end if;
			GPIO(33) <= SCKADC;
			GPIO(34) <= SAADC;
			GPIO(35) <= CSADC;
					
			end process ADC;
	 END architecture;