library ieee ;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;


	
	
	ENTITY synthetiseur is PORT ( 
      LEDR : out bit_vector (1 downto 0);
		MAX10_CLK1_50 : in std_logic;
		KEY : in  bit_vector(1 downto 0);
		SW : in std_logic_vector(9 downto 0);
		GPIO : buffer std_logic_vector (5 downto 0)
		); 
    END synthetiseur;
	 
	 
	 
	 
	 
	 ARCHITECTURE fonction of synthetiseur is 
	 
	 signal compteur : integer range 0 to 105;
	 signal horl100 : std_logic;
	 Signal adressfal : integer range 0 to 43;
	 Signal SDI : std_logic;
	 Signal CS : std_logic;
	 Signal SCK : std_logic;
	 
	 
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
			
			

			test : Process(horl100)
			
			begin
			if rising_edge(horl100)
			then adressfal <= adressfal + 1;
				case adressfal is
				when 0 => CS <= '0'; SDI <= '1';   --choix de la voie B
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
				when 31 => SCK <= '1'; CS <= '0';
				when 32 => SCK <= '0';
				when 33 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 34 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 35 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 36 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 37 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 38 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 39 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 40 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 41 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 42 => SCK <= '0'; SDI <= '0'; CS <= '1';
				when 43 => SCK <= '0'; SDI <= '0'; CS <= '1'; adressfal <= 0;
				when others => SCK <= '0';

				end case;
				end if;
			GPIO(0) <= SCK;
			GPIO(1) <= SDI;
			GPIO(2) <= CS;
			end process test;
	 
	 END architecture;