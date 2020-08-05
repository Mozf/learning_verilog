module gray2bin
(
gray_in,
bin_out
);

parameter data_width = 4;

input   [data_width-1:0] gray_in;
output  [data_width-1:0] bin_out;
reg     [data_width-1:0] bin_out;

always @(gray_in) begin
bin_out[3] = gray_in[3];
bin_out[2] = gray_in[2]^bin_out[3];
bin_out[1] = gray_in[1]^bin_out[2];
bin_out[0] = gray_in[0]^bin_out[1];
end

endmodule