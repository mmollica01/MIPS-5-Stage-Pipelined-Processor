library ieee;
use ieee.std_logic_1164.all;

-- REGISTER UNIT --> Contains Read Unit and Write Unit
entity RU is
port ( readReg1  : in std_logic_vector(4 downto 0);
		 readReg2  : in std_logic_vector(4 downto 0);
		 writeEn   : in std_logic;
		 regNum    : in std_logic_vector(4 downto 0);
		 regData   : in std_logic_vector(31 downto 0);
		 clk       : in std_logic;
		 readData1 : buffer std_logic_vector(31 downto 0);
		 readData2 : buffer std_logic_vector(31 downto 0));
end entity;

architecture Struct of RU is
-- 32x1 Mux component
component MUX IS

		port (
						in0         : IN std_logic_vector(31 DOWNTO 0);
						in1         : IN std_logic_vector(31 DOWNTO 0);
						in2         : IN std_logic_vector(31 DOWNTO 0);
						in3         : IN std_logic_vector(31 DOWNTO 0);
						in4         : IN std_logic_vector(31 DOWNTO 0);
						in5         : IN std_logic_vector(31 DOWNTO 0);
						in6         : IN std_logic_vector(31 DOWNTO 0);
						in7         : IN std_logic_vector(31 DOWNTO 0);
						in8         : IN std_logic_vector(31 DOWNTO 0);
						in9         : IN std_logic_vector(31 DOWNTO 0);
						in10         : IN std_logic_vector(31 DOWNTO 0);
						in11         : IN std_logic_vector(31 DOWNTO 0);
						in12         : IN std_logic_vector(31 DOWNTO 0);
						in13         : IN std_logic_vector(31 DOWNTO 0);
						in14         : IN std_logic_vector(31 DOWNTO 0);
						in15         : IN std_logic_vector(31 DOWNTO 0);
						in16         : IN std_logic_vector(31 DOWNTO 0);
						in17         : IN std_logic_vector(31 DOWNTO 0);
						in18         : IN std_logic_vector(31 DOWNTO 0);
						in19         : IN std_logic_vector(31 DOWNTO 0);
						in20         : IN std_logic_vector(31 DOWNTO 0);
						in21         : IN std_logic_vector(31 DOWNTO 0);
						in22         : IN std_logic_vector(31 DOWNTO 0);
						in23         : IN std_logic_vector(31 DOWNTO 0);
						in24         : IN std_logic_vector(31 DOWNTO 0);
						in25         : IN std_logic_vector(31 DOWNTO 0);
						in26         : IN std_logic_vector(31 DOWNTO 0);
						in27         : IN std_logic_vector(31 DOWNTO 0);
						in28         : IN std_logic_vector(31 DOWNTO 0);
						in29         : IN std_logic_vector(31 DOWNTO 0);
						in30         : IN std_logic_vector(31 DOWNTO 0);
						in31         : IN std_logic_vector(31 DOWNTO 0);
						sel          : IN std_logic_vector(4 DOWNTO 0);
						mux_output  : buffer STD_logic_vector(31 DOWNTO 0)
				);
End component;

-- 5x32 Decoder component
component Decode32 is
port ( num : in std_logic_vector(4 downto 0);
		 output : out std_logic_vector(31 downto 0));
end component;

-- 32-bit Register component
component reg32 is
port( D   : in std_logic_vector(31 downto 0);
		en  : in std_logic;
		clk : in std_logic;
		Q   : buffer std_logic_vector(31 downto 0));
end component;

-- SIGNALS
signal decoder_out  : std_logic_vector(31 downto 0);
signal r0_out       : std_logic_vector(31 downto 0);
signal r1_out       : std_logic_vector(31 downto 0);
signal r2_out       : std_logic_vector(31 downto 0);
signal r3_out       : std_logic_vector(31 downto 0);
signal r4_out       : std_logic_vector(31 downto 0);
signal r5_out       : std_logic_vector(31 downto 0);
signal r6_out       : std_logic_vector(31 downto 0);
signal r7_out       : std_logic_vector(31 downto 0);
signal r8_out       : std_logic_vector(31 downto 0);
signal r9_out       : std_logic_vector(31 downto 0);
signal r10_out      : std_logic_vector(31 downto 0);
signal r11_out      : std_logic_vector(31 downto 0);
signal r12_out      : std_logic_vector(31 downto 0);
signal r13_out      : std_logic_vector(31 downto 0);
signal r14_out      : std_logic_vector(31 downto 0);
signal r15_out      : std_logic_vector(31 downto 0);
signal r16_out      : std_logic_vector(31 downto 0);
signal r17_out      : std_logic_vector(31 downto 0);
signal r18_out      : std_logic_vector(31 downto 0);
signal r19_out      : std_logic_vector(31 downto 0);
signal r20_out      : std_logic_vector(31 downto 0);
signal r21_out      : std_logic_vector(31 downto 0);
signal r22_out      : std_logic_vector(31 downto 0);
signal r23_out      : std_logic_vector(31 downto 0);
signal r24_out      : std_logic_vector(31 downto 0);
signal r25_out      : std_logic_vector(31 downto 0);
signal r26_out      : std_logic_vector(31 downto 0);
signal r27_out      : std_logic_vector(31 downto 0);
signal r28_out      : std_logic_vector(31 downto 0);
signal r29_out      : std_logic_vector(31 downto 0);
signal r30_out      : std_logic_vector(31 downto 0);
signal r31_out      : std_logic_vector(31 downto 0);

