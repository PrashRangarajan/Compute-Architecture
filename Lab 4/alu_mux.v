module mux2to1(out, sel, in1, in2);
	input in1, in2, sel;
	output out;
	wire not_sel, a1, a2;
	not (not_sel, sel);
	and (a1, sel, in2);
	and (a2, not_sel, in1);
	or (out, a1, a2);
endmodule

module bit8_2to1mux(out, sel, in1, in2);
input [7:0] in1, in2;
output [7:0] out;
input sel;
mux2to1 m0(out[0], sel, in1[0], in2[0]);
mux2to1 m1(out[1], sel, in1[1], in2[1]);
mux2to1 m2(out[2], sel, in1[2], in2[2]);
mux2to1 m3(out[3], sel, in1[3], in2[3]);
mux2to1 m4(out[4], sel, in1[4], in2[4]);
mux2to1 m5(out[5], sel, in1[5], in2[5]);
mux2to1 m6(out[6], sel, in1[6], in2[6]);
mux2to1 m7(out[7], sel, in1[7], in2[7]);
endmodule

/* module tb_8bit2to1mux;   
	reg [7:0] INP1, INP2;   
	reg SEL;   
	wire [7:0] out;   
	bit8_2to1mux M1(out,SEL,INP1,INP2);   
	initial   
		begin  
			$monitor($time, " Sel = %b, out = %b", SEL, out);
			INP1=8'b10101010;     
			INP2=8'b01010101;     
			SEL=1'b0;     
			#100 SEL=1'b1;     
			#1000 $finish;   
		end 
endmodule */
	
module bit32_2to1mux(out, sel, in1, in2);
	input [31:0] in1, in2;
	output [31:0] out;
	input sel;
	genvar j;
	generate for (j=0; j< 4; j=j+1) begin: mux_loop
		bit8_2to1mux m1(out[8*j+7:8*j], sel, in1[8*j+7:8*j], in2[8*j+7:8*j]);
	end
	endgenerate

endmodule

module bit32_4to1mux(out, sel, in1, in2, in3, in4);
	input [31:0] in1, in2, in3, in4;
	output [31:0] out;
	wire [31:0] o1, o2;
	input[1:0] sel;
	bit32_2to1mux m1(o1, sel[0], in1, in2);
	bit32_2to1mux m2(o2, sel[0], in3, in4);
	bit32_2to1mux m3(out, sel[1], o1, o2);	
endmodule

module bit32_3to1mux(out, sel, in1, in2, in3);
	input [31:0] in1, in2, in3;
	output [31:0] out;
	input[1:0] sel;
	bit32_4to1mux m(out, sel, in1, in2, in3, 32'b0000000000000000);
endmodule

 /* module tb_32bit3to1mux;   
	reg [31:0] INP1, INP2, INP3;   
	reg [1:0] SEL;   
	wire [31:0] out;   
	bit32_3to1mux M1(out,SEL,INP1,INP2, INP3);   
	initial   
		begin  
			$monitor($time, " Sel = %b, out = %b", SEL, out);
			INP1=32'b10101010101010101010101010101010;     
			INP2=32'b01010101010101010101010101010101;    
			INP3=32'b11010101010101010101010101010111;  
			/* INP4=32'b00010101010101010101010101010100;  			 
			SEL=2'b00;     
			#100 SEL=2'b01; 
			#100 SEL=2'b10;  	
			#1000 $finish;   
		end 
endmodule */