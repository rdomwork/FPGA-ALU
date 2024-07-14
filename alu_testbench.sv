//to be changed

module testbench_alu();
  logic        clk, reset;
  logic [31:0] A, B, result, result_expected;
  logic [2:0]  ALUControl;
  logic [31:0] vectornum, errors;
  logic [98:0] testvectors[10000:0];

  // instantiate device under test
  alu dut(A, B, ALUControl, result);

  // generate clock
  always 
    begin
      clk = 1; #5; clk = 0; #5;
    end

  // at start of test, load vectors
  // and pulse reset
  initial
    begin
      $readmemh("alu.txt", testvectors);
      vectornum = 0; errors = 0;
      reset = 1; #27; reset = 0;
    end

  // apply test vectors on rising edge of clk
  always @(posedge clk)
    begin
      #1; {ALUControl, A, B, result_expected} = testvectors[vectornum];
    end

  // check results on falling edge of clk
  always @(negedge clk)
    if (~reset) begin // skip during reset
      if (result !== result_expected) begin  // check result
        $display("Error: inputs = %h", ALUControl);
        $display("  outputs = %h (%h expected)", result, result_expected);
        errors = errors + 1;
      end
      vectornum = vectornum + 1;
      if (testvectors[vectornum] === 99'bx) begin 
        $display("%d tests completed with %d errors", 
	           vectornum, errors);
        $stop;
      end
    end
endmodule
