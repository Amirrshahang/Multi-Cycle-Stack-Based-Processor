module MUX #(parameter N)(
  input [N-1:0] A, B,
  input sel,
  output [N-1:0] out
);
  assign out = sel ? B : A;
endmodule
