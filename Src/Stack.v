module Stack(
  input clk, rst, push, pop, tos,
  input [7:0] d_in,
  output reg [7:0] d_out 
); 

  reg [7:0] ptr;
  reg [7:0] stack [0:255];

  always @(posedge clk or posedge rst) begin
    if (rst)
      ptr <= 8'd0;
    else if (push) begin
      stack[ptr] <= d_in;
      ptr <= ptr + 1;
    end
    else if (pop) begin
      ptr <= ptr - 1;
      d_out <= stack[ptr - 1];
    end
    else if (tos)
      d_out <= stack[ptr - 1];
  end

endmodule

