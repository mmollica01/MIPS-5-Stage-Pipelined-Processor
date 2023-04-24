library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Entity ALU is

				PORT (
							input1           : in  std_logic_vector (31 DOWNTO 0);
							input2           : in  std_logic_vector (31 DOWNTO 0);
							alu_operation	  : in  std_logic_vector (3 DOWNTO 0);
							alu_result   	  : buffer std_logic_vector (31 DOWNTO 0);
							zero_flag        : buffer std_logic
						);
						
End ALU;

Architecture ALU_architecture of ALU is
	
	-- SIGNAL alu_output : STD_LOGIC_VECTOR (31 DOWNTO 0);

	Begin
			
			Process (input1, input2, alu_operation)
			begin
					case alu_operation is
													
							When "0000" =>									-- Bitwise and
									alu_result <= input1 AND input2;
																	
																	
							When "0001" =>
									alu_result <= input1 OR input2;					-- Bitwise or
									
						
							When "0010" =>									-- addition
									alu_result <= std_logic_vector(unsigned(input1) + unsigned(input2));
									
						
							When "0110" =>									-- subtract
									alu_result <= std_logic_vector(unsigned(input1) - unsigned(input2));
						
						
							When "0111" =>									-- set less is to be done as XOR (as per the pdf)
									alu_result <= input1 XOR input2;
																				
																				
							WHEN "1100" =>									-- Bitwise NOR
									alu_result <= input1 NOR input2;
																				
							WHEN others => NULL;							-- Nop
									alu_result <= x"00000000";
					End Case;

			End Process;
	
	zero_flag <= '1' WHEN alu_result = x"00000000" 
	else
	        '0';

			  
End architecture ALU_architecture;