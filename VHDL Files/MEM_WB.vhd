library ieee;
use ieee.std_logic_1164.all;

entity MEM_WB is
port ( D_rd   		: in std_logic_vector(31 downto 0);
       D_ALU 	   : in std_logic_vector(31 downto 0);
		 D_mux1 		: in std_logic_vector(4 downto 0);
		 D_RegWrite : in std_logic;
		 D_MemtoReg : in std_logic;
		 clk        : in std_logic;
		 Q_rd   		: out std_logic_vector(31 downto 0);
       Q_ALU 	   : out std_logic_vector(31 downto 0);
		 Q_mux1 		: out std_logic_vector(4 downto 0);
		 Q_RegWrite : out std_logic;
		 Q_MemtoReg : out std_logic);
end entity;

architecture Behave of MEM_WB is
begin
	process (clk)
	begin
		if rising_edge(clk) then
			Q_rd       <= D_rd;
			Q_ALU      <= D_ALU;
			Q_mux1     <= D_mux1;
			Q_RegWrite <= D_RegWrite;
			Q_MemtoReg <= D_MemtoReg;
		end if;
	end process;		
end architecture;