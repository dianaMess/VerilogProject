module main(input clk, input rst, input[7:0] in, input[2:0] op, input apply, output reg [7:0] tail, output reg empty, output reg valid); 
    parameter reg_len = 7, len = 10;
    reg [reg_len:0] array [len:0];
    reg [reg_len:0] count;
    integer i = 0;
    integer op1;
    integer op2;
  
    always@(posedge clk) begin 
        if (rst) begin
            count <= 0;
            empty <= 1'b1;
            valid <= 1'b1;
            for (i = 0; i <= 11; i = i + 1) begin
                array[i] <= 8'bxxxx_xxxx;
            end
        end else begin
            if (apply == 1'b1) begin
                case(op)
                    3'b000: begin
                        if (count < 2) begin
                            valid <= 1'b0;
                        end else begin
                            op1 <= array[0];
                            op2 <= array[1];
                            tail <= array[1] + array[0];
                            #1
                            for (i = 0; i < 9; i = i + 1) begin
                                array[i] <= array[i + 2];
                            end
                            array[count - 2] <= op1 + op2;
                            count <= count - 1;

                        end
                    end
                    3'b001: begin
                        if (count < 2) begin
                            valid <= 1'b0;
                        end else begin
                            op1 <= array[0];
                            op2 <= array[1];
                            tail <= array[1] - array[0];
                            #1
                            for (i = 0; i < 9; i = i + 1) begin
                                array[i] <= array[i + 2];
                            end
                            array[count - 2] <= op2 - op1;
                            count <= count - 1;
                        end
                    end
                    3'b010: begin
                        if (count < 2) begin
                            valid <= 1'b0;
                        end else begin
                            op1 <= array[0];
                            op2 <= array[1];
                            tail <= array[1] * array[0];
                            #1
                            for (i = 0; i < 9; i = i + 1) begin
                                array[i] <= array[i + 2];
                            end
                            array[count - 2] <= op1 * op2;
                            count <= count - 1;
                        end
                    end
                    3'b011: begin
                        if (count < 2)
                            valid <= 1'b0;
                        else begin 
                            if (array[0] == 0)
                                valid <= 1'b0;
                            else begin
                                op1 <= array[0];
                                op2 <= array[1];
                                tail <= array[1] / array[0];
                                #1
                                for (i = 0; i < 9; i = i + 1) begin
                                    array[i] <= array[i + 2];
                                end
                                array[count - 2] <= op2 / op1;
                                count <= count - 1;
                            end
                        end
                    end
                    3'b100: begin
                        if (count < 2) begin
                            valid <= 1'b0;
                        end else begin
                            if (array[0] == 0)
                                valid <= 1'b0;
                            else begin
                                op1 <= array[0];
                                op2 <= array[1];
                                tail <= array[1] % array[0];
                                #1
                                for (i = 0; i < 9; i = i + 1) begin
                                    array[i] <= array[i + 2];
                                end
                                array[count - 2] <= op2 % op1;
                                count <= count - 1;
                            end
                        end
                    end
                    3'b101: begin
                        if (count == 11) 
                            valid <= 1'b0;
                        else begin
                            array[count] <= in;
                            count <= count + 1; 
                            tail <= in;
                            empty <= 1'b0;
                        end
                    end
                    3'b110: begin
                        if (count < 1) begin
                            valid <= 1'b0;
                        end else begin
                            if (count > 1)
                                tail <= array[count - 1];
                            else 
                                tail <= array[count];
                            for (i = 0; i < 10; i = i + 1) begin
                                array[i] <= array[i + 1];
                            end
                            count <= count - 1;
                        end
                    end
                    default: begin
                        valid <= 1'b0;
                    end
                endcase
                if (count == 0) 
                    empty <= 1'b1;
                else
                    empty <= 1'b0;
            end
        end
    end
endmodule

