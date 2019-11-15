library ieee ;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;


	
	
	ENTITY Projet_syntetiseur is PORT ( 
      LEDR  : out bit_vector(1 downto 0)
		MAX10_CLK1_50 : in std_logic;
		); 
    END Projet_syntetiseur;
	 
	 
	 
	 
	 
	 ARCHITECTURE fonction of Projet_syntetiseur is 
	 
	 signal compteur : integer range 0 to 105;
	 signal horl100 : std_logic;
	 
	 Begin
	 
			horloge : Process
			begin
			if rising_edge(Max10_clk1_50) 
				then compteur <= compteur +1;
			end if
			
			if compteur > 99 then
				compteur <= 0;
				horl100 <= not horl100;
			end if ;
						
			end horloge;
			
			
			
			
			
	 
	 
	 
	 END fonction;