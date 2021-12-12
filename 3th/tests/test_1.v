module test_1();
   reg clk, rst;
   reg [7:0] in;
   reg [2:0] op;
   reg apply;
   wire [7:0] tail;
   wire empty, valid;
   main _main(.clk(clk), .rst(rst), .in(in), .op(op), .apply(apply), .tail(tail), .empty(empty), .valid(valid));
   initial begin
      $dumpfile("dump1.vcd");
      $dumpvars(0, test_1);
      #35
      $finish;
   end
   initial begin
      #2
      rst = 1;
      #2
      rst = 0;
      in = 8'b0000_0001;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0000_0010;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0000_1001;
      apply = 1'b1;
      op = 3'b101;
      #2
      apply = 1'b1;
      op = 3'b000;
      #2
      in = 8'b0000_0000;
      apply = 1'b1;
      op = 3'b101;

      #2
      apply = 1'b1;
      op = 3'b000;
      #2
      apply = 1'b0;
      #2
      in = 8'b0000_0100;
      apply = 1'b1;
      op = 3'b101;
      #2
      in = 8'b0000_0110;
      apply = 1'b1;
      op = 3'b101;

      #2
      apply = 1'b1;
      op = 3'b110;
      #2
      apply = 1'b1;
      op = 3'b000;

      #2
      apply = 1'b1;
      op = 3'b010;
      #2
      apply = 1'b1;
      op = 3'b110;

   end
   initial clk = 0;
   always #1 clk = !clk;
endmodule
   
