# Project Overview
Single Cycle and Pipelined 32-bit MIPS Processor implementation in VHDL using Intel Quartus Prime and DE10-Lite FPGA. The pipelined implementation has 5 stages:
- Fetch
- Decode
- Execute
- Memory
- Writeback

_Note: This processor does **NOT** have forwarding support_

# Performance Metrics
- Maximum Clock Frequency = **122.73 MHz**
- Setup Slack = **0.852 ns**
- Hold Slack = **0.432 ns**

# Project Organization
- MIPS5.vhd --> Pipelined Implementation
- SCP.vhd   --> Single Cycle Implementation

Both implementations are in the same project file. To select each top-level entity,
1. Open MIPS5.qpf in Quartus
2. In Project Navigator: Files -> Right-click either MIPS5.vhd or SCP.vhd -> Set as Top-level entity
3. In menu bar: Assignments -> Settings -> Simulation -> Compile test bench dropdown -> select appropriate test bench -> OK

# To Run ModelSim
1. Open MIPS5.qpf in Quartus 
2. In menu bar click: Processing -> Start Compilation 
3. After compilation, in menu bar click: Tools -> Run Simulation Tool -> Gate Level Simulation 
4. ModelSim will open, run the simulation, and display the waveform.

# To Deploy on DE10-Lite Board
1. Open MIPS5.qpf in Quartus 
2. In menu bar: Processing -> Start Compilation 
3. In menu bar: Tools -> Programmer 
4. Click "Hardware Setup" 
5. Select "USB Blaster" 
6. Click "Close" 
7. Click "Start" to begin programming

- SW0: Clock input
- HEX2-3: Outputs lower 8-bits of Writeback MUX

# Instruction Set
1. lw $t1, 1($t0) --> 100011 01000 01001 0000000000000001
2. lw $t2, 2($t0) --> 100011 01000 01010 0000000000000010
3. lw $t3, 3($t0) --> 100011 01000 01011 0000000000000011
4. lw $t4, 4($t0) --> 100011 01000 01100 0000000000000100
5. beq $t1, $t2, Equal --> 000100 01010 01001 0000000000000000 
6. add $t1, $t1, $t2   --> 000000 01001 01010 01001 00000 100000
7. sw  $t3, 100($t2)   --> 101011 01010 01011 0000000001100100
8. or  $t1, $t4, $t2   --> 000000 01100 01010 01001 00000 100101

# Project Files
- Add4.vhd          --> Adder entity, increments the PC (PC = PC + 1)
- ALU.vhd           --> ALU entity
- ALU_control.vhd   --> ALU Control Unit entity
- ALU_Mux.vhd       --> Mux entity that selects input to ALU
- branchAdd.vhd     --> Adder entity, shifts and adds bracnch offset
- Control_Unit.vhd  --> Control Unit entity
- Decode32.vhd      --> Decoder entity for Register Unit
- DM.vhd	      --> Data Memory Megafunction
- DM.mif	      --> Data Memory Initialization File
- EX_MEM.vhd 	      --> Execution/Memory Register entity
- ID_EX.vhd	      --> Decode/Execution Register entity
- IF_ID.vhd         --> Fetch/Decode Register entity
- IM.vhd	      --> Instruciton Memory Megafunction
- MEM_WB.vhd        --> Memory/Writeback Register entity
- MIPS5.mif         --> Instruction Memory Initialization File
- MIPS.qpf          --> Intel Quartus Project File
- MIPS5.sdc         --> Synopsys Design Constraint File for Timing Analysis
- MIPS5.vhd         --> Top-level Pipelined Processor
- Mux.vhd           --> 32x1 Mux entity for Register Unit
- Mux_RegDst        --> Register Destination Mux entity
- PC.vhd	      --> Program Counter entity
- reg32.vhd         --> 32-bit register entity for Register Unit
- RU.vhd            --> Register Unit entity
- SCP.vhd           --> Top-level Single Cycle Processor
- signExtend.vhd    --> Sign Extension entity
- testbench.vhd     --> Testbench for Pipelined Processor
- testbench_scp.vhd --> Testbench for Single Cycle Processor
- TB_Board.vhd      --> Testbench for DE10-Lite demonstration
- BCDto7.vhd        --> DE10-Lite 7-segment display entity

# Acknowledgements
Special thanks to [Nidhay Patel](https://www.linkedin.com/in/nidhay-patel-38662223a/) for partnering on this project.
