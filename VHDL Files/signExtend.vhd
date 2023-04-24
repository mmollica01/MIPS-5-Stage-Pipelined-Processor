library ieee;
use ieee.std_logic_1164.all;

entity signExtend is
port ( input  : in std_logic_vector(15 downto 0);
		 output : out std_logic_vector(31 downto 0));
end entity;

architecture Behave of signExtend is
begin
	process (input)
	begin
		if (input(15) = '1') then output <= "1111111111111111"&input;
		else output <= "0000000000000000"&input;
		end if;
	end process;
end architecture;