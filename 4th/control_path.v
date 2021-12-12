// Имена новых управляющих портов добавить после соответствующего комментария в первой строке объявления модуля.
// Сами объявления дописывать под соответствующим комментарием после имеющихся объявлений портов. Комментарий не стирать.
// Реализацию управляющего автомата дописывать под соответствующим комментарием в конце модуля. Комментарий не стирать.
// По необходимости можно раскомментировать ключевые слова "reg" в объявлениях портов.
module control_path(
  on, start, regime, active, y_select_next, s_step, y_en, s_en, y_store_x, s_add, s_zero,
  clk, rst,
  /* , ... (ИМЕНА НОВЫХ УПРАВЛЯЮЩИХ ПОРТОВ */
  flag
);
  input [1:0] on;
  input start, clk, rst;
  output reg [1:0] regime;
  output reg active;
  output reg [1:0] y_select_next;
  output reg [1:0] s_step;
  output reg y_en;
  output reg s_en;
  output reg y_store_x;
  output reg s_add;
  output reg s_zero;
  /* ОБЪЯВЛЕНИЯ НОВЫХ УПРАВЛЯЮЩИХ ПОРТОВ */
  input wire flag;
  localparam FIRST = 0, SECOND = 1, THIRD = 2, FOURTH = 3;
  reg [1:0] state, next_state;
  reg [3:0] timer, next_timer;
  
  /* КОД УПРАВЛЯЮЩЕГО АВТОМАТА */
  always@(posedge clk, posedge rst) begin
      if(rst) begin 
          state <= FIRST;
          timer <= 0;
      end else if (timer == 0) begin
          state <= next_state;
          timer <= next_timer;
      end else begin
          if (active == 1 || state == FOURTH)
              timer <= timer - 1;
          else 
              timer <= timer;
      end
  end
  
  always@* begin
      next_timer <= 0;
      if (next_state == SECOND)
          next_timer <= 13;
      else if (next_state == FOURTH)
          next_timer <= 3;        
  end
  always@* begin
      regime <= state;
      case(state)
          FIRST:
              if (on == 2'b00)
                  next_state <= FIRST;
              else if (on == 2'b01)
                  next_state <= SECOND;
              else if (on == 2'b10)
                  next_state <= THIRD;
              else if (on == 2'b11) 
                  next_state <= FOURTH;
          SECOND: 
              if (timer == 0) 
                  next_state <= FIRST;
              else  
                  next_state <= SECOND;
          THIRD:  
              if (start == 0)
                  next_state <= FIRST;
              else 
                  next_state <= THIRD;
          FOURTH: 
              if (timer == 0)
                  next_state <= FIRST;
              else
                  next_state <= FOURTH;
      endcase
  end
  always@* begin
      case(state)
          FIRST: begin
              s_en <= 0;
              y_en <= 0;
              y_select_next <= 0;
          end
          SECOND:
              if (start == 0) begin
                  active <= 0;
                  s_en <= 0;
              end else begin
                  active <= 1;
                  s_en <= 1;
              end
          THIRD:
              if (start == 1) begin
                  s_en <= 1;
                  s_step <= 1;
                  s_add <= 1;
                  s_zero <= 0;               
                  if (flag == 1) begin
                      y_select_next <= 1;
                      y_en <= 1;
                      y_store_x <= 0;
                  end else
                      y_en <= 0;
              end else begin
                  s_step <= 0;
                  s_en <= 0;
              end
          FOURTH: begin
              if (timer == 3) begin
                  y_store_x <= 1;
                  y_en <= 1;
              end else if (timer == 2) begin
                  y_select_next <= 2;
                  y_store_x <= 0;
                  y_en <= 1;
              end else if (timer == 1) begin
                  s_en <= 1;
                  s_step <= 1;
                  s_add <= 0;
                  s_zero <= 0;
                  y_en <= 0;
                  y_select_next <= 0;
              end else begin
                  s_en <= 0;
                  s_step <= 0;
                  y_en <= 0;
                  y_select_next <= 0;
              end
          end 
      endcase   
  end
     
  always@* begin
      if (state == SECOND && active == 1) begin 
          if (timer == 13) begin
              s_zero <= 1;
              s_add <= 0;
              s_step <= 2;
              s_en <= 1;
          end else if (timer == 10) begin 
              s_zero <= 0;
              s_add <= 0;
              s_step <= 2; 
              s_en <= 1;
          end else if (timer == 7) begin
              s_zero <= 0;
              s_add <= 0;
              s_step <= 2;
              s_en <= 1;
          end else if (timer == 4) begin
              s_zero <= 0;
              s_add <= 0;
              s_step <= 2;
              s_en <= 1;
          end else if (timer == 1) begin
              s_zero <= 0;
              s_add <= 0;
              s_step <= 2;
              s_en <= 1;
          end else begin
              s_en <= 0;
              s_step <= 0;
          end
           
      end 

  end
endmodule
