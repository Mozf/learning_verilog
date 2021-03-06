module a
#(
  parameter idle = 3'b000,
  parameter runa = 3'b001,
  parameter runb = 3'b010,
  parameter DELAY = 3'b011,
  parameter DELAY0 = 3'b100,
  parameter DELAY1 = 3'b101
)
(
  input clk,
  input rstn,

  input a,
  input b,
  input f,
  input g,
  output reg c,
  output reg d,
  output reg e,
  output reg h
);
  reg [2:0] state;
  reg [2:0] next_state;

  always@(posedge clk or negedge rstn)begin
    if(!rstn)
      state <= idle;
    else
      state <= next_state;
  end

  always@(*)begin
    c = 1'b0;
    d = 1'b0;
    e = 1'b0;
    h = 1'b0;
    next_state = idle;
    case(state)
      idle: begin
        if(a == 1'b1)begin
          c = 1'b1;
          next_state = runa;
        end
        else if(b == 1'b1)begin
          d = 1'b1;
          next_state = idle;
        end
      end

      runa:begin
        if(f == 1'b1)begin
          e = 1'b1;
          next_state = runb;
        end
        else
          next_state = runa;
      end

      runb:begin
        if(g == 1'b1)
          next_state = DELAY;
        else
          next_state = runb;
      end

      DELAY:begin
        next_state = DELAY0;
      end

      DELAY0:begin
        next_state = DELAY1;
      end

      DELAY1:begin
        next_state = idle;
      end

      default: next_state = idle;
    endcase
  end

endmodule