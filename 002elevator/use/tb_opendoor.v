`timescale 100ns/1ns
module tb_opendoor;
  reg        clk;
  reg             rstn;

  reg              open;

  reg      [4:0] out_state;
  
  reg               led4r;
  reg                led4g;
  reg               led4b;

  wire        led5r;

  wire          close;

  //外呼�???
  wire          led0;
  wire        led1;
  wire        led2;
  wire         led3;
  
  //内呼�???
  wire     led6;
  wire          led7;
  wire         led8;

  initial begin
    clk = 0;
    rstn = 0;
    open = 0;
    out_state = 4'd0;
    led4r = 0;
    led4g = 0;
    led4b = 0;

    #20 rstn = 1;

    #20 open = 1; 
    led4r = 1;
    out_state = 4'd7;

    #2000000000 open = 1; 
    led4r = 1;
    out_state = 4'd2;

    #2000000000 open = 1; 
    led4g = 1;
    led4r = 0;
    out_state = 4'd3;


    #2000000000 open = 1; 
    led4b = 1;
    led4g = 0;
    out_state = 4'd4;


    #2000000000 open = 1; 
    led4g = 1;
    led4b = 0;
    out_state = 4'd8;

    #200 $stop;

  end

  always #1 clk = ~clk;

  always@(posedge clk) begin
    if(open)begin
      if(close)begin
        open <= 1'b0;
      end
    end
  end

  opendoor opendoor_inst
  (
    .clk(  clk),
    .rstn(           rstn),

    .open( open),

    .out_state( out_state),
    
    .LED4_R (  led4r),
    .LED4_G(       led4g  ),
    .LED4_B( led4b),

    .LED5_R(   led5r        ),

    .close(           close),

    //外呼�???
    .LED0(     led0     ),
    .LED1(      led1     ),
    .LED2(      led2     ),
    .LED3(     led3     ),
    
    //内呼�???
    .LED6(    led6       ),
    .LED7(  led7        ),
    .LED8(  led8       )
  );
endmodule