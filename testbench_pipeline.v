`timescale 1ns / 1ps

// So this test bench is used to test the pipelining feature of parts 2 and 4.
// It doesn't have any inputs or outputs. Is that normal? Yeah it's normal.
// So you have multiple pieces of state. It's essentially the same idea of adding two 128 bit numbers together.
// The result is the sum -> temp result and the carry out which is a wire. 
module testbench_pipeline();
    reg clk;
    reg [127:0] inputA;
    reg [127:0] inputB;
    wire [127:0] tmp_result;
    
    wire cout;
 
    
    // You can use these arguments. Notice that it takes the entirety of the 128 bits. 
    // part2  part2_inst(.a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout),.clk(clk));  
    part4  part4_inst(.clk(clk), .a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout),.clk(clk));  
     
    always
        #5 clk = !clk; 
        
    initial begin
        clk <= 0;
        inputA <= 16'd0;
        inputB <= 16'd0;
        
      
        #10
      
        
        inputA <= 128'h11111111;
        inputB <= 128'h11111111;
        #10
      
        
        inputA <= inputA<<8;
        inputB<= inputB<<8;
        
        #10
      
      
        inputA <= inputA<<8;
        inputB<= inputB<<8;
        
       
        #10
        
      
        
        inputA <= inputA<<8;
        inputB <= inputB<<8;
        #10
        
        inputA<=0;
        inputB<=0;
        #100
        
        $finish;
    end
   
endmodule
