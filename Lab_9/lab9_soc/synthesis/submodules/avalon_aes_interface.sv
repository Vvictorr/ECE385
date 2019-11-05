/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);

	logic [31:0] outreg [16];

	always_ff @ (posedge CLK) begin
		if(RESET) begin
			for(int i = 0; i < 16; i++) begin
				outreg[i] <= 32'd0;
			end
		end
		else if(AVL_WRITE && AVL_CS) begin
			if(AVL_BYTE_EN[0] == 1'b1)
				outreg[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];
			if(AVL_BYTE_EN[1] == 1'b1)
				outreg[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];
			if(AVL_BYTE_EN[2] == 1'b1)
				outreg[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
			if(AVL_BYTE_EN[3] == 1'b1)
				outreg[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
		end
	end

	always_comb begin
		EXPORT_DATA = {outreg[0][31:16], outreg[3][15:0]};
		AVL_READDATA = (AVL_READ && AVL_CS) ? outreg[AVL_ADDR] : 32'd0;
	end 


endmodule