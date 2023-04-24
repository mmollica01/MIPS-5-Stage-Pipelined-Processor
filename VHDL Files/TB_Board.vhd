library IEEE;
use IEEE.std_logic_1164.all;

entity TB_board is
	port ( 
	
			 sw0 :in std_logic;										-- sw1,sw2,sw3,sw4 :in std_logic;
																			--	 hex0 : out std_logic_vector(6 downto 0);
			 sw1 : in std_logic;																--	 hex1 : out std_logic_vector(6 downto 0);
			 hex2 : out std_logic_vector(6 downto 0);
			 hex3 : out std_logic_vector(6 downto 0)
																			--    hex4 : out std_logic_vector(6 downto 0);
																			--	 hex5 : out std_logic_vector(6 downto 0)
			 
			);
		 
		
end TB_board;

architecture TB_board_architecture of TB_board is

					component BCDto7 is
								port( Input : in STD_LOGIC_VECTOR(3 DOWNTO 0);
										Output: out STD_LOGIC_VECTOR(6 DOWNTO 0));
					end component BCDto7;
					
					component MIPS5 is
							port ( SCLK    : in std_logic;
									 RESET   : in std_logic;
									 OUTPUT  : buffer std_logic_vector(31 downto 0));
					end component MIPS5;
		
		signal TB_output : std_logic_vector(31 downto 0);
		
		begin	
				
				
				DUT1: MIPS5 port map(sw0, '0', TB_output);
				DUT2: BCDto7 port map(TB_output(7 downto 4),hex3);
				DUT3: BCDto7 port map(TB_output(3 downto 0),hex2);
			
end architecture;
		
				
	

		
		
		