proc:
	iverilog -o test_bench alu.v instr.v reg.v pc.v dmem.v control_path.v data_path.v main.v test_bench.v 
	./test_bench
	gtkwave dump.vcd
