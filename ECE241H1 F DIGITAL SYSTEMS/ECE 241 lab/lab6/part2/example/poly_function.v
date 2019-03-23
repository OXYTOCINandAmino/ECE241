
///////////////////////////////////////////////////////////////
module datapath(clk,Reg_A,Divisor,Divident,shift_L,);

input clk;

input [4:0]Reg_A;
input [4:0]Divisor;
input [3:0]Divident;

input Shift_L;
    
   //shift Left
wire [4:0]Reg_A_shift;
wire [3:0]Divident_shift;

always @(posedge clk)
	begin
	if(shift_L==1)
	   begin
	   Reg_A_shift <= Reg_A<<1;
		Reg_A_shift[0] <= Divident[3];
		Divident <= Divident<<1;
		end
	end
    
endmodule



