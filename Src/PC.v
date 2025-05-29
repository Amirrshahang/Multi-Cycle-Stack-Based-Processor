module PC(
  input clk, rst, Pc_en,
  input [4:0] pc,
  output reg [4:0] next_pc
);

  always @(posedge clk, posedge rst) begin
    if (rst)
      next_pc <= 5'd0;
    else if (Pc_en)
      next_pc <= pc;
  end
endmodule
