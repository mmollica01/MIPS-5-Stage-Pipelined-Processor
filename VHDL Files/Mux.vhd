library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


Entity MUX IS

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
End MUX;


Architecture Mux_architecture of MUX is
begin
	process (in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20,
	           in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, sel)
	begin
		case sel is
		when "00000" => mux_output <= in0;
		when "00001" => mux_output <= in1;
		when "00010" => mux_output <= in2;
		when "00011" => mux_output <= in3;
		when "00100" => mux_output <= in4;
		when "00101" => mux_output <= in5;
		when "00110" => mux_output <= in6;
		when "00111" => mux_output <= in7;
		when "01000" => mux_output <= in8;
		when "01001" => mux_output <= in9;
		when "01010" => mux_output <= in10;
		when "01011" => mux_output <= in11;
		when "01100" => mux_output <= in12;
		when "01101" => mux_output <= in13;
		when "01110" => mux_output <= in14;
		when "01111" => mux_output <= in15;
		when "10000" => mux_output <= in16;
		when "10001" => mux_output <= in17;
		when "10010" => mux_output <= in18;
		when "10011" => mux_output <= in19;
		when "10100" => mux_output <= in20;
		when "10101" => mux_output <= in21;
		when "10110" => mux_output <= in22;
		when "10111" => mux_output <= in23;
		when "11000" => mux_output <= in24;
		when "11001" => mux_output <= in25;
		when "11010" => mux_output <= in26;
		when "11011" => mux_output <= in27;
		when "11100" => mux_output <= in28;
		when "11101" => mux_output <= in29;
		when "11110" => mux_output <= in30;
		when "11111" => mux_output <= in31;
		when others => mux_output <= (others => 'X');
	end case;
end process;
End architecture Mux_architecture;