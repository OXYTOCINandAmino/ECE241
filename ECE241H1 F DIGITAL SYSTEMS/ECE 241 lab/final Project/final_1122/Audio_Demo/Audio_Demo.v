module Audio_Demo (
//Input From top module
   reset_address, //when note is called, played from start
   is_play, //[1-play BGM]
   Sound_mode,
   note_out,
// Inputs
	CLOCK_50,
	KEY,
//	SW,
	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
////Input From top module
input    reset_address;
input    is_play;
input    [2:0]Sound_mode; //[0 square wave] [1 guitar sound][2 drum sound][3 ocean]
input		[31:0] note_out;

// Inputs
input				CLOCK_50;
input		[3:0]	KEY;
//JUST FOR TEST
//input    [1:0] SW;
input				AUD_ADCDAT;

// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;

inout				FPGA_I2C_SDAT;

// Outputs
output				AUD_XCK;
output				AUD_DACDAT;

output				FPGA_I2C_SCLK;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires
wire				audio_in_available;
wire		[31:0]	left_channel_audio_in;
wire		[31:0]	right_channel_audio_in;
wire				read_audio_in;

wire				audio_out_allowed;
wire		[31:0]	left_channel_audio_out;
wire		[31:0]	right_channel_audio_out;
wire				write_audio_out;

/////////////////////////////////////////////////////////////////////////////
////////////////////////START OF EDIT////////////////////////////////////////


////////////////////////////////START OF SQUARE WAVE//////////////////////////////////
//TEST sound for note_out[CHECKED]
//wire [31:0]note_out=32'd1;

reg [4:0] frequency;

//correspond frequency to each note_out
always @(*)
begin
	case(note_out)
		32'd1: frequency = 5'd0;
		32'd2: frequency = 5'd1;
		32'd4: frequency = 5'd2;
		32'd8: frequency = 5'd3;
		32'd16: frequency = 5'd4;
		32'd32: frequency = 5'd5;
		
		32'd64: frequency = 5'd6;
		32'd128: frequency = 5'd7;
		32'd256: frequency = 5'd8;
		32'd512: frequency = 5'd9;
		32'd1024: frequency = 5'd10;
		32'd2048: frequency = 5'd11;
		
		32'd4096: frequency = 5'd12;
		32'd8192: frequency = 5'd13;
		32'd16384: frequency = 5'd14;
		32'd32768: frequency = 5'd15;
		32'd65536: frequency = 5'd16;
		32'd131072: frequency = 5'd17;
		
		32'd262144: frequency = 5'd18;
		32'd524288: frequency = 5'd19;
		32'd1048576: frequency = 5'd20;
		32'd2097152: frequency = 5'd21;
		32'd4194304: frequency = 5'd22;
		32'd8388608: frequency = 5'd23;
		
		32'd16777216: frequency = 5'd24;
		32'd33554432: frequency = 5'd25;
		32'd67108864: frequency = 5'd26;
		32'd134217728: frequency = 5'd27;
		32'd268435456: frequency = 5'd28;
		32'd536870912: frequency= 5'd29;
		
	default: frequency= 5'd30;
	endcase
	
end



//TEST sound for increment frequency[CHECKED]

//reg [4:0]frequency;
//
//always @(posedge SW[0])
//begin
//   if(SW[1]==1)
//	begin
//	frequency <= 5'd0;
//	end
//	
//	else
//	begin
//	if(frequency == 5'd29)
//		frequency <= 5'd0;
//	else frequency <= frequency + 1;
//	end
//end


//Test Sound for different frequency [CHECKED]
//wire [4:0] frequency = 5'd1;

///////////////////////////////////////////////////////////////////
reg [18:0] delay_cnt;
reg [18:0] delay;
reg snd;

always @(*)
begin
	case(frequency)
		5'd0: delay =19'd606796;
		5'd1: delay =19'd454545;
		5'd2: delay =19'd340599;
		5'd3: delay =19'd255102;
		5'd4: delay =19'd202429;
		5'd5: delay =19'd218340;
		
		5'd6: delay =19'd572737;
		5'd7: delay =19'd429184;
		5'd8: delay =19'd321336;
		5'd9: delay =19'd240847;
		5'd10: delay =19'd191570;
		5'd11: delay =19'd143266;
		
		5'd12: delay =19'd540540;
		5'd13: delay =19'd404858;
		5'd14: delay =19'd303398;
		5'd15: delay =19'd227272;
		5'd16: delay =19'd180505;
		5'd17: delay =19'd135135;
		
		5'd18: delay =19'd510204;
		5'd19: delay =19'd382262;
		5'd20: delay =19'd287356;
		5'd21: delay =19'd214592;
		5'd22: delay =19'd170648;
		5'd23: delay =19'd127551;
		
		5'd24: delay =19'd485436;
		5'd25: delay =19'd362318;
		5'd26: delay =19'd270270;
		5'd27: delay =19'd202429;
		5'd28: delay =19'd160771;
		5'd29: delay =19'd120481;
		
	default: delay =19'd500000;
	endcase
	
end

//Test Sound for different delay [CHECKED]
//wire [18:0] delay =19'd454545;
//wire [18:0] delay =19'd218340;

always @(posedge CLOCK_50)
begin
   if(delay == 19'd500000)// when no signal make no sound
	   snd <= 0;
	
	else begin
	if(delay_cnt == delay) begin
		delay_cnt <= 0;
		snd <= !snd;
	end
	else delay_cnt <= delay_cnt + 1;
   end
end


//control the voice
wire [31:0] sound_square = snd ? 32'd10000000 : -32'd10000000;
////////////////////////////////END OF SQUARE WAVE////////////////////////////



////////////////////////////////START OF GUITAR WAVE//////////////////////////

//increment of address
reg [13:0] count; // 
reg [17:0] address; // Guitar_sound
reg [17:0] D_address; // Drum_sound
reg [17:0] O_address; // Ocean_sound


always @(posedge CLOCK_50)
begin
	if(count == 14'd8333) begin
		count <= 14'd0;
		if(reset_address == 1)
			address <= 18'd0;
		else if(address < 18'd8999)
			address <= address + 18'd1;
			
		if(reset_address == 1)
			D_address <= 18'd0;
		else if(D_address < 18'd4261)
			D_address <= D_address + 18'd1;
			
		if(O_address == 18'd30000)
			O_address <= 18'd0;
		else
			O_address <= O_address + 18'd1;
	end 
	else count <= count + 1;
end
//

//Load sound from register to ramout
wire [4:0] ramout00;
wire [4:0] ramout01;
wire [4:0] ramout02;
wire [4:0] ramout03;
wire [4:0] ramout04;

wire [4:0] ramout10;
wire [4:0] ramout11;
wire [4:0] ramout12;
wire [4:0] ramout13;
wire [4:0] ramout14;

wire [4:0] ramout20;
wire [4:0] ramout21;
wire [4:0] ramout22;
wire [4:0] ramout23;
wire [4:0] ramout24;

wire [4:0] ramout30;
wire [4:0] ramout31;
wire [4:0] ramout32;
wire [4:0] ramout33;
wire [4:0] ramout34;

wire [4:0] ramout40;
wire [4:0] ramout41;
wire [4:0] ramout42;
wire [4:0] ramout43;
wire [4:0] ramout44;

wire [4:0] ramout50;
wire [4:0] ramout51;
wire [4:0] ramout52;
wire [4:0] ramout53;
wire [4:0] ramout54;

S0P0 w0(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout00));
	
S0P1 w1(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout01));
	
S0P2 w2(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout02));

S0P3 w3(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout03));
	
S0P4 w4(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout04));
////////////////////
S1P0 w5(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout10));
	
