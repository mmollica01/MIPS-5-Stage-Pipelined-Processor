library ieee;
use ieee.std_logic_1164.all;

entity EX_MEM is
port ( D_branchAdd 			  : in std_logic_vector(31 downto 0);
		 D_zero      			  : in std_logic;
		 D_ALU       			  : in std_logic_vector(31 downto 0);
		 D_rd2       			  : in std_logic_vector(31 downto 0);
		 D_mux1      			  : in std_logic_vector(4 downto 0);
		 D_Branch    			  : in std_logic;
		 D_RegWrite  			  : in std_logic;
		 D_MemRead, D_MemWrite : in std_logic;
		 D_MemtoReg            : in std_logic;
		 clk     				  : in std_logic;
		 Q_branchAdd 			  : out std_logic_vector(31 downto 0);
		 Q_zero      			  : out std_logic;
		 Q_ALU       			  : out std_logic_vector(31 downto 0);
		 Q_rd2       			  : out std_logic_vector(31 downto 0);
		 Q_mux1      			  : out std_logic_vector(4 downto 0);
		 Q_Branch    			  : out std_logic;
		 Q_RegWrite  			  : out std_logic;
		 Q_MemRead, Q_MemWrite : out std_logic;
		 Q_MemtoReg            : out std_logic);
end entity;

architecture Behave of EX_MEM is
begin
	process (clk)
	begin
		if rising_edge(clk) then
			Q_branchAdd <= D_branchAdd;
			Q_zero      <= D_zero;
			Q_ALU       <= D_ALU;
			Q_rd2       <= D_rd2;
			Q_mux1      <= D_mux1;
			Q_Branch    <= D_Branch;
			Q_RegWrite  <= D_RegWrite;
			Q_MemRead   <= D_MemRead;
			Q_MemWrite  <= D_MemWrite;
			Q_MemtoReg  <= D_MemtoReg;
		end if;
	end process;		
end architecture;