module decoder(out, in);
	output [7:0] out;
	input [2:0] in;
	wire [2:0] negin;
	
 	not (negin[0], in[0]);
	not (negin[1], in[1]);
	not (negin[2], in[2]); 

	and (out[7], in[2], in[1], in[0]);
	and (out[6], in[2], in[1], negin[0]);
	and (out[5], in[2], negin[1], in[0]);
	and (out[4], in[2], negin[1], negin[0]);
	and (out[3], negin[2], in[1], in[0]);
	and (out[2], negin[2], in[1], negin[0]);
	and (out[1], negin[2], negin[1], in[0]);
	and (out[0], negin[2], negin[1], negin[0]);
	
	
endmodule


module testbench_dec;
	reg [2:0] in;
	wire [7:0] out;
	decoder d(out, in);
	initial
		begin
			$monitor(,$time, " in = %b, out=%b", in, out);
			#0 in=3'b000;
			#3 in=3'b010;
		end
		
	endmodule
	