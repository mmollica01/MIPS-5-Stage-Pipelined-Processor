library IEEE;
use IEEE.std_logic_1164.all;

entity BCDto7 is
port( Input : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		Output: out STD_LOGIC_VECTOR(6 DOWNTO 0));
end BCDto7;

architecture BCDto7_arch of BCDto7 is
begin
	process(Input)
	begin	
		case Input is					--abcdefg
			when "0000" => Output <= "0000001";
			when "0001" => Output <= "1001111";
			when "0010" => Output <= "0010010";
			when "0011" => Output <= "0000110";
			when "0100" => Output <= "1001100";
			when "0101" => Output <= "0100100";
			when "0110" => Output <= "0100000";
			when "0111" => Output <= "0001111";
			when "1000" => Output <= "0000000";
			when "1001" => Output <= "0001100";
			when "1010" => Output <= "0001000";
			when "1011" => Output <= "1100000";
			when "1100" => Output <= "0110001";
			when "1101" => Output <= "1000010";
			when "1110" => Output <= "0110000";
			when "1111" => Output <= "0111000";
			when others => Output <= "1111111";	--All off if any other input
		end case;
	end process;
end BCDto7_arch;

