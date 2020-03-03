`timescale 1ns / 1ps

// Instantiation in top module...
// part1 #(.SIZE(16)) part1_inst(.a(inputA), .b(inputB), .cin(1'b0), .s(tmp_result), .cout(cout));


module part1 #(
    parameter SIZE = 16
)(
    // SIZE parameter is default but can be overriden in instantiation.
    input [SIZE-1:0] a,
    input [SIZE-1:0] b,
    input cin,
    output [SIZE-1:0] s,
    output cout
);

    // Assuming the issue is that the s output needs a wire for intermediate changes. Maybe a register instead.
    wire [SIZE-1:0] sum_track;
    
    // You need this to let cout of one full adder to feed into the cin of another.
    wire [SIZE:0] c;
    
    // The initial cin is c[0] since we use it for generate.
    assign c[0] = cin;




    // Thought Process Comments -> Ignore.
    
    // Might need intermediate wires for this...
    // So you need to declare 16 full adders and we use i for a reason.
    // Since we start off with a 16 bit a, b, and sum, we likely have to index it.
    // So the first full adder should accept a cin, a, and b. The result should be an output for sum and cout.
    // The cout of the first full adder should feed into the input of the second full adder as cin.
    // Confused about how this generate function works. Essentially you are creating 16 instances of a full adder.
    // When it first runs, full adder takes 0 index for a and b. Cin also accepted. Sum should also be in that index.
    // What portion explains how it sets cout to feed into cin? You need a wire to set it up.
    // We use a intermediate 17 bit wire to transfer between cout and cin of different full adders.
    // So the cin in the beginning is actually c wire [0]. Initialize that?
    // Remember the point is that the full adder is a function that is called. This is top level.
    // The real cout is not assigned until the end. We are just editing a wire.
    // I have to do c[0] = cin first right?
    // Not sure. Anyways, the top level makes a single instance of part1 and part 1 generates 16 instances of the full adder.
    // Okay, so the point is definitely to compare structural and behavioral. 
    // Parts 1 and 2 are equivalent to 3 and 4 but use behavioral logic. Does that mean I need to change the full adder?
    // The actual part is not structural or behavioral. It uses a structural declaration of full adder.
    // So, for the second part we have to pipeline multiple full adders that are 16 bits.
    // A ripple carry adder is a full adder right? A ripple carry adder has multiple single bit full adders.
    // So part1 is essentially the same as a arbitrary size full adder? Why is 128 not possible?
    // One thing I did not consider is that sum is a output but I did not assign it.
    // Assuming that sum does not need to be assigned because full adder does it for me.
    
    
    
    

    // Generate 16 instances of the 1 bit full adder. We use the c wire to hold the carry of the result of each full adder.    
    genvar i;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin : gen_full_adders
            full_adder full_adder_instance(.a(a[i]), .b(b[i]), .cin(c[i]), .sum(s[i]), .cout(c[i + 1]));
        end
    endgenerate

    // I think you should use SIZE instead of 16.
    assign cout = c[SIZE];
    
endmodule
