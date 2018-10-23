module encoder(ctrl, funct);
	input [7:0] funct;
	output [2:0] ctrl;
		assign ctrl[0] = funct[1] | funct[3] | funct[5] | funct[7];
		assign ctrl[1] = funct[2] | funct[3] | funct[6] | funct[7];
		assign ctrl[2] = funct[4] | funct[5] | funct[6] | funct[7];

endmodule

module priorityencoder(funct,en,ctrl);
input [7:0] funct;
input en;
output reg [2:0] ctrl;
always@(funct or ctrl)
begin
if(!en)
ctrl<=1'b0;
else
casex(funct)
8'b00000001:ctrl<=3'b000;
8'b0000001x:ctrl<=3'b001;
8'b000001xx:ctrl<=3'b010;
8'b00001xxx:ctrl<=3'b011;
8'b0001xxxx:ctrl<=3'b100;
8'b001xxxxx:ctrl<=3'b101;
8'b01xxxxxx:ctrl<=3'b110;
8'b1xxxxxxx:ctrl<=3'b111;
endcase
end
endmodule

module tbenc;
	reg [7:0] funct;
	reg en, Clk;
	wire [2:0] ctrl;
	//encoder enc(ctrl, funct);
	priorityencoder prenc(funct,en,ctrl);
	always @(Clk) Clk <= ~Clk;
	initial
		begin
			$monitor($time, " %b %b", ctrl, funct);
			#2 funct = 8'b01000000;
			#4 funct = 8'b00000001;
		end
endmodule