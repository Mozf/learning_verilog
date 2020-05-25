//==============================================================================
// Module name: add_prop_gen
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.10.3
// Description: g[i]     = a[i] & b[i]
//              p[i]     = a[i] ^ b[i]
//              s[i]     = p[p] ^ c[i]
//              c[i + 1] = (p[i] & c[i]) | g[i]
//
//              sum   = p ^ (c[n-1],...,c[2],c[1],c[0])
//              c_out = c[n]
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module add_prop_gen 
(
  input  [3 : 0]  a,
  input  [3 : 0]  b,
  input           c_in,

  output [3 : 0]  sum,
  output          c_out  
);

  reg  [3 : 0]  carrychain;
  integer       i;
  wire [3 : 0]  g;
  wire [3 : 0]  p;
  wire [4 : 0]  shiftedcarry;

  assign g = a & b; //按位与
  assign p = a ^ b; //按位异或
  
  assign shiftedcarry = {carrychain, c_in};
  assign sum = p ^ shiftedcarry; //sum   = p ^ (c[n-1],...,c[2],c[1],c[0])
  assign c_out = shiftedcarry[4]; //c_out = c[n]

  always @ (g, p, c_in, a, b) begin
    carrychain[0] = g[0] + (p[0] & c_in); //c[1] = g[0] + (p[0] & c[0])

    for(i = 1; i <= 3; i = i + 1)
      begin
        carrychain[i] = g[i] | (p[i] & carrychain[i - 1]);
      end
  end

endmodule 