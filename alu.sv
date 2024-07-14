module alu(input  logic [31:0] A, B,
		   input  logic [2:0]  ALUControl,
		   output logic [31:0] result);
		   
	logic [31:0] condinvB, sum;
	logic cout;
	
	//logic for inverting B and subtraction
	assign condinvB = ALUControl[0] ? ~B: B;
	assign {cout, sum} = A + condinvB + ALUControl[0];
	
	//case statement for ALUControl output
	always_comb
		case (ALUControl)
			3'b000:		result = sum;
			3'b001:		result = sum;
			3'b010:		result = A & B;
			3'b011:		result = A | B;
			3'b101:		result = sum[31];
		default: 			result = 32'bx;
		endcase

endmodule