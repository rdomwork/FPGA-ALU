module alu_wrapper(input  logic [17:0] SW,
					input  logic [2:0] KEY,
				   output logic [9:0] LEDR);
				   
	alu al({23'b0, SW[17:9]}, {23'b0, SW[8:0]}, {3'b0, ~KEY[2:0]}, LEDR[9:0]);
				   
				   
endmodule
				   