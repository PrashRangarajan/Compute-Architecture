module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
input [1:0] ReadReg1, ReadReg2, WriteReg;
input [31:0] WriteData;
input clk, reset, RegWrite;
output [31:0] ReadData1, ReadData2, q1, q2, q3, q4;
wire [3:0] dop, rclk;
decoder2_4 d(dop,WriteReg);

genvar j;
generate for (j=0; j<3; j = j+1) 
	begin: and_loop
		assign rclk[j] = clk & RegWrite & dop[j];
	end
endgenerate

reg_32bit r1(q1,WriteData,rclk[0],reset);
reg_32bit r2(q2,WriteData,rclk[1],reset);
reg_32bit r3(q3,WriteData,rclk[2],reset);
reg_32bit r4(q4,WriteData,rclk[3],reset);

 mux4_1 m1(ReadData1,q1,q2,q3,q4,ReadReg1);
 mux4_1 m2(ReadData2,q1,q2,q3,q4,ReadReg2);
endmodule

module rf_tb;
	reg [1:0] ReadReg1, ReadReg2, WriteReg;
	reg [31:0] WriteData;
	reg clk, reset;
	reg RegWrite;
	wire [31:0] ReadData1, ReadData2;
	RegFile r(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
	
	always @(clk)
	#5 clk<=~clk;
	
	initial
		begin
		$monitor($time, " Read1 = %h, Read2 = %h, q1 = %h", ReadData1,ReadData2, r.q1);
		#0 reset = 1'b0;
		#0 clk = 1'b1;
		#10 reset = 1'b1;
		#4 WriteData = 32'hBFAFAFAF;
		#5 WriteReg = 2'b00;
		#5 RegWrite = 1'b1;
		#5 RegWrite = 1'b0;
		#5 WriteReg = 2'b01;
		#5 WriteData = 32'hCFAFAFAF;
		#5 RegWrite = 1'b1;
		#5 ReadReg1 = 2'b00;
		#5 ReadReg2 = 2'b01;
		#20 $finish;
		end


endmodule

