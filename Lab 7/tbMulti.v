module tb_Multi;
	reg [5:0] Op;
	wire [3:0] S;
	reg Clk, reset;
	wire PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, ALUSrcA, RegWrite, RegDst;
	wire [1:0] PCSource, ALUSrcB, ALUOp;
	
	always @(Clk)
	#5 Clk<=~Clk;
	
	MultiMC mmc(S, PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, Op, reset, Clk); 
	initial   
		begin 
			$monitor(,$time, " S = %b, PCSource = %b, PCWrite = %b, IRWrite = %b, ALUOp = %b, ALUSrcB = %b, ALUSrcA = %b, RegWrite = %b, RegDst = %b", S, PCSource, PCWrite, IRWrite, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst);
		#0	Clk = 1'b0;
			reset = 1'b0;
		#2	Op = 6'b100011;
			reset = 1'b1;
		
			#100 $finish;   
		end 

endmodule