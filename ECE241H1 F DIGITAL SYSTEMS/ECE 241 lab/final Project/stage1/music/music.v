module music (
	// Inputs
	CLOCK_50,
	KEY,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK,
	SW,
	LEDR
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input				CLOCK_50;
input		[3:0]	KEY;
input		[9:0]	SW;

input				AUD_ADCDAT;

// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;

inout				FPGA_I2C_SDAT;

// Outputs
output				AUD_XCK;
output				AUD_DACDAT;
output [9:0]		LEDR;

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

// Internal Registers

reg [13:0] count; // 0 -> 9999
reg [17:0] address; // 0 -> 59999

reg snd;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if(count == 14'd8333) begin
		count <= 14'd0;
		if(address == 18'd8999)
			address <= 18'd0;
		else
			address <= address + 18'd1;
	end 
	else count <= count + 1;
end
/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/
assign LEDR[9:0] = address[15:6];

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
	
	
reg [4:0] soundout;
always @(*)
begin
	case(SW[5:0])
		6'b000000: soundout = ramout00;
		6'b000001: soundout = ramout01;
		6'b000010: soundout = ramout02;
		6'b000011: soundout = ramout03;
		6'b000100: soundout = ramout04;
	
		6'b001000: soundout = ramout10;
		6'b001001: soundout = ramout11;
		6'b001010: soundout = ramout12;
		6'b001011: soundout = ramout13;
		6'b001100: soundout = ramout14;
		
		6'b010000: soundout = ramout20;
		6'b010001: soundout = ramout21;
		6'b010010: soundout = ramout22;
		6'b010011: soundout = ramout23;
		6'b010100: soundout = ramout24;
		
		6'b011000: soundout = ramout30;
		6'b011001: soundout = ramout31;
		6'b011010: soundout = ramout32;
		6'b011011: soundout = ramout33;
		6'b011100: soundout = ramout34;
	
		6'b100000: soundout = ramout40;
		6'b100001: soundout = ramout41;
		6'b100010: soundout = ramout42;
		6'b100011: soundout = ramout43;
		6'b100100: soundout = ramout44;
	
		6'b101000: soundout = ramout50;
		6'b101001: soundout = ramout51;
		6'b101010: soundout = ramout52;
		6'b101011: soundout = ramout53;
		6'b101100: soundout = ramout54;
	endcase
end


wire [31:0] sound = {soundout, {24'b0}};

assign read_audio_in			= audio_in_available & audio_out_allowed;

assign left_channel_audio_out	= left_channel_audio_in+sound;
assign right_channel_audio_out	= right_channel_audio_in+sound;
assign write_audio_out			= audio_in_available & audio_out_allowed;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

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
