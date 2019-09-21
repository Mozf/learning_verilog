module b
#(
  parameter idle = 2'b00,
  parameter runa = 2'b01,
  parameter runb = 2'b10
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
  reg [1:0] state;
  reg [1:0] next_state;

  always@(posedge clk or negedge rstn)begin
    if(!rstn)
      state <= idle;
    else
      state <= next_state;
  end

  always@(a, b, f, g)begin
    next_state = idle;
    case(state)
      idle: begin
        if(a == 1'b1)begin
          c = 1'b1;
          next_state = idle;
        end
        else if(b == 1'b1)begin
          d = 1'b1;
          next_state = runa;
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
        if(g != 1'b1)begin
          h = 1'b1;
          next_state = runb;
        end
        else
          next_state = idle;
      end
      default: next_state = idle;
    endcase
  end

  always @ (posedge clk or negedge rstn) begin
    c = 1'b0;
    d = 1'b0;
    e = 1'b0;
    h = 1'b0;
    
    case(next_state) begin
      idle: begin

      end
    endcase
  end

endmodule