library ieee;
use ieee.std_logic_1164.all;

entity ID_EX is
port ( D_pc      				  : in std_Logic_vector(31 downto 0);
		 D_rd1     				  : in std_logic_vector(31 downto 0);
		 D_rd2     				  : in std_logic_vector(31 downto 0);
		 D_se      				  : in std_Logic_vector(31 downto 0);
		 D_ins2016 				  : in std_logic_vector(4 downto 0);
		 D_ins1511             : in std_logic_vector(4 downto 0);
		 clk                   : in std_logic;
		 D_Regdst              : in std_logic;
		 D_Branch              : in std_logic;
		 D_RegWrite            : in std_logic;
		 D_ALUSrc              : in std_logic;
		 D_MemRead, D_MemWrite : in std_logic;
		 D_MemtoReg            : in std_logic;
		 D_ALUOp               : in std_logic_vector(1 downto 0);
		 Q_pc      				  : out std_Logic_vector(31 downto 0);
		 Q_rd1     				  : out std_logic_vector(31 downto 0);
		 Q_rd2     				  : out std_logic_vector(31 downto 0);
		 Q_se      				  : out std_Logic_vector(31 downto 0);
		 Q_ins2016 				  : out std_logic_vector(4 downto 0);
		 Q_ins1511             : out std_logic_vector(4 downto 0);
		 Q_Regdst              : out std_logic;
		 Q_Branch              : out std_logic;
		 Q_RegWrite            : out std_logic;
		 Q_ALUSrc              : out std_logic;
		 Q_MemRead, Q_MemWrite : out std_logic;
		 Q_MemtoReg            : out std_logic;
		 Q_ALUOp               : out std_logic_vector(1 downto 0));
end entity;

architecture Behave of ID_EX is
begin
	process (clk)
	begin
		if rising_edge(clk) then
			Q_pc       <= D_pc;
			Q_rd1      <= D_rd1;
			Q_rd2      <= D_rd2;
			Q_se       <= D_se;
			Q_ins2016  <= D_ins2016;
	      Q_ins1511  <= D_ins1511;
			Q_Regdst   <= D_Regdst;
			Q_Branch   <= D_Branch;
			Q_RegWrite <= D_RegWrite;
			Q_ALUSrc   <= D_ALUSrc;
			Q_MemRead  <= D_MemRead;
			Q_MemWrite <= D_MemWrite;
			Q_MemtoReg <= D_MemtoReg;
			Q_ALUOp    <= D_ALUOp;
		end if;
	end process;		
end architecture;