module multiplier(input logic [7:0] mand, 
				  input logic Clk, Reset, Execute, ClearA_loadB,
				  output logic [6:0] AhexU, AhexL, BhexU, BhexL, 
				  output logic [7:0] Aval, Bval, 
				  output logic X);
	logic shoutA, shoutB, XtoA, addsub_en, subtraction_en, clear_load;
	logic shft_en;
	logic [8:0] sumA;
	logic [7:0] doutA, doutB;

	control ctr(
				.clearA_loadB(ClearA_loadB), 
				.reset(Reset), 
				.execute(Execute), 
				.clk(Clk), 
				.bout(shoutB),

				.Shift_en(shft_en), 
				.Sub_en(subtraction_en), 
				.clr_ld(clear_load),
				.addsub(addsub_en)
				);

	carry_select_adder_9bit adder1(
									.sub_en(subtraction_en),
									.A({mand[7], mand}), 
								   	.B({doutA[7], doutA}), //the value in register A
								   	.Sum(sumA), 
								   	.CO()
								   	);

<<<<<<< HEAD
	flip_flop_mod regX(
=======
	flip_flop_mod reg_X(
>>>>>>> 41d6fbe693c084d0918aa7f1541ce494b1b5fc72
					.clk(Clk), 
					.din(sumA[8]),
					.load(addsub_en),
					.reset(clear_load | Reset),
					.dout(XtoA)
					);

	shift_reg_8bit regA(
						.clk(Clk), 
						.reset(clear_load | Reset), 
						.load(addsub_en), 
						.shift_en(shft_en), 
						.shift_in(XtoA), 
						.din(sumA[7:0]), 
						.shift_out(shoutA), 
						.dout(doutA[7:0])
						); 

	shift_reg_8bit regB(
						.clk(Clk), 
						.reset(Reset), 
						.load(clear_load), 
						.shift_en(shft_en), 
						.shift_in(shoutA), 
						.din(mand), 
						.shift_out(shoutB), 
						.dout(doutB)
						); 

	HexDriver hexUA(.In0(doutA[7:4]), .Out0(AhexU));
   HexDriver hexUB(.In0(doutB[7:4]), .Out0(BhexU));	
	HexDriver hexLA(.In0(doutA[3:0]), .Out0(AhexL));
	HexDriver hexLB(.In0(doutB[3:0]), .Out0(BhexL));
	
	always_comb begin
	 Aval = doutA;
	end
	always_comb begin
	 Bval = doutB;
	end
	
	//sync button_sync[2:0] (Clk, {}
	
	
						
						
						
endmodule













