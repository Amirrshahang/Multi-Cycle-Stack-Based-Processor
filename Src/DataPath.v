module Datapath (
    input  wire clk,rst, push, pop, tos, PCWrite, PCWriteCond, Mem_sel, WE, RE, en_IR, 
                Stack_sel, en_A, en_B, ALU_selA, ALU_selB, PC_MUX_sel,
    input  wire [1:0]  ALU_OPC,
    output wire [2:0]  OPC
);

  wire [4:0] pcIn, pcOut, Address;
  wire [7:0] WriteData, ReadData, MDROut, inst, d_in, d_out;
  wire [7:0] AOut, BOut, A, B, ALUResult, ALUOut, pcOutSE;
  wire PC_en;

  PC pc(clk, rst, PC_en, pcIn, pcOut);
   Memory Mem(clk, WE, RE, Address, AOut, ReadData);
  
  Register MDR(clk, 1'b1, ReadData, MDROut);
  Register IR(clk, en_IR, ReadData, inst);
  Stack stack(clk, rst, push, pop, tos, d_in, d_out); 

  Register Areg(clk, en_A, d_out, AOut);
  Register Breg(clk, en_B, d_out, BOut);

  ALU alu(A, B, ALU_OPC, ALUResult);
  Register OutReg(clk, 1'b1, ALUResult, ALUOut);

  assign pcOutSE = {3'b000, pcOut};

  MUX #5 Mem_mux(pcOut, inst[4:0], Mem_sel, Address);
  MUX #8 St_mux(ALUOut, MDROut, Stack_sel, d_in);
  MUX #8 A_Mux(pcOutSE, AOut, ALU_selA, A);
  MUX #8 B_Mux(BOut, 8'd1, ALU_selB, B);
  MUX #5 PC_mux(ALUResult[4:0], inst[4:0], PC_MUX_sel, pcIn);

    assign PC_en = (PCWrite || (PCWriteCond && ~(8'd0 || AOut)));

    assign OPC = inst[7:5];

endmodule