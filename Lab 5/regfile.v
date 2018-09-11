module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
input [1:0] ReadReg1, ReadReg2, WriteReg;
input [31:0] WriteData;
input clk, reset;
input RegWrite;
output [31:0] ReadData1, ReadData2;
wire [3:0] dop, rclk, q1, q2, q3, q4;
decoder2_4 d(dop,ReadReg1);

genvar j;
generate for (j=0; j<3; j = j+1) 
	begin: and_loop
		assign rclk[j] = clk[j] & RegWrite & dop[j];
	end
endgenerate

reg_32bit r1(q1,WriteData,rclk,reset);
reg_32bit r2(q2,WriteData,rclk,reset);
reg_32bit r3(q3,WriteData,rclk,reset);
reg_32bit r4(q4,WriteData,rclk,reset);

endmodule