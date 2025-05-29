module Register(

  input clk, En,
  input [7:0] in,
  output reg [7:0] out
);
  always @(posedge clk) begin
    if (En)
      out <= in;
  end
endmodule