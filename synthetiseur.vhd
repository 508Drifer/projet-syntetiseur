library ieee ;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;


	
	
	ENTITY synthetiseur is PORT ( 
      LEDR : out bit_vector (1 downto 0);
		MAX10_CLK1_50 : in std_logic;
		KEY : in  bit_vector(1 downto 0);
		SW : in std_logic_vector(9 downto 0);
		GPIO : buffer std_logic_vector (35 downto 0)
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
	 
	 Signal CSMCP : std_logic;
	 Signal SI : std_logic;
	 Signal CLK : std_logic;
	 Signal adressMCP : integer range 0 to 130;
	 
	 
	 Begin
	 
			horloge : Process(MAX10_CLK1_50)
			begin
			if rising_edge(Max10_clk1_50) 
				then compteur <= compteur +1;
			
			
			if compteur > 100 then
				compteur <= 0;
				horl100 <= not horl100;
			end if ;
			end if ;		
			end process horloge;
			
			

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
				when 28 => SCK <= '0'; SDI <= '0';
				when 29 => SCK <= '1'; 
				when 30 => SCK <= '0'; SDI <= '0';
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
			
			
			MCPTRAM : Process(horl100)
			begin 
			if rising_edge(horl100)
			then adressMCP <= adressMCP+1;
			case adressMCP is
			when 0 => CSMCP <= '0'; SI <='0';
			when 1 => CLK <= '1';
			when 2 => CLK <='0'; SI <='1';
			when 3 => CLK <='1';
			when 4 => CLK <='0';SI<='0';
			when 5 => CLK <='1';
			when 6 => CLK <='0';
			when 7 => CLK <='1';
			when 8 => CLK <='0';
			when 9 => CLK <='1';
			when 10 => CLK <='0';
			when 11 => CLK <='1';
			when 12 => CLK <='0';
			when 13 => CLK <='1';
			when 14 => CLK <='0';
			when 15 => CLK <='1';
			when 16 => CLK <='0';
			when 17 => CLK <='1';
			when 18 => CLK <='0';
			when 19 => CLK <='1';
			when 20 => CLK <='0';
			when 21 => CLK <='1';
			when 22 => CLK <='0';
			when 23 => CLK <='1';
			when 24 => CLK <='0';
			when 25 => CLK <='1'; 
			when 26 => CLK <='0';SI <='1';
			when 27 => CLK <='1';
			when 28 => CLK <='0';
			when 29 => CLK <='1';
			when 30 => CLK <='0';SI <='0';
			when 31 => CLK <='1';
			when 32 => CLK <='0';SI <='1';
			when 33 => CLK <='1';
			when 34 => CLK <='0';
			when 35 => CLK <='1'; 
			when 36 => CLK <='0';
			when 37 => CLK <='1';
			when 38 => CLK <='0';
			when 39 => CLK <='1';
			when 40 => CLK <='0';
			when 41 => CLK <='1';
			when 42 => CLK <='0';
			when 43 => CLK <='1';
			when 44 => CLK <='0';
			when 45 => CLK <='1'; 
			when 46 => CLK <='0';
			when 47 => CLK <='1';
			when 48 => CLK <='0';SI <='0';CSMCP <='1';
			when 49 => CLK <='1';
			when 50 => CLK <='0';
			when 51 => CLK <='0';
			when 52 => CLK <='0';
			when 53 => CLK <='0';
			when 54 => CLK <='0';
			when 55 => CLK <='0';
			when 56 => CLK <='0';
			when 57 => CLK <='0';
			when 58 => CLK <='0';
			when 59 => CLK <='0';
			--fin de trame de set des sorties
			
			--début de l'autre trame de lecture
			when 60 => CLK <='0';SI<='0';CSMCP<='0';
			when 61 => CLK <='1';
			when 62 => CLK <='0';SI <='1';
			when 63 => CLK <='1';
			when 64 => CLK <='0';SI <='0';
			when 65 => CLK <='1';
			when 66 => CLK <='0';
			when 67 => CLK <='1';
			when 68 => CLK <='0';
			when 69 => CLK <='1';
			when 70 => CLK <='0';
			when 71 => CLK <='1';
			when 72 => CLK <='0';
			when 73 => CLK <='1';
			when 74 => CLK <='0';SI<='1';
			when 75 => CLK <='1';
			when 76 => CLK <='0';SI<='0';
			when 77 => CLK <='1';
			when 78 => CLK <='0';
			when 79 => CLK <='1';
			when 80 => CLK <='0';
			when 81 => CLK <='1';
			when 82 => CLK <='0';
			when 83 => CLK <='1';
			when 84 => CLK <='0';SI<='1';
			when 85 => CLK <='1';
			when 86 => CLK <='0';SI<='0';
			when 87 => CLK <='1';
			when 88 => CLK <='0';
			when 89 => CLK <='1';
			when 90 => CLK <='0';
			when 91 => CLK <='1';
			when 92 => CLK <='0';
			when 93 => CLK <='1';
			when 94 => CLK <='0';
			when 95 => CLK <='1';
			when 96 => CLK <='0';
			when 97 => CLK <='1';
			when 98 => CLK <='0';
			when 99 => CLK <='1';
			when 100 => CLK <='0';
			when 101 => CLK <='1';
			when 102 => CLK <='0';
			when 103 => CLK <='1';
			when 104 => CLK <='0';
			when 105 => CLK <='1';
			when 106 => CLK <='0';
			when 107 => CLK <='1';
			when 108 => CLK <='0';CSMCP <='1';		
			when 109 => CLK <='1';
			when 110 => CLK <='0';			
			when 111 => CLK <='0';
			when 112 => CLK <='0';
			when 113 => CLK <='0';
			when 114 => CLK <='0';
			when 115 => CLK <='0';
			when 116 => CLK <='0';
			when 117 => CLK <='0';
			when 118 => CLK <='0';
			when 119 => CLK <='0';
--fin de trame de lecture	
			when others => CLK <='0';
			end case;
			if adressMCP > 119
				then adressMCP <= 59;
			end if ;
			end if ;
			GPIO(3) <= CLK;
			GPIO(4) <= SI;
			GPIO(5) <= CSMCP;
			GPIO(6) <= horl100;
			end process MCPTRAM;	
			
			
			
			
			
			
			
			
			
			
			
			
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