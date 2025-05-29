module ALU(
  input [7:0] A, B,
  input [1:0] ALU_OPC,
  output reg [7:0] ALUResult
);

  always @(ALU_OPC, A, B) begin
    case(ALU_OPC)
      2'b00 : ALUResult = A + B;
      2'b01 : ALUResult = A - B;
      2'b10 : ALUResult = A & B;
      2'b11 : ALUResult = ~A;
    endcase
  end
endmodule

