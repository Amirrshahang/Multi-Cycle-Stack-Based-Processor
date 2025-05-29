module TOP(
  input clk, rst
);

  wire push, pop, tos, PCWrite, PCWriteCond, Mem_sel, WE, RE, en_IR, Stack_sel, en_A, en_B, ALU_selA, ALU_selB, PC_MUX_sel;
  wire [1:0] ALU_OPC;
  wire [2:0] OPC;

  Datapath DP (
    .clk(clk), .rst(rst),
    .push(push), .pop(pop), .tos(tos), .PCWrite(PCWrite), .PCWriteCond(PCWriteCond), .Mem_sel(Mem_sel),
    .WE(WE), .RE(RE), .en_IR(en_IR), .Stack_sel(Stack_sel), .en_A(en_A), .en_B(en_B),
    .ALU_selB(ALU_selB), .PC_MUX_sel(PC_MUX_sel), .ALU_selA(ALU_selA), .ALU_OPC(ALU_OPC),
    .OPC(OPC)
  );

  Controller CU (
    .clk(clk), .rst(rst), .OPC(OPC),
    .push(push), .pop(pop), .tos(tos), .PCWrite(PCWrite), .PCWriteCond(PCWriteCond), .Mem_sel(Mem_sel),
    .WE(WE), .RE(RE), .en_IR(en_IR), .Stack_sel(Stack_sel), .en_A(en_A), .en_B(en_B),
    .ALU_selB(ALU_selB), .PC_MUX_sel(PC_MUX_sel), .ALU_selA(ALU_selA), .ALU_OPC(ALU_OPC)
  );

endmodule

