module MultiMC(PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, NS, Op, S, Clk);
input [5:0] Op;
input [3:0] S;
output [3:0] NS; 
output PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, ALUSrcA, RegWrite, RegDst,  Clk;
input [1:0] PCSource, ALUSrcB, ALUOp;
wire [5:0] NegOp;
wire [3:0] NegS;
wire [16:0] W;

assign W[0] <= ~S[3]&~S[2]&~S[1]&~S[0];
assign W[1] <= ~S[3]&~S[2]&~S[1]&S[0];
assign W[2] <= ~S[3]&~S[2]&S[1]&~S[0];
assign W[3] <= ~S[3]&~S[2]&S[1]&S[0];
assign W[4] <= ~S[3]&S[2]&~S[1]&~S[0];
assign W[5] <= ~S[3]&S[2]&~S[1]&S[0];
assign W[6] <= ~S[3]&S[2]&S[1]&~S[0];
assign W[7] <= ~S[3]&S[2]&S[1]&S[0];
assign W[8] <= S[3]&~S[2]&~S[1]&~S[0];
assign W[9] <= S[3]&~S[2]&~S[1]&S[0];
assign W[10] <= ~S[3]&~S[2]&~S[1]&S[0]&~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0];
assign W[11] <= ~S[3]&~S[2]&~S[1]&S[0&~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0];
assign W[12] <= ~S[3]&~S[2]&~S[1]&S[0]&~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0];
assign W[13] <= ~S[3]&~S[2]&S[1]&~S[0]&Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
assign W[14] <= ~S[3]&~S[2]&~S[1]&S[0]&Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];
assign W[15] <= ~S[3]&~S[2]&~S[1]&S[0]&Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
assign W[16] <= ~S[3]&~S[2]&~S[1]&~S[0]&Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];

assign PCWrite = W[0] | W[9];
assign PCWriteCond <=(S[3]&NegS[2]&NegS[1]&NegS[0]);
assign IorD <= (NegS[3]&NegS[2]&S[1]&S[0]) | (NegS[3]&S[2]&NegS[1]&S[0]);
assign MemRead <= (NegS[3]&NegS[2]&NegS[1]&NegS[0])

always @(posedge Clk)
begin
	
end
endmodule