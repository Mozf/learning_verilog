`timescale  1ns / 1ps

module tb_axis_data_fifo_0;

// axis_data_fifo_0 Parameters
parameter PERIOD  = 10;


// axis_data_fifo_0 Inputs
reg   s_axis_aresetn                       = 0 ;
reg   s_axis_aclk                          = 0 ;
reg   s_axis_tvalid                        = 0 ;
reg   [31 : 0]  s_axis_tdata               = 0 ;
reg   [3 : 0]  s_axis_tkeep                = 0 ;
reg   s_axis_tlast                         = 0 ;
reg   m_axis_tready                        = 0 ;

// axis_data_fifo_0 Outputs
wire  s_axis_tready                        ;
wire  m_axis_tvalid                        ;
wire  [31 : 0]  m_axis_tdata               ;
wire  [3 : 0]  m_axis_tkeep                ;
wire  m_axis_tlast                         ;


initial
begin
    forever #(PERIOD/2)  s_axis_aclk=~s_axis_aclk;
end

initial
begin
    #(PERIOD*2) s_axis_aresetn  =  1;
end

axis_data_fifo_0  u_axis_data_fifo_0 (
    .s_axis_aresetn          ( s_axis_aresetn           ),
    .s_axis_aclk             ( s_axis_aclk              ),
    .s_axis_tvalid           ( s_axis_tvalid            ),
    .s_axis_tdata            ( s_axis_tdata    [31 : 0] ),
    .s_axis_tkeep            ( s_axis_tkeep    [3 : 0]  ),
    .s_axis_tlast            ( s_axis_tlast             ),
    .m_axis_tready           ( m_axis_tready            ),

    .s_axis_tready           ( s_axis_tready            ),
    .m_axis_tvalid           ( m_axis_tvalid            ),
    .m_axis_tdata            ( m_axis_tdata    [31 : 0] ),
    .m_axis_tkeep            ( m_axis_tkeep    [3 : 0]  ),
    .m_axis_tlast            ( m_axis_tlast             )
);

initial
begin
  //#(PERIOD*50) m_axis_tready = 1;
  #(PERIOD*50)  $stop;
end

  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) begin
      s_axis_tvalid <= 0;
      s_axis_tkeep <= 4'b0000;
    end
    else if(go) begin
      s_axis_tvalid <= 1;
      s_axis_tkeep <= 4'b1111;
    end
    else if(s_axis_tlast)
      s_axis_tvalid <= 0;
    else 
      s_axis_tvalid <= s_axis_tvalid;
  end

  reg s_axis_tready_reg;
  reg go;
  reg [4:0] cnt32;

  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) 
      s_axis_tready_reg <= 0;
    else 
      s_axis_tready_reg <= s_axis_tready;
  end

  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) 
      cnt32 <= 0;
    else if(s_axis_tready)
      cnt32 <= cnt32 + 1;
    else
      cnt32 <= 0;
  end

  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) 
      go <= 0;
    else if(cnt32 == 5'd1)
      go <= 1;
    else
      go <= 0;
  end

  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) 
      s_axis_tlast <= 0;
    else if(cnt32 == 5'd25)
      s_axis_tlast <= 1;
    else
      s_axis_tlast <= 0;
  end

  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) 
      s_axis_tdata  <= 32'd0;
    else if(s_axis_tvalid)
      s_axis_tdata  <= s_axis_tdata + 1;
    else
      s_axis_tdata  <= s_axis_tdata ;
  end
  
  reg [3:0] mready;
  
  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) 
      mready  <= 4'b0001;
    else
      mready  <= {mready[2:0], mready[3]};
  end
  
  always @ (posedge s_axis_aclk or negedge s_axis_aresetn) begin
    if(!s_axis_aresetn) 
      m_axis_tready  <= 1'b0;
    else if(mready[3])
      m_axis_tready  <= 1;
    else
      m_axis_tready  <= 0 ;
  end

endmodule