library ieee;
use ieee.std_logic_1164.all;
-- MIPS 5-stage Pipelined Processor
entity MIPS5 is
port ( SCLK    : in std_logic;
		 RESET   : in std_logic;
		 OUTPUT  : buffer std_logic_vector(31 downto 0));
end entity;

architecture Structural of MIPS5 is
-- ***********************************************************PHASE3 COMPONENTS
-- Control Unit
component Control_Unit is
port ( opcode            : in std_logic_vector(5 downto 0);
		 Regdst            : out std_logic;
		 Branch            : out std_logic;
		 RegWrite          : out std_logic;
		 ALUSrc            : out std_logic;
		 MemRead, MemWrite : out std_logic;
		 MemtoReg          : out std_logic;
		 ALUOp             : out std_logic_vector(1 downto 0));
end component;

-- ALU Control Unit
component ALU_Control is
port ( funct   : in std_logic_vector(5 downto 0);
		 ALUOp   : in std_logic_vector(1 downto 0);
		 control : out std_logic_vector(3 downto 0));
end component;

-- branchAdd
component branchAdd is
port ( PC        : in std_logic_vector(31 downto 0);
		 Immediate : in std_logic_vector(31 downto 0);
		 output    : out std_logic_vector(31 downto 0));
end component;

-- Data Memory Unit
component DM is
	port
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;
-- ***********************************************************
-- ***********************************************************PHASE2 COMPONENTS
--REGISTER UNIT
component RU is
port ( readReg1  : in std_logic_vector(4 downto 0);
		 readReg2  : in std_logic_vector(4 downto 0);
		 writeEn   : in std_logic;
		 regNum    : in std_logic_vector(4 downto 0);
		 regData   : in std_logic_vector(31 downto 0);
		 clk       : in std_logic;
		 readData1 : buffer std_logic_vector(31 downto 0);
		 readData2 : buffer std_logic_vector(31 downto 0));
end component;
-- REGDST MUX
component Mux_RegDst is
port ( a0  : in std_logic_vector(4 downto 0);
       a1  : in std_logic_vector(4 downto 0);
		 sel : in std_logic;
		 x   : out std_logic_vector(4 downto 0));
end component;
-- SIGN EXTENSION
component signExtend is
port ( input  : in std_logic_vector(15 downto 0);
		 output : out std_logic_vector(31 downto 0));
end component;
-- ALU MUX
component ALU_Mux is
port ( a0  : in std_logic_vector(31 downto 0);
       a1  : in std_logic_vector(31 downto 0);
		 sel : in std_logic;
		 x   : out std_logic_vector(31 downto 0));
end component;
-- ALU
component ALU is
port ( input1        : in  std_logic_vector (31 DOWNTO 0);
		 input2        : in  std_logic_vector (31 DOWNTO 0);
		 alu_operation : in  std_logic_vector (3 DOWNTO 0);
		 alu_result   	: buffer std_logic_vector (31 DOWNTO 0);
		 zero_flag     : buffer std_logic);						
end component;
 -- ***********************************************************
 -- ***********************************************************PHASE1 COMPONENTS
 -- Program Counter
component PC is 
port( pc_in : in std_logic_vector(31 downto 0);
      clk   : in std_logic;
      pc_out: out std_logic_vector(31 downto 0) := x"00000000"
    );
end component;

-- PC Adder
component Add4 is 
port( x_in  : in std_logic_vector(31 downto 0);
      z_out : out std_logic_vector(31 downto 0) 
    );
end component;

