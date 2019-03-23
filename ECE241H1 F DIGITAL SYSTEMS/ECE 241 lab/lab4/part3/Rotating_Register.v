`timescale 1ns / 1ns 
// top level module
module Rotating_Register(SW,KEY,LEDR);
input [9:0]SW;
input [3:0]KEY;
output [7:0]LEDR;

wire parallelLoadn,RotateRight,LSRight,reset,clock;
wire [7:0]DATA_IN;
wire [7:0]Q;

assign DATA_IN[7:0]=SW[7:0];
assign parallelLoadn=KEY[1];
assign RotateRight=KEY[2];
assign LSRight=KEY[3];
assign reset=SW[9];
assign clock=KEY[0];

rotating_register R1(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.LSRight(LSRight),
                     .DATA_IN(DATA_IN),.reset(reset),.clock(clock),.Q(Q));
//
assign LEDR[7:0]=Q[7:0];
endmodule

//main module
module rotating_register(parallelLoadn,RotateRight,LSRight,DATA_IN,reset,clock,Q);
input parallelLoadn,RotateRight,LSRight,reset,clock;
input [7:0]DATA_IN;
output [7:0]Q;
wire [7:0]q;
assign q[7:0]=Q[7:0];
//Q7
Q7 q7(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.DATA_IN(DATA_IN[7]),
      .LSRight(LSRight),.R(q[6]),.L(q[0]),.clock(clock),.reset(reset),.Q(Q[7]));
//Q6
QQ q6(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.clock(clock),.reset(reset),
    .DATA_IN(DATA_IN[6]),.R(q[5]),.L(q[7]),.Q(Q[6]));
//Q5
QQ q5(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.clock(clock),.reset(reset),
    .DATA_IN(DATA_IN[5]),.R(q[4]),.L(q[6]),.Q(Q[5]));
//Q4
QQ q4(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.clock(clock),.reset(reset),
    .DATA_IN(DATA_IN[4]),.R(q[3]),.L(q[5]),.Q(Q[4]));
//Q3
QQ q3(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.clock(clock),.reset(reset),
    .DATA_IN(DATA_IN[3]),.R(q[2]),.L(q[4]),.Q(Q[3]));
//Q2
QQ q2(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.clock(clock),.reset(reset),
    .DATA_IN(DATA_IN[2]),.R(q[1]),.L(q[3]),.Q(Q[2]));
//Q1
QQ q1(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.clock(clock),.reset(reset),
    .DATA_IN(DATA_IN[1]),.R(q[0]),.L(q[2]),.Q(Q[1]));
//Q0
QQ q0(.parallelLoadn(parallelLoadn),.RotateRight(RotateRight),.clock(clock),.reset(reset),
    .DATA_IN(DATA_IN[0]),.R(q[7]),.L(q[1]),.Q(Q[0]));
//end
endmodule


//module Q7
module Q7(parallelLoadn,RotateRight,DATA_IN,LSRight,R,L,clock,reset,Q);
input parallelLoadn,RotateRight,DATA_IN,R,L,clock,reset,LSRight;
output Q;

reg Data;
always @(*)
begin
if(parallelLoadn==0)
  Data=DATA_IN;
else
  begin
  if (RotateRight==0)
  Data=R;
  else
  begin
    if (LSRight==0)
     Data=L;
	 else
	  Data=0;
  end
  end
end
//pass data into flipflop
flipflop F0(.Data(Data),.Q(Q),.clock(clock),.reset(reset));

endmodule


//other module QQ
module QQ(parallelLoadn,RotateRight,DATA_IN,R,L,clock,reset,Q);
input parallelLoadn,RotateRight,DATA_IN,R,L,clock,reset;
output Q;
wire Data;
mux M0(.loadn(parallelLoadn),.DATA_IN(DATA_IN),.Loadleft(RotateRight),.R(R),.L(L),.Data(Data));
flipflop F0(.Data(Data),.Q(Q),.clock(clock),.reset(reset));
endmodule


//mux module
module mux(loadn,DATA_IN,Loadleft,R,L,Data);
input loadn,DATA_IN,Loadleft,R,L;
output Data;

reg Data;
always @(*)
begin
if(loadn==0)
  Data=DATA_IN;
else
  if (Loadleft==0)
  Data=R;
  else
  Data=L;
 
end
endmodule
//

//flip flop module
module flipflop(Data,Q,clock,reset);
input Data,clock,reset;
output Q;

reg Q;
always@(posedge clock)
begin
if(reset==1)
Q<=0;
else
Q<=Data;
end
endmodule
