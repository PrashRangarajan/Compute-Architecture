/* Needs Register.v*/

module PLA(PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, NS, Op, S);
input [5:0] Op;
input [3:0] S;
output [3:0] NS; 
output PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, ALUSrcA, RegWrite, RegDst;
output [1:0] PCSource, ALUSrcB, ALUOp;
wire [16:0] W;

assign W[0] = ~S[3]&~S[2]&~S[1]&~S[0];
assign W[1] = ~S[3]&~S[2]&~S[1]&S[0];
assign W[2] = ~S[3]&~S[2]&S[1]&~S[0];
assign W[3] = ~S[3]&~S[2]&S[1]&S[0];
assign W[4] = ~S[3]&S[2]&~S[1]&~S[0];
assign W[5] = ~S[3]&S[2]&~S[1]&S[0];
assign W[6] = ~S[3]&S[2]&S[1]&~S[0];
assign W[7] = ~S[3]&S[2]&S[1]&S[0];
assign W[8] = S[3]&~S[2]&~S[1]&~S[0];
assign W[9] = S[3]&~S[2]&~S[1]&S[0];
assign W[10] = ~S[3]&~S[2]&~S[1]&S[0]&~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0];
assign W[11] = ~S[3]&~S[2]&~S[1]&S[0]&~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0];
assign W[12] = ~S[3]&~S[2]&~S[1]&S[0]&~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0];
assign W[13] = ~S[3]&~S[2]&S[1]&~S[0]&Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
assign W[14] = ~S[3]&~S[2]&~S[1]&S[0]&Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];
assign W[15] = ~S[3]&~S[2]&~S[1]&S[0]&Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
assign W[16] = ~S[3]&~S[2]&~S[1]&~S[0]&Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];

assign PCWrite = W[0] | W[9];
assign PCWriteCond = W[8];
assign IorD = W[3] | W[5];
assign MemRead = W[0] | W[3];
assign MemWrite = W[5];
assign IRWrite = W[0];
assign MemtoReg = W[4];
assign PCSource[1] = W[9];
assign PCSource[0] = W[8];
assign ALUOp[1] = W[6];
assign ALUOp[0] = W[8];
assign ALUSrcB[1] = W[1] | W[2];
assign ALUSrcB[0] = W[0] | W[1];
assign ALUSrcA = W[2] | W[6] | W[8];
assign RegWrite = W[4] | W[7];
assign RegDst = W[7];

assign NS[3] = W[10] | W[11];
assign NS[2] = W[3] | W[6] | W[12] | W[13];
assign NS[1] = W[6] | W[12] | W[14] | W[15] | W[16];
assign NS[0] = W[0] | W[6] | W[10] | W[13] | W[16];

endmodule

module MultiMC(S, PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, Op, reset, Clk);
input [5:0] Op;
output [3:0] S;
wire [3:0] NS; 
input Clk, reset;
output PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, ALUSrcA, RegWrite, RegDst;
output [1:0] PCSource, ALUSrcB, ALUOp;
PLA pla(PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, NS, Op, S);

reg_4bit rg(S,NS,Clk,reset);
endmodule