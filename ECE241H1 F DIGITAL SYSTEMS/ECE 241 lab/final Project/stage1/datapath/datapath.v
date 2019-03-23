////////////////////////////////Data Path///////////////////////////////
module datapath(
   input clk,
                    //is_record,is_play,go,reset address are required signal from control
	input is_record, //is_record=1 record
	input is_play,   //is_play=1 play
	
	input go,
	input reset_address,


	input [5:0] S,//6 strings input from the guitar
	input [4:0] P,//4 horizontal metal bar + (no bar is pressed)
	              //for convenience P[4:1]represent the bar[4:1] been pressed
				  //P[0]take no input and is the don't care term

	output reg[31:0] note_out //output to the audio module
	);

	

 

   reg [5:0] address;
	//make the address to increase when record
	always @ (posedge go) begin
		if (reset_address) begin
			address <= 0;
		end
		else begin
			address <= address + 1;
		end
	end
//

	reg [5:0] s;
	reg [4:0] p;
	//process of record
	always @ (posedge clk) begin
		// Now the [4:0]s,p store all information during go=1
		if(go) begin
		  if(S[0]==1)
		     s[0] <= 1'b1;
		  if(S[1]==1)
		     s[1] <= 1'b0;
		  if(S[2]==1)
		     s[2] <= 1'b1;
		  if(S[3]==1)
		     s[3] <= 1'b1;
		  if(S[4]==1)
		     s[4] <= 1'b1;
		  if(S[5]==1)
		     s[5] <= 1'b1;

		  if((P[1]==0)&(P[2]==0)&(P[3]==0)&(P[4]==0)) //no bar is pressed
		     p[0] <= 1'b1;
		  if((P[1]==1)&(P[2]==0)&(P[3]==0)&(P[4]==0))
		     p[1] <= 1'b1;
		  if((P[2]==1)&(P[3]==0)&(P[4]==0))
		     p[2] <= 1'b1;
		  if((P[3]==1)&(P[4]==0))
		     p[3] <= 1'b1;
		  if(P[4]==1)
		     p[4] <= 1'b1;
		end
		// start of next go(go is now 0),Note should be cleared
		else begin
			s[5:0] <= 6'b0;
			p[4:0] <= 5'b0;
		end
	end

	
	//wren to the ram depends on is_record and is play
	reg wren;

	//assign wren correspond to current mode
	always@(posedge clk) begin
		if (is_record==1'b1)//when recoding 
			wren <= 1'b1;
		if (is_record==1'b0)//finish recording
			wren <= 1'b0;
	end
	
	//
	wire [31:0] Note,note;
	coordinates_converter C_C0(.S(s), .P(p), .note(note));
	
   //ram64x32 r(.data(Note), .wren(wren), .address(address), .clock(~go), .q(note));
	//when go=0, is_record=1,bits are loaded to the ram
	//when go=0, is_record=0,bits are read from the ram
	
	//output from ram to audio
	always@(*) begin
		if (is_record==1'b1)//when recoding 
			note_out=note;
		if (is_play==1'b1)//when replay
			note_out=note;
		if((is_record==1'b0)&(is_play==1'b0))
		   note_out=32'b0;
	end

endmodule
////////////////////////////////End of Datapath////////////////////////////////



//[4:0]S,P to coordinates converter
module coordinates_converter(S,P,note);
	input [5:0]S;
	input [4:0]P;
	output[31:0]note;

	//if no P is pushed P[0]=1;
	wire p_0;
	assign p_0=(~P[1])&(~P[2])&(~P[3])&(~P[4]);

	assign note[0]=S[0]&p_0;
	assign note[1]=S[1]&p_0;
	assign note[2]=S[2]&p_0;
	assign note[3]=S[3]&p_0;
	assign note[4]=S[4]&p_0;
	assign note[5]=S[5]&p_0;

	assign note[6]=S[0]&P[1];
	assign note[7]=S[1]&P[1];
	assign note[8]=S[2]&P[1];
	assign note[9]=S[3]&P[1];
	assign note[10]=S[4]&P[1];
	assign note[11]=S[5]&P[1];

	assign note[12]=S[0]&P[2];
	assign note[13]=S[1]&P[2];
	assign note[14]=S[2]&P[2];
	assign note[15]=S[3]&P[2];
	assign note[16]=S[4]&P[2];
	assign note[17]=S[5]&P[2];

	assign note[18]=S[0]&P[3];
	assign note[19]=S[1]&P[3];
	assign note[20]=S[2]&P[3];
	assign note[21]=S[3]&P[3];
	assign note[22]=S[4]&P[3];
	assign note[23]=S[5]&P[3];

	assign note[24]=S[0]&P[4];
	assign note[25]=S[1]&P[4];
	assign note[26]=S[2]&P[4];
	assign note[27]=S[3]&P[4];
	assign note[28]=S[4]&P[4];
	assign note[29]=S[5]&P[4];


	assign note[31:30]= 2'b00;
endmodule

module note_to_hex(note_out, hex_digit1, hex_digit2);
    input [31:0] note_out;
    output reg [3:0] hex_digit1,hex_digit2;
	 always @(*)
        case (note_out[15:0])
           16'b0000000000000001: hex_digit1 = 4'h0;
			  16'b0000000000000010: hex_digit1 = 4'h1;
			  16'b0000000000000100: hex_digit1 = 4'h2;
			  16'b0000000000001000: hex_digit1 = 4'h3;

			  16'b0000000000010000: hex_digit1 = 4'h4;
			  16'b0000000000100000: hex_digit1 = 4'h5;
			  16'b0000000001000000: hex_digit1 = 4'h6;
			  16'b0000000010000000: hex_digit1 = 4'h7;

			  16'b0000000100000000: hex_digit1 = 4'h8;
			  16'b0000001000000000: hex_digit1 = 4'h9;
			  16'b0000010000000000: hex_digit1 = 4'hA;
			  16'b0000100000000000: hex_digit1 = 4'hB;

			  16'b0001000000000000: hex_digit1 = 4'hC;
			  16'b0010000000000000: hex_digit1 = 4'hD;
			  16'b0100000000000000: hex_digit1 = 4'hE;
			  16'b1000000000000000: hex_digit1 = 4'hF;
			  default:hex_digit1 = 4'h0;
		endcase
always @(*)
        case (note_out[31:16])
           16'b0000000000000001: hex_digit1 = 4'h0;
			  16'b0000000000000010: hex_digit1 = 4'h1;
			  16'b0000000000000100: hex_digit1 = 4'h2;
			  16'b0000000000001000: hex_digit1 = 4'h3;

			  16'b0000000000010000: hex_digit1 = 4'h4;
			  16'b0000000000100000: hex_digit1 = 4'h5;
			  16'b0000000001000000: hex_digit1 = 4'h6;
			  16'b0000000010000000: hex_digit1 = 4'h7;

			  16'b0000000100000000: hex_digit1 = 4'h8;
			  16'b0000001000000000: hex_digit1 = 4'h9;
			  16'b0000010000000000: hex_digit1 = 4'hA;
			  16'b0000100000000000: hex_digit1 = 4'hB;

			  16'b0001000000000000: hex_digit1 = 4'hC;
			  16'b0010000000000000: hex_digit1 = 4'hD;
			  16'b0100000000000000: hex_digit1 = 4'hE;
			  16'b1000000000000000: hex_digit1 = 4'hF;
			  default:hex_digit2 = 4'h0;
		endcase
endmodule
