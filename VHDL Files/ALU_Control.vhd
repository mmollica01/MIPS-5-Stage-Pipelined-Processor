library ieee;
use ieee.std_logic_1164.all;

entity ALU_Control is
port ( funct   : in std_logic_vector(5 downto 0);
		 ALUOp   : in std_logic_vector(1 downto 0);
		 control : out std_logic_vector(3 downto 0));
end entity;

architecture Behave of ALU_Control is
begin
	process (ALUOp, funct)
	begin
		if (ALUOp = "10") then
			if (funct = "100000") then control <= "0010";		-- ADD
			elsif (funct = "100010") then control <= "0110";	-- SUB
			elsif (funct = "100100") then control <= "0000";	-- AND
			elsif (funct = "100101") then control <= "0001";	-- OR
			elsif (funct = "101010") then control <= "0111";	-- SLT
			end if;
		elsif (ALUOp = "00") then control <= "0010";				-- LW & SW
		elsif (ALUOp = "01") then control <= "0110";				-- BEQ
		end if;
	end process;
end architecture;