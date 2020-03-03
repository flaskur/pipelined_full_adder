`timescale 1ns / 1ps

// This only tests the 16 bit adder which is part 1. 
// If testbench makes a part1 instance what was the point of top level module?
// This one at least has initialized values. 

module testbench();
    reg clk;
    reg [15:0] inputA;
    reg [15:0] inputB;
    wire [15:0] tmp_result;
    wire cout;
 
    
    part3 #(.SIZE(16)) part3_inst(.clk(clk), .a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 

    always
        #5 clk = !clk; 
        
    
    initial begin
        clk <= 0;
        inputA <= 16'd0;
        inputB <= 16'd0;
        #60
        $display($time, "%10d + %10d = %10d",inputA, inputB, tmp_result);
        inputA <= 16'd1;
        inputB <= 16'd1;
        #60
        $display($time, "%10d + %10d = %10d",inputA, inputB, tmp_result);
        inputA <= 16'd14;
        inputB <= 16'd11;
        #60
        $display($time, "%10d + %10d = %10d",inputA, inputB, tmp_result);
        inputA <= 16'd300;
        inputB <= 16'd300;
        #60
        $display($time, "%10d + %10d = %10d",inputA, inputB, tmp_result);
        // Testing that the carry out works as expected...
        inputA <= 16'hFFFF;
        inputB <= 16'hFFFF;
        #60
        $display($time, "%10d + %10d = %10d",inputA, inputB, tmp_result);
        inputA <= 16'hFFFF;
        inputB <= 16'b1000_0000_0000_0000;
        // I expect the result to be 1_0111_1111_1111_1111.
        #60
        $display($time, "%10d + %10d = %10d",inputA, inputB, tmp_result);
        $finish;
    end
   
endmodule
