first: 
	iverilog -o test_1 test_1.v main.v data_path.v control_path.v
	./test_1
	gtkwave dump1.vcd
second:
	iverilog -o test_2 test_2.v main.v data_path.v control_path.v
	./test_2
	gtkwave dump2.vcd

