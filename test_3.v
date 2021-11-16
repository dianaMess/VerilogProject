module test_3();
   reg clk, rst;
   reg [7:0] in;
   reg [2:0] op;
   reg apply;
   wire [7:0] tail;
   wire empty, valid;
   main _main(.clk(clk), .rst(rst), .in(in), .op(op), .apply(apply), .tail(tail), .empty(empty), .valid(valid));
   initial begin
      $dumpfile("dump3.vcd");
      $dumpvars(0, test_3);
      #45
      $finish;
   end
   initial begin
      #1
      rst = 1;
      #2
      rst = 0;
      in = 8'b0010_0010;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0100_0100;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b1000_0001;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0010_1010;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0010_1101;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0000_1101;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0000_1111;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b1101_1001;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0010_1110;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0111_0001;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0001_1000;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0001_1001;
      apply = 1'b1;
      op = 3'b101; 
      #2
      rst = 1;
      #2
      rst = 0;
      in = 8'b0001_1000;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0001_0001;
      apply = 1'b1;
      op = 3'b101; 
      #2
      in = 8'b1001_1001;
      apply = 1'b1;
      op = 3'b101; 
      #4
      apply = 1'b0;
      #2
      in = 8'b0101_1001;
      apply = 1'b1;
      op = 3'b101;  
      #2
      apply = 1'b1;
      op = 3'b001;
      #2
      apply = 1'b1;
      op = 3'b000;
      #2
      apply = 1'b1;
      op = 3'bxxx;
    end
   initial clk = 0;
   always #1 clk = !clk;
endmodule
   
