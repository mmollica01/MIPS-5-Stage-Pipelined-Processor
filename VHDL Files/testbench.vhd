library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture test of testbench is
-- MIPS Component
component MIPS5 is
port ( SCLK    : in std_logic;
		 RESET   : in std_logic;
		 OUTPUT  : buffer std_logic_vector(31 downto 0));
end component;

-- SIGNALS
signal clock       : std_logic := '0';
signal rst         : std_logic := '0';
signal mux3out     : std_logic_vector(31 downto 0);

-- PORT MAP
begin
	DUT : MIPS5 port map (clock, rst, mux3out);
	
	clock <= not clock after 50ns;

end architecture;