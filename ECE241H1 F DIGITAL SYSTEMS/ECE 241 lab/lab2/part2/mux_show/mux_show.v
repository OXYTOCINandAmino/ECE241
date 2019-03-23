`timescale 1ns / 1ns // `timescale time_unit/time_precision

module mux_show(SW[0],SW[1],SW[9],LEDR[0]);
input [9:0] SW;
output [9:0] LEDR;
mux2to1 u0(.x(SW[0]),.y(SW[1]),.s(SW[9]),.m(LEDR[0]));
endmodule



module mux2to1 (input x,y,s, output m);

wire w1, w2, w3;
v7404 N1(.pin1(s),.pin2(w1));
v7408 A1(.pin1(x),.pin2(w1),.pin3(w2),  .pin4(s),.pin5(y),.pin6(w3));
v7432 O1(.pin1(w2),.pin2(w3),.pin3(m));

endmodule//mux2to1



module v7404 (input pin1, pin3, pin5, pin13, pin11, pin9,
				  output pin2, pin4, pin6, pin12, pin10, pin8 );
				  
assign pin2 = !pin1; 
assign pin4 = !pin3; 
assign pin6 = !pin5; 
assign pin12 = !pin13;
assign pin10 = !pin11; 
assign pin8 = !pin9; 

endmodule // v7404(NOT gate)



module v7408 (input pin1,pin2, pin4,pin5, pin13,pin12, pin10,pin9,
				output pin3,pin6,pin11,pin8);
				
assign pin3 = pin1 & pin2;
assign pin6 = pin4 & pin5;
assign pin11 = pin13 & pin12;
assign pin8 = pin10 & pin9;
				
endmodule //v7408(AND gate)



module v7432 (input pin1,pin2, pin4,pin5, pin13,pin12, pin10,pin9,
				output pin3,pin6,pin11,pin8);
				
assign pin3 = pin1 | pin2;
assign pin6 = pin4 | pin5;
assign pin11 = pin13 | pin12;
assign pin8 = pin10 | pin9;
				
endmodule //v7408(AND gate)
