module ALU (a,b,Binvert,Carryin,Operation,Result,CarryOut);
input [31:0] a, b;
input Binvert, Carryin;
input [1:0] Operation;
wire [31:0] andout, orout, addout, bmux;
output [31:0] Result;
output CarryOut;

bit32_2to1mux m1(bmux, Binvert, b, ~b);
bit32AND a1(andout, a, b);
bit32OR o1(orout, a, b); 
FA_32bit a2(Carryout, addout, a, bmux, Carryin);
bit32_3to1mux m2(Result, Operation, andout, orout, addout);
endmodule

module tbALU; 
reg Binvert, Carryin; 
reg [1:0] Operation; 
reg [31:0] a,b; 
wire [31:0] Result; 
wire CarryOut; 
ALU a1(a,b,Binvert,Carryin,Operation,Result,CarryOut);  
initial begin a=32'ha5a5a5a5; b=32'h5a5a5a5a; Operation=2'b00; Binvert=1'b0; Carryin=1'b0; //must perform AND resulting in zero #100 
Operation=2'b01; //OR 
#100 
Operation=2'b10; //ADD 
#100
 Binvert=1'b1;//SUB 
 #200 $finish; 
 end 
 endmodule 