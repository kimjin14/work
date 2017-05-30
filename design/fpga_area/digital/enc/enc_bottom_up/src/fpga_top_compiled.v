
module buffer_wire ( in, out );
  input in;
  output out;


  BUFFD1 eco_cell ( .I(in), .Z(out) );

endmodule
