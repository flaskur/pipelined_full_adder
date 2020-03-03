`timescale 1ns / 1ps

// I'm not sure if I understand conceptually how it works, but I believe that you just need a much of pipelines represented by registers and delays on the input A, B and output sum.
module part4(
    input clk,
    input [127:0] a,
    input [127:0] b,
    input cin,
    output [127:0] s,
    output cout
);
    
    reg [31:0] pipe2_indelay1;
    
    reg [31:0] pipe3_indelay1;
    reg [31:0] pipe3_indelay2;
    
    reg [31:0] pipe4_indelay1;
    reg [31:0] pipe4_indelay2;
    reg [31:0] pipe4_indelay3;
    
    reg [31:0] pipe5_indelay1;
    reg [31:0] pipe5_indelay2;
    reg [31:0] pipe5_indelay3;
    reg [31:0] pipe5_indelay4;
    
    reg [31:0] pipe6_indelay1;
    reg [31:0] pipe6_indelay2;
    reg [31:0] pipe6_indelay3;
    reg [31:0] pipe6_indelay4;
    reg [31:0] pipe6_indelay5;
    
    reg [31:0] pipe7_indelay1;
    reg [31:0] pipe7_indelay2;
    reg [31:0] pipe7_indelay3;
    reg [31:0] pipe7_indelay4;
    reg [31:0] pipe7_indelay5;
    reg [31:0] pipe7_indelay6;
    
    reg [31:0] pipe8_indelay1;
    reg [31:0] pipe8_indelay2;
    reg [31:0] pipe8_indelay3;
    reg [31:0] pipe8_indelay4;
    reg [31:0] pipe8_indelay5;
    reg [31:0] pipe8_indelay6;
    reg [31:0] pipe8_indelay7;
    
    // Each full adder should have a sum result that is 16 bits. I need to feed that into the output delay pipeline. The last one doesn't have it so it should just assign directly to sum.
    // Should this be a wire or a reg? It's the output of the full adder module and it assigns sum. But the goal is to set the out delay.
    wire [15:0] sum_out1;
    wire [15:0] sum_out2;
    wire [15:0] sum_out3;
    wire [15:0] sum_out4;
    wire [15:0] sum_out5;
    wire [15:0] sum_out6;
    wire [15:0] sum_out7;
    wire [15:0] sum_out8; // don't feed into out delay.
    // Since we intend on setting outdelay inside of the always block with <= and not assign register for delay seems appropriate. Since the full adder module uses assign, the sum set as wire seems appropriate as well.
    
    // Represent the output delay. The first fa should have 7 delay stages.
    reg [15:0] pipe1_outdelay1;
    reg [15:0] pipe1_outdelay2;
    reg [15:0] pipe1_outdelay3;
    reg [15:0] pipe1_outdelay4;
    reg [15:0] pipe1_outdelay5;
    reg [15:0] pipe1_outdelay6;
    reg [15:0] pipe1_outdelay7;
    
    reg [15:0] pipe2_outdelay1;
    reg [15:0] pipe2_outdelay2;
    reg [15:0] pipe2_outdelay3;
    reg [15:0] pipe2_outdelay4;
    reg [15:0] pipe2_outdelay5;
    reg [15:0] pipe2_outdelay6;
    
    reg [15:0] pipe3_outdelay1;
    reg [15:0] pipe3_outdelay2;
    reg [15:0] pipe3_outdelay3;
    reg [15:0] pipe3_outdelay4;
    reg [15:0] pipe3_outdelay5;
    
    reg [15:0] pipe4_outdelay1;
    reg [15:0] pipe4_outdelay2;
    reg [15:0] pipe4_outdelay3;
    reg [15:0] pipe4_outdelay4;
    
    reg [15:0] pipe5_outdelay1;
    reg [15:0] pipe5_outdelay2;
    reg [15:0] pipe5_outdelay3;
    
    reg [15:0] pipe6_outdelay1;
    reg [15:0] pipe6_outdelay2;
    
    reg [15:0] pipe7_outdelay1;
    
    wire pipe1_carry;
    wire pipe2_carry;
    wire pipe3_carry;
    wire pipe4_carry;
    wire pipe5_carry;
    wire pipe6_carry;
    wire pipe7_carry; 
    wire pipe8_carry;
    
    
    // No concurrent assignment, so I probably need a wire to the output and just register as a state that I take from. Unfortunately that means a lot of declarations.
    // I can definitely assign a wire.
    part3 #(.SIZE(16)) full_adder_one(.clk(clk), .a(a[15:0]), .b(b[15:0]), .cin(cin), .s(sum_out1), .cout(pipe1_carry));
    part3 #(.SIZE(16)) full_adder_two(.clk(clk), .a(pipe2_indelay1[31:16]), .b(pipe2_indelay1[15:0]), .cin(pipe1_carry), .s(sum_out2), .cout(pipe2_carry));
    part3 #(.SIZE(16)) full_adder_three(.clk(clk), .a(pipe3_indelay2[31:16]), .b(pipe3_indelay2[15:0]), .cin(pipe2_carry), .s(sum_out3), .cout(pipe3_carry));
    part3 #(.SIZE(16)) full_adder_four(.clk(clk), .a(pipe4_indelay3[31:16]), .b(pipe4_indelay3[15:0]), .cin(pipe3_carry), .s(sum_out4), .cout(pipe4_carry));
    part3 #(.SIZE(16)) full_adder_five(.clk(clk), .a(pipe5_indelay4[31:16]), .b(pipe5_indelay4[15:0]), .cin(pipe4_carry), .s(sum_out5), .cout(pipe5_carry));
    part3 #(.SIZE(16)) full_adder_six(.clk(clk), .a(pipe6_indelay5[31:16]), .b(pipe6_indelay5[15:0]), .cin(pipe5_carry), .s(sum_out6), .cout(pipe6_carry));
    part3 #(.SIZE(16)) full_adder_seven(.clk(clk), .a(pipe7_indelay6[31:16]), .b(pipe7_indelay6[15:0]), .cin(pipe6_carry), .s(sum_out7), .cout(pipe7_carry));
    part3 #(.SIZE(16)) full_adder_eight(.clk(clk), .a(pipe8_indelay7[31:16]), .b(pipe8_indelay7[15:0]), .cin(pipe7_carry), .s(sum_out8), .cout(pipe8_carry));
    
    assign cout = pipe8_carry;
    // Issue with concatenating wires and reg?
    assign s = {sum_out8, pipe7_outdelay1, pipe6_outdelay2, pipe5_outdelay3, pipe4_outdelay4, pipe3_outdelay5, pipe2_outdelay6, pipe1_outdelay7};
    
    always @(posedge clk) begin
        
        // Register state assignments and moving the pipeline down.
        // Does the assignment fail on second cycle? Input should change...
        pipe2_indelay1 <= {a[31:16], b[31:16]};
        
        pipe3_indelay1 <= {a[47:32], b[47:32]};
        pipe3_indelay2 <= pipe3_indelay1;
        
        // THIS IS THE ERROR! FORGOT TO INCREMENT B
        pipe4_indelay1 <= {a[63:48], b[63:48]};
        pipe4_indelay2 <= pipe4_indelay1;
        pipe4_indelay3 <= pipe4_indelay2;
        
        pipe5_indelay1 <= {a[79:64], b[79:64]};
        pipe5_indelay2 <= pipe5_indelay1;
        pipe5_indelay3 <= pipe5_indelay2;
        pipe5_indelay4 <= pipe5_indelay3;
        
        pipe6_indelay1 <= {a[95:80], b[95:80]};
        pipe6_indelay2 <= pipe6_indelay1;
        pipe6_indelay3 <= pipe6_indelay2;
        pipe6_indelay4 <= pipe6_indelay3;
        pipe6_indelay5 <= pipe6_indelay4;
        
        pipe7_indelay1 <= {a[111:96], b[111:96]};
        pipe7_indelay2 <= pipe7_indelay1;
        pipe7_indelay3 <= pipe7_indelay2;
        pipe7_indelay4 <= pipe7_indelay3;
        pipe7_indelay5 <= pipe7_indelay4;
        pipe7_indelay6 <= pipe7_indelay5;
        
        pipe8_indelay1 <= {a[127:112], b[127:112]};
        pipe8_indelay2 <= pipe8_indelay1;
        pipe8_indelay3 <= pipe8_indelay2;
        pipe8_indelay4 <= pipe8_indelay3;
        pipe8_indelay5 <= pipe8_indelay4;
        pipe8_indelay6 <= pipe8_indelay5;
        pipe8_indelay7 <= pipe8_indelay6;
        
        
        // Now the output sum pipelines...
        pipe1_outdelay1 <= sum_out1;
        pipe1_outdelay2 <= pipe1_outdelay1;
        pipe1_outdelay3 <= pipe1_outdelay2;
        pipe1_outdelay4 <= pipe1_outdelay3;
        pipe1_outdelay5 <= pipe1_outdelay4;
        pipe1_outdelay6 <= pipe1_outdelay5;
        pipe1_outdelay7 <= pipe1_outdelay6;
        
        pipe2_outdelay1 <= sum_out2;
        pipe2_outdelay2 <= pipe2_outdelay1;
        pipe2_outdelay3 <= pipe2_outdelay2;
        pipe2_outdelay4 <= pipe2_outdelay3;
        pipe2_outdelay5 <= pipe2_outdelay4;
        pipe2_outdelay6 <= pipe2_outdelay5;
        
        pipe3_outdelay1 <= sum_out3;
        pipe3_outdelay2 <= pipe3_outdelay1;
        pipe3_outdelay3 <= pipe3_outdelay2;
        pipe3_outdelay4 <= pipe3_outdelay3;
        pipe3_outdelay5 <= pipe3_outdelay4;
        
        pipe4_outdelay1 <= sum_out4;
        pipe4_outdelay2 <= pipe4_outdelay1;
        pipe4_outdelay3 <= pipe4_outdelay2;
        pipe4_outdelay4 <= pipe4_outdelay3;
        
        pipe5_outdelay1 <= sum_out5;
        pipe5_outdelay2 <= pipe5_outdelay1;
        pipe5_outdelay3 <= pipe5_outdelay2;
        
        pipe6_outdelay1 <= sum_out6;
        pipe6_outdelay2 <= pipe6_outdelay1;
        
        pipe7_outdelay1 <= sum_out7;
        
    end
    

endmodule
