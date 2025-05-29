`timescale 1ns/1ns

module TB();

  reg clk , rst;

  TOP uut (clk, rst);

  always #10 clk = ~clk;

  initial begin

  clk = 1'b0;
  rst = 1'b1;
  #51 rst = 1'b0;
  
  #1000;
  $stop;
  end
endmodule
