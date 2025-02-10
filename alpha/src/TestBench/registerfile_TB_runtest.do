SetActiveLib -work
comp -include "$dsn\src\RegisterFile.vhd" 
comp -include "$dsn\src\TestBench\registerfile_TB.vhd" 
asim +access +r TESTBENCH_FOR_registerfile 
wave 
wave -noreg Clk
wave -noreg RegWrite
wave -noreg ReadReg1
wave -noreg ReadReg2
wave -noreg WriteReg
wave -noreg WriteData
wave -noreg ReadData1
wave -noreg ReadData2
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\registerfile_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_registerfile 
