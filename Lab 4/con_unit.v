module MCU(RegDst,ALUSrc, MemtoReg, RegWrite,
MemRead, MemWrite,Branch,ALUOp1,ALUOp2,Op);
input [5:0] Op;
output RegDst,ALUSrc,MemtoReg, RegWrite, MemRead,
MemWrite,Branch,ALUOp1,ALUOp2;
wire Rformat, lw,sw,beq;
assign Rformat= (~Op[0])& (~Op[1])& (~Op[2])& (~Op[3])&
(~Op[4])& (~Op[5]);
assign lw= (Op[0])& (Op[1])& (~Op[2])& (~Op[3])& (~Op[4])& (Op[5]);
assign sw= (Op[0])& (Op[1])& (~Op[2])& (Op[3])&
(~Op[4])& (Op[5]);
assign beq= (~Op[0])& (~Op[1])& (Op[2])& (~Op[3])&
(~Op[4])& (~Op[5]);
assign RegDst=Rformat;
assign ALUSrc = lw | sw;
assign MemtoReg = lw;
assign RegWrite = Rformat | lw;
assign MemRead = lw;
assign MemWrite = sw;
assign Branch = beq;
assign ALUOp1 = Rformat;
assign ALUOp2 = beq;

endmodule

module ALUContr(Operation, F, ALUOp1, ALUOp2);
input [5:0] F;
input ALUOp1, ALUOp2;
output [2:0] Operation;

assign Operation[1] = ~ALUOp2 | ~F[2];
assign Operation[2] = (F[1] & ALUOp2) | ALUOp1;
assign Operation[0] = (F[0] | F[3]) & ALUOp2;

endmodule

module tb_Cont;
reg [5:0] Op;
wire RegDst,ALUSrc,MemtoReg, RegWrite, MemRead,
MemWrite,Branch,ALUOp1,ALUOp2;
MCU m(RegDst,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2,Op);

reg [5:0] F;
reg AOp1, AOp2;
wire [2:0] Operation;
ALUContr AC(Operation, F, AOp1, AOp2);
	initial   
		begin   
			$monitor($time, " %h %h %h %h %h %h %h %h %h",RegDst,ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2);
				Op = 6'b100011;
			#2 Op = 6'b000000;
			#10 $finish;
		end
	initial
		begin
			$monitor($time, " Op =  %b", Operation);
			F = 6'b110010;
			AOp1 = 1'b0;
			AOp2 = 1'b1;
		end
endmodule 

