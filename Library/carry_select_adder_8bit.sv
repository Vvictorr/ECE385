module carry_select_adder_8bit
(
    input   logic[7:0]     A,
    input   logic[7:0]     B,
    output  logic[7:0]     Sum,
    output  logic          CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	logic C1;
	four_bit_adder fba(.A1(A[3:0]), .B1(B[3:0]), .CIN(1'b0), .SUM1(Sum[3:0]), .COUT(C1));
    csa4 cs1(.a(A[7:4]), .b(B[7:4]), .cin(C1), .sum(Sum[7:4]), .cout(CO));
endmodule

module csa4(input logic [3:0] a, b,
				input logic cin,
				output logic [3:0]sum, 
				output logic cout);
	logic [3:0] s0, s1;
	logic c0, c1;
	four_bit_adder fba0(.A1(a), .B1(b), .CIN(1'b0), .SUM1(s0), .COUT(c0));
	four_bit_adder fba1(.A1(a), .B1(b), .CIN(1'b1), .SUM1(s1), .COUT(c1));
	mux_21 m0(.d0(s0[0]), .d1(s1[0]), .sel(cin), .out(sum[0]));
	mux_21 m1(.d0(s0[1]), .d1(s1[1]), .sel(cin), .out(sum[1]));
	mux_21 m2(.d0(s0[2]), .d1(s1[2]), .sel(cin), .out(sum[2]));
	mux_21 m3(.d0(s0[3]), .d1(s1[3]), .sel(cin), .out(sum[3]));
	mux_21 mC(.d0(c0), .d1(c1), .sel(cin), .out(cout));
endmodule 