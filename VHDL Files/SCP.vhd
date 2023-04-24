library ieee;
use ieee.std_logic_1164.all;
-- Single Cycle Processor NO FORWARDING
entity SCP is
port ( SCLK    : in std_logic;
		 RST     : in std_logic;
		 OUTPUT  : buffer std_logic_vector(31 downto 0));
end entity;

architecture Structural of SCP is
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
-- ***********************************************************SIGNALS
signal PCout            : std_logic_vector(31 downto 0);
signal Add4out          : std_logic_vector(31 downto 0);
signal IMout            : std_logic_vector(31 downto 0);
signal Control_regdst   : std_logic;
signal Control_branch   : std_logic;
signal Control_regwrite : std_logic;
signal Control_alusrc   : std_logic;
signal Control_memread  : std_logic;
signal Control_memwrite : std_logic;
signal Control_memtoreg : std_logic;
signal Control_aluop    : std_logic_vector(1 downto 0);
signal MUX1out          : std_logic_vector(4 downto 0);
signal MUX2out          : std_logic_vector(31 downto 0);
signal MUX3out          : std_logic_vector(31 downto 0);
signal MUX4out          : std_logic_vector(31 downto 0);
signal RUout1           : std_logic_vector(31 downto 0);
signal RUout2           : std_logic_vector(31 downto 0);
signal SignExtendout    : std_Logic_vector(31 downto 0);
signal ALUControlout    : std_logic_vector(3 downto 0);
signal ALUout           : std_logic_vector(31 downto 0);
signal ALUzero          : std_logic;
signal branchAddout     : std_logic_vector(31 downto 0);
signal DMout            : std_logic_vector(31 downto 0);
-- ***********************************************************
-- ***********************************************************PORT MAPPING
begin
	PC0      : PC port map (MUX4out, SCLK, PCout);
	ADD0     : Add4 port map (PCout, Add4out);
	IM0      : IM port map (RST, PCout(7 downto 0), SCLK, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", '0', IMout);
	MUX1     : Mux_RegDst port map (IMout(20 downto 16), IMout(15 downto 11), Control_regdst, MUX1out);
	CNTRL    : Control_Unit port map (IMout(31 downto 26), Control_regdst, Control_branch, Control_regwrite, Control_alusrc,
	                               Control_memread, Control_memwrite, Control_memtoreg, Control_aluop);
	RU0      : RU port map (IMout(25 downto 21), IMout(20 downto 16), Control_regwrite, MUX1out, OUTPUT, SCLK, RUout1, RUout2);
	SGNEX    : signExtend port map (IMout(15 downto 0), SignExtendout);
	MUX2     : ALU_Mux port map (RUout2, SignExtendout, Control_alusrc, MUX2out);
	ALUCntrl : ALU_Control port map (IMout(5 downto 0), Control_aluop, ALUControlout);
	ALU0     : ALU port map (RUout1, MUX2out, ALUControlout, ALUout, ALUzero);
	ADD1     : branchAdd port map (Add4out, SignExtendout, branchAddout);
	MUX4     : ALU_Mux port map (Add4out, branchAddout, Control_branch and ALUzero, MUX4out);
	DM0      : DM port map (ALUout(7 downto 0), not SCLK, RUout2, Control_memread, Control_memwrite, DMout);
	MUX3     : ALU_Mux port map (ALUout, DMout, Control_memtoreg, OUTPUT);
end architecture; 