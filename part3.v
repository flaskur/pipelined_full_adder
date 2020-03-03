`timescale 1ns / 1ps


module part3 #(
    parameter SIZE = 16
)(
    // SIZE parameter is default but can be overriden in instantiation.
    input clk,
    input [SIZE-1:0] a,
    input [SIZE-1:0] b,
    input cin,
    output [SIZE-1:0] s,
    output cout
);

    reg [SIZE:0]sum;
    
    always @(posedge clk) begin
        sum <= a + b + cin;
    end


    assign cout = sum[SIZE];
    assign s = sum[SIZE-1:0];

endmodule
