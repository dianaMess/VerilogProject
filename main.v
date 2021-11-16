module main(input clk, input rst, input[7:0] in, input[2:0] op, input apply, output [7:0] tail, output empty, output valid); 
    parameter reg_len = 7, len = 10;
    reg [reg_len:0] array [len:0];
    reg [reg_len:0] tmp;
    reg tmp_empty, tmp_valid;
    reg [reg_len:0] current;
    reg [reg_len:0] count;
    integer i = 0;

    always@(posedge rst, op, posedge clk) begin 
        if (rst) begin
            count = 0;
            tmp_empty <= 1'b1;
            tmp_valid = 1'b1;
            for (i = 0; i < 11; i = i + 1) begin
                array[i] = 8'bxxxx_xxxx;
            end
        end else begin
            if (apply == 1'b1) begin
                case(op)
                    3'b000: begin
                        if (count < 2) begin
                            tmp_valid = 1'b0;
                        end else begin
                            tmp = array[0] + array[1];
                            current = tmp;
                            for (i = 0; i < 9; i = i + 1) begin
                                array[i] = array[i + 2];
                            end
                            array[count - 2] = tmp;
                            count = count - 1;
                        end
                    end
                    3'b001: begin
                        if (count < 2) begin
                            tmp_valid = 1'b0;
                        end else begin
                            tmp = array[1] - array[0];
                            current = tmp;
                            for (i = 0; i < 9; i = i + 1) begin
                                array[i] = array[i + 2];
                            end
                            array[count - 2] = tmp;
                            count = count - 1;
                        end
                    end
                    3'b010: begin
                        if (count < 2) begin
                            tmp_valid = 1'b0;
                        end else begin 
                            tmp = array[1] * array[0];
                            current = tmp;
                            for (i = 0; i < 9; i = i + 1) begin
                                array[i] = array[i + 2];
                            end
                            array[count - 2] = tmp;
                            count = count - 1;
                        end
                    end
                    3'b011: begin
                        if (count < 2) begin
                            tmp_valid = 1'b0;
                        end else begin 
                            if (array[0] == 0)
                                tmp_valid = 1'b0;
                            else begin
                                tmp = array[1] / array[0];
                                current = tmp;
                                for (i = 0; i < 9; i = i + 1) begin
                                    array[i] = array[i + 2];
                                end
                                array[count - 2] = tmp;
                                count = count - 1;
                            end
                        end
                    end
                    3'b100: begin
                        if (count < 2) begin
                            tmp_valid = 1'b0;
                        end else begin
                            if (array[0] == 0)
                                tmp_valid = 1'b0;
                            else begin 
                                tmp = array[1] % array[0];
                                current = tmp;
                                for (i = 0; i < 9; i = i + 1) begin
                                    array[i] = array[i + 2];
                                end
                                array[count - 2] = tmp;
                                count = count - 1;
                            end
                        end
                    end
                    3'b101: begin
                        if (count == 11) 
                            tmp_valid = 1'b0;
                        else begin
                            array[count] = in;
                            current = in;
                            count = count + 1; 
                        end
                    end
                    3'b110: begin
                        if (count < 1) begin
                            tmp_valid = 1'b0;
                        end else begin
                            for (i = 0; i < 10; i = i + 1) begin
                                array[i] = array[i + 1];
                            end
                            current = array[count - 2];
                            count = count - 1;
                        end
                    end
                    default: begin
                        tmp_valid = 1'b0;
                    end
                endcase
                if (count == 0) 
                    tmp_empty <= 1'b1;
                else
                    tmp_empty <= 1'b0;
            end
        end
    end
    assign tail = current;
    assign empty = tmp_empty;
    assign valid = tmp_valid;
endmodule

