module mux4_1(regData,q1,q2,q3,q4,reg_no);
/* Add alu_mux.v for mux*/
	input [31:0] q1, q2, q3, q4;
	input [1:0] reg_no;
	output [31:0] regData;
	bit32_4to1mux mux(regData, reg_no, q1, q2, q3, q4);
endmodule

module decoder2_4 (register, reg_no);
input [1:0] reg_no;
output [3:0] register;
wire [3:0] register;
assign register[3] = reg_no[1] & reg_no[0];
assign register[2] = reg_no[1] & ~reg_no[0];
assign register[1] = ~reg_no[1] & reg_no[0];
assign register[0] = ~reg_no[1] & ~reg_no[0];
endmodule

/* module tb_mux_dec;
	reg [31:0] inp1, inp2, inp3, inp4;
	reg [1:0] sel;
	reg clk;
	wire [31:0] op;
	wire [3:0] register;
	mux4_1 m(op,inp1, inp2,inp3,inp4,sel);
	decoder2_4 d(register,sel);
	always @(clk)
	#5 clk<=~clk;
	
	initial
	begin
		$monitor($time, " inp1=%h, inp2=%h, inp3=%h, inp4=%h, sel=%b, op=%h, dec = %b",inp1, inp2, inp3, inp4, sel, op, register);
		 clk=1'b0;
		 inp1 = 32'hAFAFAFAF;
		 inp2 = 32'hBFAFAFAF;
		 inp3 = 32'hCFAFAFAF;
		 inp4 = 32'hDFAFAFAF;
		#2 sel = 2'b00;
		#2 sel = 2'b01;
		#2 sel = 2'b10;
		#2 sel = 2'b11;
		
	end
	
endmodule */