S1P1 w6(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout11));
	
S1P2 w7(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout12));

S1P3 w8(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout13));
	
S1P4 w9(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout14));
////////////////////
S2P0 w10(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout20));
	
S2P1 w11(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout21));
	
S2P2 w12(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout22));

S2P3 w13(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout23));
	
S2P4 w14(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout24));
////////////////////
S3P0 w15(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout30));
	
S3P1 w16(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout31));
	
S3P2 w17(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout32));

S3P3 w18(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout33));
	
S3P4 w19(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout34));
////////////////////
S4P0 w20(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout40));
	
S4P1 w21(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout41));
	
S4P2 w22(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout42));

S4P3 w23(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout43));
	
S4P4 w24(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout44));
////////////////////
S5P0 w25(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout50));
	
S5P1 w26(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout51));
	
S5P2 w27(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout52));

S5P3 w28(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout53));
	
S5P4 w29(
	.address(address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(ramout54));
	

///corespond frequency to each ramout
reg [4:0] soundout;
always @(*)
begin
	case(frequency)
		5'd0: soundout = ramout00;
		5'd6: soundout = ramout01;
		5'd12: soundout = ramout02;
		5'd18: soundout = ramout03;
		5'd24: soundout = ramout04;
	
		5'd1: soundout = ramout10;
		5'd7: soundout = ramout11;
		5'd13: soundout = ramout12;
		5'd19: soundout = ramout13;
		5'd25: soundout = ramout14;
		
		5'd2: soundout = ramout20;
		5'd8: soundout = ramout21;
		5'd14: soundout = ramout22;
		5'd20: soundout = ramout23;
		5'd26: soundout = ramout24;
		
		5'd3: soundout = ramout30;
		5'd9: soundout = ramout31;
		5'd15: soundout = ramout32;
		5'd21: soundout = ramout33;
		5'd27: soundout = ramout34;
	
		5'd4: soundout = ramout40;
		5'd10: soundout = ramout41;
		5'd16: soundout = ramout42;
		5'd22: soundout = ramout43;
		5'd28: soundout = ramout44;
	
		5'd5: soundout = ramout50;
		5'd11: soundout = ramout51;
		5'd17: soundout = ramout52;
		5'd23: soundout = ramout53;
		5'd29: soundout = ramout54;
		default: soundout =5'd0;
	endcase
end


wire [31:0] G_sound = {soundout, {24'b0}};

////////////////////////////////DRUM///////////////////////////////////////////
wire [4:0] drumout1;
wire [4:0] drumout2;
wire [4:0] drumout3;
wire [4:0] drumout4;

drum1 d1(
	.address(BGM_address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(drumout1));
//
drum2 d2(
	.address(BGM_address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(drumout2));
//
drum3 d3(
	.address(BGM_address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(drumout3));
//
drum4 d4(
	.address(BGM_address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(drumout4));
//

wire [31:0] drum_sound = {drumout, {24'b0}};
///////////////////////////////OCEAN//////////////////////////////////////////
wire [4:0] waveout;

wave Wave0(
	.address(O_address),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(waveout));
	//
wire [31:0] ocean_sound = {waveout, {24'b0}};

////////////////////////////////END OF GUITAR WAVE////////////////////////////
//selecting Guitar wave [0 square wave] [1 guitar sound][2 drum sound][3 ocean]

reg  [31:0] sound;
always @(*)
begin
if(Sound_mode==0)begin
sound = sound_square;
end
if(Sound_mode==1)begin
sound = G_sound;
end
if((Sound_mode==2)&&(is_play==1))begin
sound = drum_sound;
end
if((Sound_mode==3)&&(is_play==1))begin
sound = ocean_sound;
end
end
//




/////////////////////////Fixed module DONT CHANGE/////////////////////////
assign read_audio_in			= audio_in_available & audio_out_allowed;
assign left_channel_audio_out	= left_channel_audio_in + sound;
assign right_channel_audio_out	= right_channel_audio_in + sound;
assign write_audio_out			= audio_in_available & audio_out_allowed;


Audio_Controller Audio_Controller (
	// Inputs
	.CLOCK_50						(CLOCK_50),
	.reset						(~KEY[0]),

	.clear_audio_in_memory		(),
	.read_audio_in				(read_audio_in),

	.clear_audio_out_memory		(),
	.left_channel_audio_out		(left_channel_audio_out),
	.right_channel_audio_out	(right_channel_audio_out),
	.write_audio_out			(write_audio_out),

	.AUD_ADCDAT					(AUD_ADCDAT),

	// Bidirectionals
	.AUD_BCLK					(AUD_BCLK),
	.AUD_ADCLRCK				(AUD_ADCLRCK),
	.AUD_DACLRCK				(AUD_DACLRCK),


	// Outputs
	.audio_in_available			(audio_in_available),
	.left_channel_audio_in		(left_channel_audio_in),
	.right_channel_audio_in		(right_channel_audio_in),

	.audio_out_allowed			(audio_out_allowed),

	.AUD_XCK					(AUD_XCK),
	.AUD_DACDAT					(AUD_DACDAT)

);

avconf #(.USE_MIC_INPUT(1)) avc (
	.FPGA_I2C_SCLK					(FPGA_I2C_SCLK),
	.FPGA_I2C_SDAT					(FPGA_I2C_SDAT),
	.CLOCK_50					(CLOCK_50),
	.reset						(~KEY[0])
);

endmodule
