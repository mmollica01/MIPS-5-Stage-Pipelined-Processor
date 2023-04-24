library ieee;
use ieee.std_logic_1164.all;

entity testbench_scp is
end entity;

architecture test of testbench_scp is
-- SCP Component
component SCP is
port ( SCLK    : in std_logic;
		 RST     : in std_logic;
		 OUTPUT  : buffer std_logic_vector(31 downto 0));
end component;

-- SIGNALS
signal clock       : std_logic := '0';
signal rst         : std_logic := '0';
signal mux3out     : std_logic_vector(31 downto 0);

-- PORT MAP
begin
	DUT : SCP port map (clock, rst, mux3out);
	
	clock <= not clock after 100ns;

end architecture;