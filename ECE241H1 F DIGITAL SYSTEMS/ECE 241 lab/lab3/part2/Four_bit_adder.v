`timescale 1ns / 1ns // `timescale time_unit/time_precision

module Four_bit_adder(LEDR, SW);
    input [9:0] SW;
    output [9:0]LEDR;
	 
	 wire cin;
	 wire [3:0]A;
	 wire [3:0]B;
	 
	 wire s0,s1,s2,s3;
	 wire c1,c2,c3,cout;
	 wire a0,b0,a1,b1,a2,b2,a3,b3;
	 
	 
	 assign A[3:0]=SW[7:4];
	 assign B[3:0]=SW[3:0];
	 assign cin=SW[8];
	 
	 
	 assign a0=A[0];
	 assign b0=B[0];
	 assign a1=A[1];
	 assign b1=B[1];
	 assign a2=A[2];
	 assign b2=B[2];
	 assign a3=A[3];
	 assign b3=B[3];	 
	 
	 FA FA0(.b(b0),.a(a0),.ci(cin),.co(c1),.s(s0));
	 FA FA1(.b(b1),.a(a1),.ci(c1),.co(c2),.s(s1));
	 FA FA2(.b(b2),.a(a2),.ci(c2),.co(c3),.s(s2));
	 FA FA3(.b(b3),.a(a3),.ci(c3),.co(cout),.s(s3));
	 
	 wire [3:0]S;
	 assign S[3]=s3;
	 assign S[2]=s2;
	 assign S[1]=s1;
	 assign S[0]=s0;
	 
	 assign LEDR[3:0]=S[3:0];
	 assign LEDR[9]=cout;
	 
endmodule


module FA(input b,a,ci,output co,s);

assign co=(~b & a & ci)|(b & ~a & ci)|(b & a & ~ci)|(b & a & ci);
assign s=(~b & ~a & ci)|(~b & a & ~ci)|(b & ~a & ~ci)|(b & a & ci);

endmodule
