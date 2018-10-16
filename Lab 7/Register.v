module d_ff(q,d,clk,reset);
input d, reset, clk;
output q;
reg q;

always @(negedge reset or posedge clk)
begin
	if (!reset) q <= 1'b0;
	else q <=d;
end
endmodule


module reg_4bit(q,d,clk,reset);
input [3:0] d;
input clk, reset;
output [3:0] q;

genvar j;
generate for (j=0; j<4; j = j+1) 
	begin: reg_loop
		d_ff d(q[j], d[j], clk, reset);
	end
endgenerate
endmodule

module reg_32bit(q,d,clk,reset);
input [31:0] d;
input clk, reset;
output [31:0] q;
wire [31:0] q;

genvar j;
generate for (j=0; j<32; j = j+1) 
	begin: reg_loop
		d_ff d(q[j], d[j], clk, reset);
	end
endgenerate
endmodule

