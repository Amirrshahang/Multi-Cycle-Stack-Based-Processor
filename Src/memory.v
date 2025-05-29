module Memory(
  input clk, WE, RE,
  input [4:0] Address,
  input reg [7:0] WriteData,
  output wire [7:0] ReadData
);
  reg [7:0] memory [0:31];

  always @(posedge clk) begin
    if (WE)
      memory[Address] <= WriteData;
  end

  initial begin
     $readmemb("memData.txt", memory);
  end
  assign ReadData = RE ? memory[Address] : 8'd0;
  
endmodule

