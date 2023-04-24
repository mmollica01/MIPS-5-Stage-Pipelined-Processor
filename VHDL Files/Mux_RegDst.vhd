library ieee;
use ieee.std_logic_1164.all;

entity Mux_RegDst is
port ( a0  : in std_logic_vector(4 downto 0);
       a1  : in std_logic_vector(4 downto 0);
		 sel : in std_logic;
		 x   : out std_logic_vector(4 downto 0));
end entity;

architecture Behave of Mux_RegDst is
begin
	process (a0, a1, sel)
	begin
		case sel is
		when '0' => x <= a0;
		when '1' => x <= a1;
		when others => x <= (others => 'X');
	end case;
 end process;
end architecture;