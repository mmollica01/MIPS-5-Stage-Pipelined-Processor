library ieee;
use ieee.std_logic_1164.all;

entity Control_Unit is
port ( opcode            : in std_logic_vector(5 downto 0);
		 Regdst            : out std_logic;
		 Branch            : out std_logic;
		 RegWrite          : out std_logic;
		 ALUSrc            : out std_logic;
		 MemRead, MemWrite : out std_logic;
		 MemtoReg          : out std_logic;
		 ALUOp             : out std_logic_vector(1 downto 0));
end entity;

architecture Behave of Control_Unit is
begin
	process (opcode)
	begin
		case opcode is
			-- R-type
			when "000000" => Regdst <= '1'; Branch <= '0'; RegWrite <= '1';
								  ALUSrc <= '0'; MemRead <= '0'; MemWrite <= '0';
								  MemtoReg <= '0'; ALUOp <= "10";
			-- LW
			when "100011" => Regdst <= '0'; Branch <= '0'; RegWrite <= '1';
								  ALUSrc <= '1'; MemRead <= '1'; MemWrite <= '0';
								  MemtoReg <= '1'; ALUOp <= "00";
			-- SW
			when "101011" => Regdst <= 'X'; Branch <= '0'; RegWrite <= '0';
								  ALUSrc <= '1'; MemRead <= '0'; MemWrite <= '1';
								  MemtoReg <= 'X'; ALUOp <= "00";
			-- BEQ
			when "000100" => Regdst <= 'X'; Branch <= '1'; RegWrite <= '0';
								  ALUSrc <= '0'; MemRead <= '0'; MemWrite <= '0';
								  MemtoReg <= 'X'; ALUOp <= "01";
			when others   => Regdst <= '0'; Branch <= '0'; RegWrite <= '0';
								  ALUSrc <= '0'; MemRead <= '0'; MemWrite <= '0';
								  MemtoReg <= '0'; ALUOp <= "00";
		end case;
	end process;
end architecture;
		 