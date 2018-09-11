module FA_dataflow (Cout, Sum,In1,In2,Cin);   
	input In1,In2;   
	input Cin;   
	output Cout;   
	output Sum;     
	assign {Cout,Sum}=In1+In2+Cin; 
endmodule 

module FA_32bit(Cout, Sum,In1,In2,Cin);
	input [31:0] In1, In2;
	input Cin;
	output [31:0] Sum;
	output Cout;
	genvar j;
	wire[31:0] temp;
	
	FA_dataflow f(temp[0], Sum[0], In1[0], In2[0], Cin);
	generate for (j=1; j<32; j = j+1) 
	begin: add_loop
		FA_dataflow f(temp[j], Sum[j], In1[j], In2[j], temp[j-1]);
	end
	assign Cout = temp[31];
	endgenerate
	
endmodule

module tb32bitfa;   
	reg [31:0] In1, In2;
	reg Cin;
	wire [31:0] Sum; 
	wire Cout;	
	FA_32bit f(Cout, Sum,In1,In2,Cin);
	initial   
		begin   
			$monitor($time, " Sum = %h, Cout=%b",Sum, Cout);
			In1=32'hA5A5A5A4;     
			In2=32'h5A5A5A5A;   
			Cin = 1'b1;
			#400 $finish;   
		end
endmodule 
	
	