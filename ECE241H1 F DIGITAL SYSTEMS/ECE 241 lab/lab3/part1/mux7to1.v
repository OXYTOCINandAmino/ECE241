`timescale 1ns / 1ns // `timescale time_unit/time_precision

module mux7to1(LEDR, SW);
    input [9:0] SW;
    output [6:0]LEDR;

	 wire[6:0]Input;
	 wire[2:0]MuxSelect;
	 
assign Input[6:0] = SW[6:0];

assign MuxSelect[2]=SW[9];
assign MuxSelect[1]=SW[8];
assign MuxSelect[0]=SW[7];
reg Out;

always@(*)
begin
   case(MuxSelect[2:0])
	3'b000:Out=Input[0];
	3'b001:Out=Input[1];
	3'b010:Out=Input[2];
	3'b011:Out=Input[3];
	3'b100:Out=Input[4];
	3'b101:Out=Input[5];
	3'b110:Out=Input[6];
	default: Out=4'b000;
	
	endcase	
	end	
	
	assign LEDR[0]=Out;
	
endmodule