`timescale 1ns / 1ns // `timescale time_unit/time_precision

module ALU_with_Reg(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [9:0]SW;
input [3:0]KEY;

output [7:0]LEDR;
output [6:0]HEX0;
output [6:0]HEX1;
output [6:0]HEX2;
output [6:0]HEX3;
output [6:0]HEX4;
output [6:0]HEX5;

wire [3:0]A;
wire [3:0]B;


assign A[3:0]=SW[3:0];

//begin of ALU

// case0 Four_bit_adder
wire cin;
assign cin=0;
wire [4:0]F;
Four_bit_adder Adder0(.A(A),.B(B),.cin(cin),.S(F));
wire [7:0]Out0;
assign Out0[4:0]=F[4:0];
assign Out0[7]=0;
assign Out0[6]=0;
assign Out0[5]=0;



//case 1 
	wire [7:0]A1;
	wire [7:0]B1;
	assign A1[7]=0;
   assign A1[6]=0;
   assign A1[5]=0;
	assign A1[4]=0;
	assign A1[3:0]=A[3:0];
	
   assign B1[7]=0;
   assign B1[6]=0;
   assign B1[5]=0;
	assign B1[4]=0;
	assign B1[3:0]=B[3:0];

wire Eqn3;
//case 4
wire A_2_bit, B_3_bit;
assign A_2_bit=(~A[3]|~A[2]|A[1]|A[0])&(~A[3]|A[2]|~A[1]|A[0])&(~A[3]|A[2]|A[1]|~A[0])&(A[3]|~A[2]|~A[1]|A[0])&(A[3]|~A[2]|A[1]|~A[0])&(A[3]|A[2]|~A[1]|~A[0]);
assign  B_3_bit= (~B[3]|B[2]|B[1]|B[0])&(B[3]|~B[2]|B[1]|B[0])&(B[3]|B[2]|~B[1]|B[0])&(B[3]|B[2]|B[1]|~B[0]);
	

wire [2:0]Function;
assign Function[2:0]=KEY[3:1];

wire [7:0]Regout;

// always block
reg [7:0]ALUout;
always @(*)
   case(Function[2:0])
	3'b000:
	//case0
	ALUout[7:0]=Out0[7:0];
	
	
	3'b001:
	//case1
	ALUout=A1+B1;
	
	
	3'b010:
	//case2

	ALUout={ ~(A & B),~(A | B)};
	
	3'b011:
	//case3
	if((A[3]|A[2]|A[1]|A[0]|B[3]|B[2]|B[1]|B[0]) == 1)
	ALUout = 8'b11000000;
	else
	ALUout = 8'b00000000;
	
 	3'b100:
	//case4
	
	
	if((A_2_bit & B_3_bit)==1)
	ALUout = 8'b00111111;
	else
	ALUout = 8'b00000000;
	
	3'b101:
	//case5
	ALUout={ B,~A};
	
	3'b110:
	//case6
	ALUout={ A^B, A~^B};
	
	3'b111:
	//case6
	ALUout=Regout;
	
	default: ALUout=9'b000000000;
	
	endcase	
	
	//put the output of ALU into register
	wire Restn;
	assign Restn = SW[9];
	wire Clock;
	assign Clock = KEY[0];
	
	
	reg8 R0(.D(ALUout),.Clock(Clock),.Restn(Restn),.Q(Regout));
	
	// pass the lower 4 bit of Regout into B
	assign B[3:0]=Regout[3:0];
	
	
	//HEX0 display A
	Hex_display H0(.NUM3(SW[3]),.NUM2(SW[2]),.NUM1(SW[1]),.NUM0(SW[0]),.H(HEX0));
	//HEX4 display Regout[3:0]
	Hex_display H4(.NUM3(Regout[3]),.NUM2(Regout[2]),.NUM1(Regout[1]),.NUM0(Regout[0]),.H(HEX4));
	//HEX5 display ALU[7:4]
	Hex_display H5(.NUM3(Regout[7]),.NUM2(Regout[6]),.NUM1(Regout[5]),.NUM0(Regout[4]),.H(HEX5));
	
	//LEDR display Regout
	assign LEDR[7:0]= Regout[7:0];
	
	//HEX1 HEX2 HEX3 display 0
	Hex_display H1(.NUM3(0),.NUM2(0),.NUM1(0),.NUM0(0),.H(HEX1));
	Hex_display H2(.NUM3(0),.NUM2(0),.NUM1(0),.NUM0(0),.H(HEX2));
	Hex_display H3(.NUM3(0),.NUM2(0),.NUM1(0),.NUM0(0),.H(HEX3));
	
	
	
	endmodule

//module of a 8_bit register with synchronous clear
module reg8(D,Clock,Restn,Q);
input [7:0]D;
input Clock,Restn;
output reg[7:0]Q;

always@(posedge Clock)
if(Restn==0)
 Q<=8'b00000000;
else
 Q<=D;
endmodule


// module of Four_bit_adder
module Four_bit_adder(A,B,cin,S);
	 input [3:0]A;
	 input [3:0]B;
	 input cin;
	 output [4:0]S;
	 
	 wire s0,s1,s2,s3;
	 wire c1,c2,c3,cout;
	 wire a0,b0,a1,b1,a2,b2,a3,b3;
	 
	 
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
	 
	 assign S[4]=cout;
	 assign S[3]=s3;
	 assign S[2]=s2;
	 assign S[1]=s1;
	 assign S[0]=s0;
	 
	 
endmodule


module FA(input b,a,ci,output co,s);

assign co=(~b & a & ci)|(b & ~a & ci)|(b & a & ~ci)|(b & a & ci);
assign s=(~b & ~a & ci)|(~b & a & ~ci)|(b & ~a & ~ci)|(b & a & ci);
endmodule

//module of HEX display
module Hex_display(NUM3,NUM2,NUM1,NUM0,H);
input  NUM3,NUM2,NUM1,NUM0;
output [6:0] H;

Hex_decoder u0(.c3(NUM3),.c2(NUM2),.c1(NUM1),.c0(NUM0),.S(H));
endmodule



module Hex_decoder(input c3,c2,c1,c0 ,output [6:0]S);

assign S[0]= ~((c3|c2|c1|~c0)&(c3|~c2|c1|c0)&(~c3|c2|~c1|~c0));
assign S[1]= ~((c3|~c2|c1|~c0)&(c3|~c2|~c1|c0)&(~c3|c2|~c1|~c0)&(~c3|~c2|c1|c0)&(~c3|~c2|~c1|c0)&(~c3|~c2|~c1|~c0))  ;
assign S[2]= ~((c3|c2|~c1|c0)&(~c3|~c2|c1|c0)&(~c3|~c2|~c1|c0)&(~c3|~c2|~c1|~c0))  ;
assign S[3]= ~((c3|c2|c1|~c0)&(c3|~c2|c1|c0)&(c3|~c2|~c1|~c0)&(~c3|c2|~c1|c0)&(~c3|~c2|~c1|~c0))  ;
assign S[4]= ~((c3|c2|c1|~c0)&(c3|c2|~c1|~c0)&(c3|~c2|c1|c0)&(c3|~c2|c1|~c0)&(c3|~c2|~c1|~c0)&(~c3|c2|c1|~c0))  ;
assign S[5]= ~((c3|c2|c1|~c0)&(c3|c2|~c1|c0)&(c3|c2|~c1|~c0)&(c3|~c2|~c1|~c0))  ;
assign S[6]= ~((c3|c2|c1|c0)&(c3|c2|c1|~c0)&(c3|~c2|~c1|~c0)&(~c3|~c2|c1|c0))  ;
endmodule
