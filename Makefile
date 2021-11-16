first: 
	iverilog -o test_1 test_1.v main.v
	./test_1
	gtkwave dump1.vcd
second:
	iverilog -o test_2 test_2.v main.v
	./test_2
	gtkwave dump2.vcd
third:
	iverilog -o test_3 test_3.v main.v
	./test_3
	gtkwave dump3.vcd

