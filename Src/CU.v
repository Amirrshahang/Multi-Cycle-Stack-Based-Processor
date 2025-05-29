module Controller(
  input clk, rst,
  input [2:0] OPC,
  output reg push, pop, tos, PCWrite, PCWriteCond, Mem_sel, WE, RE, en_IR, Stack_sel, en_A, en_B, ALU_selA,  ALU_selB, PC_MUX_sel,
  output reg [1:0] ALU_OPC
);

reg [4:0] ns, ps;
parameter [4:0] Fetch = 0, Decode = 1, ST1 = 2, ST2 = 3, ST3 = 4, ST4 = 5,
                  ST5 = 6, ST6 = 7, ST7 = 8, ST8 = 9, ST9 = 10, ST10 = 11,
                  ST11 = 12, ST12 = 13, ST13 = 14, ST14 = 15, ST15 = 16, 
                  ST16 = 17, ST17 = 18, ST18 = 19, ST19 = 20, ST20 = 21;
                

always@(posedge clk, posedge rst)begin
    if(rst)
      ps <= Fetch;
    else
      ps <= ns;
  end


  always@(ps, OPC)begin
    ns = Fetch;
    case(ps)
      Fetch : ns = Decode;
      Decode : 
        case(OPC)
          3'b000 : ns = ST1;
          3'b001 : ns = ST1;
          3'b010 : ns = ST1;
          3'b011 : ns = ST9;
          3'b100 : ns = ST15;
          3'b101 : ns = ST12;
          3'b110 : ns = ST20;
          3'b111 : ns = ST17;     
        endcase
      ST1 : ns = ST2;
      ST2 : ns = ST3;
      ST3 : ns = ST4;
      ST4 : 
        case(OPC)
          3'b000 : ns = ST5;
          3'b001 : ns = ST6;
          3'b010 : ns = ST7;
        endcase
      ST5 : ns = ST8;
      ST6 : ns = ST8;
      ST7 : ns = ST8;
      ST8 : ns = Fetch;
      ST9 : ns = ST10;
      ST10 : ns = ST11;
      ST11 : ns = ST8;
      ST12 : ns = ST13;
      ST13 : ns = ST14;
      ST14 : ns = Fetch;
      ST15 : ns = ST16;
      ST16 : ns = Fetch; 
      ST17 : ns = ST18;
      ST18 : ns = ST19;
      ST19 : ns = Fetch;
      ST20 : ns = Fetch;
    endcase
  end
  always@(ps)begin
    {push, pop, tos, PCWrite, PCWriteCond, Mem_sel, WE, RE, en_IR, Stack_sel, en_A, en_B, ALU_selB, PC_MUX_sel, ALU_selA, ALU_OPC} = 17'd0;
    case(ps)
      Fetch : {RE, en_IR, ALU_selB,PCWrite} = 4'b1111;
      Decode :;

      ST1 : pop = 1'b1;
      ST2 : en_A = 1'b1;
      ST3 : pop = 1'b1;
      ST4 : en_B = 1'b1;
      ST5 : ALU_selA = 1'b1;
      ST6 : begin ALU_selA = 1'b1; ALU_OPC = 2'b01; end
      ST7 : begin ALU_selA = 1'b1; ALU_OPC = 2'b10; end
      ST8 : push = 1'b1;
      ST9 : pop = 1'b1;
      ST10 : en_B = 1'b1;
      ST11 : begin ALU_selA = 1'b1; ALU_OPC = 2'b11; end
      ST12 : pop = 1'b1;
      ST13 : en_A = 1'b1;
      ST14 : {Mem_sel, WE} = 2'b11;
      ST15 : {Mem_sel, RE} = 2'b11;
      ST16 : {Stack_sel, push} = 2'b11;
      ST17 : {tos} = 1'b1;
      ST18 :  en_A = 1'b1;
      ST19 : {PCWriteCond, PC_MUX_sel, RE} = 3'b111;
      ST20 : {PC_MUX_sel, PCWrite} = 2'b11;
    endcase
  end

endmodule
