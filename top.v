`timescale 1ns / 1ps

// Uncomment below for part1: the top module of the 16-bit ripple carry adder
// And uncomment for part3: the top module of the 16-bit behavioral adder

/*
module top(
    input clk,
    input rst,
    output reg [16:0] result
    );
    
    reg [15:0] inputA;
    reg [15:0] inputB;
    wire [15:0] tmp_result;
    wire cout;
 
    // Comment out corresponding line depending on if implementing part1 or part3
    // part1 #(.SIZE(16)) part1_inst(.a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 
    part3 #(.SIZE(16)) part3_inst(.clk(clk), .a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 
  
    always@(posedge clk)
    begin
        result <= {cout,tmp_result};
        if (rst) begin
            inputA <= 16'b0;
            inputB <= 16'b0;
            
        end else begin
            inputA <= inputA + 16'b1;
            if (inputA == 16'hFFFF)
            begin
                inputB <= inputB + 16'b1;
            end
        end
    end
endmodule
*/

// Uncomment below for the top module of the 32-bit ripple carry adder
// And uncomment for part3: the top module of the 32-bit behavioral adder

/*
module top(
    input clk,
    input rst,
    output reg [32:0] result
    );
    
    reg [31:0] inputA;
    reg [31:0] inputB;
    wire [31:0] tmp_result;
    wire cout;
    
    // Comment out corresponding line depending on if implementing part1 or part3
    // part1 #(.SIZE(32)) part1_inst(.a(inputA[31:0]), .b(inputB[31:0]), .cin(1'b0), .s(tmp_result[31:0]), .cout(cout)); 
    part3 #(.SIZE(32)) part3_inst(.clk(clk), .a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 

    always@(posedge clk)
    begin
        result <= {cout,tmp_result};
        
        if (rst) begin
            inputA <= 32'b0;
            inputB <= 32'b0;
            
        end else begin
            inputA <= inputA + 32'b1;
            if (inputA == 32'hFFFFFFFF)
            begin
                inputB <= inputB + 32'b1;
            end
        end
    end
endmodule 
*/

// Uncomment below for the top module of the 64-bit ripple carry adder
// And uncomment for part3: the top module of the 64-bit behavioral adder

/*
module top(
    input clk,
    input rst,
    output reg [64:0] result
    );
    
    reg [63:0] inputA;
    reg [63:0] inputB;
    wire [63:0] tmp_result;
    wire cout;
    
    // Comment out corresponding line depending on if implementing part1 or part3
    // part1 #(.SIZE(64)) part1_inst(.a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 
    part3 #(.SIZE(64)) part3_inst(.clk(clk), .a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 

    always@(posedge clk)
    begin
        result <= {cout,tmp_result};
        
        if (rst) begin
            inputA <= 64'b0;
            inputB <= 64'b0;
            
        end else begin
            inputA <= inputA + 64'b1;
            if (inputA == 64'hFFFFFFFFFFFFFFFF)
            begin
                inputB <= inputB + 64'b1;
            end
        end
    end
endmodule 
*/

// Uncomment below for the top module of part2
// And uncomment for the top module of part4


module top(
    input clk,
    input rst,
    output reg [128:0] result
    );
    
    reg [127:0] inputA;
    reg [127:0] inputB;
    wire [127:0] tmp_result;
    wire cout;
    
    // So now that we declare a part 2 instance, will part 2 have a subinstance of part1?
    
    // Comment out corresponding line depending on if implementing part2 or part4
    part2 part2_inst( .clk(clk), .a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 
    // part4 part4_inst( .clk(clk), .a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout)); 

    always@(posedge clk)
    begin
        result <= {cout,tmp_result};
        
        if (rst) begin
            inputA <= 128'b0;
            inputB <= 128'b0;
            
        end else begin
            inputA <= inputA + 128'b1;
            if (inputA == 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
            begin
                inputB <= inputB + 128'b1;
            end
        end
    end
endmodule