-- Instruction Memory
component IM is
	port
	(
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;
-- ***********************************************************
-- ***********************************************************INTERMEDIATE REGISTERS
-- IF/ID
component IF_ID is
port ( D_pc : in std_logic_vector(31 downto 0);
       D_im : in std_logic_vector(31 downto 0);
		 clk  : in std_logic;
		 Q_pc : out std_logic_vector(31 downto 0);
		 Q_im : out std_logic_vector(31 downto 0));
end component;

-- ID/EX
component ID_EX is
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
end component;

-- EX/MEM
component EX_MEM is
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
end component;

-- MEM/WB
component MEM_WB is
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
end component;
-- ***********************************************************
-- ***********************************************************SIGNALS
signal Mux1out 			  : std_logic_vector(4 downto 0);
signal Mux2out 			  : std_logic_vector(31 downto 0);
signal Mux3out 			  : std_logic_vector(31 downto 0);
signal Mux4out 			  : std_logic_vector(31 downto 0);
signal PCout   			  : std_logic_vector(31 downto 0);
signal Add4out 			  : std_logic_vector(31 downto 0);
signal IMout   			  : std_logic_vector(31 downto 0);
signal IFID_pc 			  : std_logic_vector(31 downto 0);
signal IFID_im 			  : std_logic_vector(31 downto 0);
signal IDEX_pc            : std_logic_vector(31 downto 0);
signal IDEX_rd1, IDEX_rd2 : std_logic_vector(31 downto 0);
signal IDEX_se            : std_logic_vector(31 downto 0);
signal IDEX_ins2016       : std_logic_vector(4 downto 0);
signal IDEX_ins1511       : std_logic_vector(4 downto 0);
signal IDEX_regdst        : std_logic;
signal IDEX_branch        : std_logic;
signal IDEX_regwrite      : std_logic;
signal IDEX_alusrc        : std_logic;
signal IDEX_memread       : std_logic;
signal IDEX_memwrite      : std_logic;
signal IDEX_memtoreg      : std_logic;
signal IDEX_aluop         : std_logic_vector(1 downto 0);
signal EXMEM_branchAdd    : std_logic_vector(31 downto 0);
signal EXMEM_zero         : std_logic;
signal EXMEM_ALU          : std_logic_vector(31 downto 0);
signal EXMEM_rd2          : std_logic_vector(31 downto 0);
signal EXMEM_mux1         : std_logic_vector(4 downto 0);
signal EXMEM_branch       : std_logic;
signal EXMEM_regwrite     : std_logic;
signal EXMEM_memread      : std_logic;
signal EXMEM_memwrite     : std_logic;
signal EXMEM_memtoreg     : std_logic;
signal Control_regwrite   : std_logic;
signal Control_regdst     : std_logic;
signal Control_branch     : std_logic;
signal Control_alusrc     : std_logic;
signal Control_memread    : std_logic;
signal Control_memwrite   : std_logic;
signal Control_memtoreg   : std_logic;
signal Control_aluop      : std_logic_vector(1 downto 0);
signal MEMWB_rd           : std_logic_vector(31 downto 0);
signal MEMWB_ALU          : std_logic_vector(31 downto 0);
signal MEMWB_mux1         : std_logic_vector(4 downto 0);
signal MEMWB_regwrite     : std_logic;
signal MEMWB_memtoreg     : std_logic;
signal RU_rd1, RU_rd2     : std_logic_vector(31 downto 0);
signal SEout              : std_logic_vector(31 downto 0);
signal branchAddout       : std_logic_vector(31 downto 0);
signal ALU_control_out    : std_logic_vector(3 downto 0);
signal ALUout             : std_logic_vector(31 downto 0);
signal ALUzero            : std_logic;
signal DMout              : std_logic_vector(31 downto 0);
-- ***********************************************************
-- ***********************************************************PORT MAPPING
begin
	PC0       : PC port map (Mux4out, SCLK, PCout);
	ADD0      : Add4 port map (PCout, Add4out);
	IM0       : IM port map (RESET, PCout(7 downto 0), SCLK, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", '0', IMout);
	IFID      : IF_ID port map (Add4out, IMout, SCLK, IFID_pc, IFID_im);
	RU0       : RU port map (IFID_im(25 downto 21), IFID_im(20 downto 16), MEMWB_regwrite, MEMWB_mux1, OUTPUT, SCLK, RU_rd1, RU_rd2);
	SE0       : signExtend port map (IFID_im(15 downto 0), SEout);
	CNTRL     : Control_Unit port map (IFID_im(31 downto 26), Control_regdst, Control_branch, Control_regwrite, Control_alusrc, Control_memread, 
											 Control_memwrite, Control_memtoreg, Control_aluop);
	IDEX      : ID_EX port map (IFID_pc, RU_rd1, RU_rd2, SEout, IFID_im(20 downto 16), IFID_im(15 downto 11), SCLK, Control_regdst, Control_branch, 
									Control_regwrite, Control_alusrc, Control_memread, Control_memwrite, Control_memtoreg, Control_aluop, IDEX_pc, IDEX_rd1,
								   IDEX_rd2, IDEX_se, IDEX_ins2016, IDEX_ins1511, IDEX_regdst, IDEX_branch, IDEX_regwrite, IDEX_alusrc, IDEX_memread, 
								   IDEX_memwrite, IDEX_memtoreg, IDEX_aluop);
	MUX1  	 : Mux_RegDst port map (IDEX_ins2016, IDEX_ins1511, IDEX_regdst, Mux1out);
   MUX2      : ALU_Mux port map (IDEX_rd2, IDEX_se, IDEX_alusrc, Mux2out);
	ADD1      : branchAdd port map (IDEX_pc, IDEX_se, branchAddout);
	ALU_CNTRL : ALU_Control port map (IDEX_se(5 downto 0), IDEX_aluop, ALU_control_out);
	ALU0      : ALU port map (IDEX_rd1, Mux2out, ALU_control_out, ALUout, ALUzero);
   EXMEM     : EX_MEM port map (branchAddout, ALUzero, ALUout, IDEX_rd2, Mux1out, IDEX_branch, IDEX_regwrite, IDEX_memread, IDEX_memwrite, 
										  IDEX_memtoreg, SCLK, EXMEM_branchAdd, EXMEM_zero, EXMEM_ALU, EXMEM_rd2, EXMEM_mux1, EXMEM_branch, EXMEM_regwrite,
										  EXMEM_memread, EXMEM_memwrite, EXMEM_memtoreg);
	DM0       : DM port map (EXMEM_ALU(7 downto 0), not SCLK, EXMEM_rd2, EXMEM_memread, EXMEM_memwrite, DMout);
   MUX4      : ALU_Mux port map (Add4out, EXMEM_branchAdd, EXMEM_zero and EXMEM_branch, Mux4out);
   MEMWB     : MEM_WB port map (DMout, EXMEM_ALU, EXMEM_mux1, EXMEM_regwrite, EXMEM_memtoreg, SCLK, MEMWB_rd, MEMWB_ALU, MEMWB_mux1,
										  MEMWB_regwrite, MEMWB_memtoreg);
	MUX3      : ALU_mux port map (MEMWB_ALU, MEMWB_rd, MEMWB_memtoreg, OUTPUT);
end architecture;