module alu(result,ctrl, a, b);
	input [2:0] ctrl;
	input [3:0] a,b;
	output [3:0] result;
	
	wire [3:0] mi0, mi1, mi2, mi3, mi4, mi5, mi6, mi7;
	assign mi0 = a + b;
	assign mi1 = a - b;
	assign mi2 = a ^ b;
	assign mi3 = a | b;
	assign mi4 = a & b;
	assign mi5 = ~(a | b);
	assign mi6 = ~(a & b);
	assign mi7 = ~(a ^ b);

	mux8to1

endmodule

module mux8to1(out, mi0, mi1, mi2, mi3, mi4, mi5, mi6, mi7, sel);
	input [3:0] mi0, mi1, mi2, mi3, mi4, mi5, mi6, mi7;
	input [2:0] sel;
	output out;
	assign out = in[sel];
endmodule

