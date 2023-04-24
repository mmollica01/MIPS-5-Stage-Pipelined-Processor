library ieee;
use ieee.std_logic_1164.all;

entity reg32 is
port( D   : in std_logic_vector(31 downto 0);
		en  : in std_logic;
		clk : in std_logic;
		Q   : buffer std_logic_vector(31 downto 0) := x"0000000C");
end entity;

architecture Behave of reg32 is
begin
	process (clk, en)
	begin
		if (en = '1') then
			if (rising_edge(clk)) then Q <= D;
			end if;
		elsif (en = '0') then Q <= Q;
		end if;
	end process;
end architecture;