signal e0           : std_logic;
signal e1           : std_logic;
signal e2           : std_logic;
signal e3           : std_logic;
signal e4           : std_logic;
signal e5           : std_logic;
signal e6           : std_logic;
signal e7           : std_logic;
signal e8           : std_logic;
signal e9           : std_logic;
signal e10           : std_logic;
signal e11           : std_logic;
signal e12           : std_logic;
signal e13           : std_logic;
signal e14           : std_logic;
signal e15           : std_logic;
signal e16           : std_logic;
signal e17           : std_logic;
signal e18           : std_logic;
signal e19           : std_logic;
signal e20           : std_logic;
signal e21           : std_logic;
signal e22           : std_logic;
signal e23           : std_logic;
signal e24           : std_logic;
signal e25           : std_logic;
signal e26           : std_logic;
signal e27           : std_logic;
signal e28          : std_logic;
signal e29           : std_logic;
signal e30           : std_logic;
signal e31           : std_logic;


-- PORT MAPPING
begin
	e0 <= writeEn and decoder_out(0);
	e1 <= writeEn and decoder_out(1);
	e2 <= writeEn and decoder_out(2);
	e3 <= writeEn and decoder_out(3);
	e4 <= writeEn and decoder_out(4);
	e5 <= writeEn and decoder_out(5);
	e6 <= writeEn and decoder_out(6);
	e7 <= writeEn and decoder_out(7);
	e8 <= writeEn and decoder_out(8);
	e9 <= writeEn and decoder_out(9);
	e10 <= writeEn and decoder_out(10);
	e11 <= writeEn and decoder_out(11);
	e12 <= writeEn and decoder_out(12);
	e13 <= writeEn and decoder_out(13);
	e14 <= writeEn and decoder_out(14);
	e15 <= writeEn and decoder_out(15);
	e16 <= writeEn and decoder_out(16);
	e17 <= writeEn and decoder_out(17);
	e18 <= writeEn and decoder_out(18);
	e19 <= writeEn and decoder_out(19);
	e20 <= writeEn and decoder_out(20);
	e21 <= writeEn and decoder_out(21);
	e22 <= writeEn and decoder_out(22);
	e23 <= writeEn and decoder_out(23);
	e24 <= writeEn and decoder_out(24);
	e25 <= writeEn and decoder_out(25);
	e26 <= writeEn and decoder_out(26);
	e27 <= writeEn and decoder_out(27);
	e28 <= writeEn and decoder_out(28);
	e29 <= writeEn and decoder_out(29);
	e30 <= writeEn and decoder_out(30);
	e31 <= writeEn and decoder_out(31);
	
	
	DEC0  : Decode32 port map (regNum, decoder_out);
	R0    : reg32 port map (x"00000000", e0, clk, r0_out);
	R1    : reg32 port map (regData, e1, clk, r1_out);
	R2    : reg32 port map (regData, e2, clk, r2_out);
	R3    : reg32 port map (regData, e3, clk, r3_out);
	R4    : reg32 port map (regData, e4, clk, r4_out);
	R5    : reg32 port map (regData, e5, clk, r5_out);
	R6    : reg32 port map (regData, e6, clk, r6_out);
	R7    : reg32 port map (regData, e7, clk, r7_out);
	R8    : reg32 port map (regData, e8, clk, r8_out);
	R9    : reg32 port map (regData, e9, clk, r9_out);
	R10   : reg32 port map (regData, e10, clk, r10_out);
	R11   : reg32 port map (regData, e11, clk, r11_out);
	R12   : reg32 port map (regData, e12, clk, r12_out);
	R13   : reg32 port map (regData, e13, clk, r13_out);
	R14   : reg32 port map (regData, e14, clk, r14_out);
	R15   : reg32 port map (regData, e15, clk, r15_out);
	R16   : reg32 port map (regData, e16, clk, r16_out);
	R17   : reg32 port map (regData, e17, clk, r17_out);
	R18   : reg32 port map (regData, e18, clk, r18_out);
	R19   : reg32 port map (regData, e19, clk, r19_out);
	R20   : reg32 port map (regData, e20, clk, r20_out);
	R21   : reg32 port map (regData, e21, clk, r21_out);
	R22   : reg32 port map (regData, e22, clk, r22_out);
	R23   : reg32 port map (regData, e23, clk, r23_out);
	R24   : reg32 port map (regData, e24, clk, r24_out);
	R25   : reg32 port map (regData, e25, clk, r25_out);
	R26   : reg32 port map (regData, e26, clk, r26_out);
	R27   : reg32 port map (regData, e27, clk, r27_out);
	R28   : reg32 port map (regData, e28, clk, r28_out);
	R29   : reg32 port map (regData, e29, clk, r29_out);
	R30   : reg32 port map (regData, e30, clk, r30_out);
	R31   : reg32 port map (regData, e31, clk, r31_out);
	M0    : MUX port map (r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, r10_out, r11_out, r12_out,
								 r13_out, r14_out, r15_out, r16_out, r17_out, r18_out, r19_out, r20_out, r21_out, r22_out, r23_out, r24_out,
								 r25_out, r26_out, r27_out, r28_out, r29_out, r30_out, r31_out, readReg1, readData1);
	M1    : MUX port map (r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, r10_out, r11_out, r12_out,
								 r13_out, r14_out, r15_out, r16_out, r17_out, r18_out, r19_out, r20_out, r21_out, r22_out, r23_out, r24_out,
								 r25_out, r26_out, r27_out, r28_out, r29_out, r30_out, r31_out, readReg2, readData2);
end architecture;
	