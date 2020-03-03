`timescale 1ns / 1ps

// Conceptually a full adder has an A, B, and Cin. The output should be Sum and Cout.
// The digital logic behind Sum is A xor B xor Cin.
// The digital logic behind Cout is (A and B) or ((A xor B) and Cin)
// The idea is to create a ripple carry adder using multiple full adders that feed into each other.

// This is structural logic using gates and no always blocks. 

// STRUCTURAL LOGIC -> ONLY DIGITAL GATES
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    wire axorb;
    
    wire aandb;
    wire axorbandcin;

    // Sum logic...
    xor(axorb, a, b);
    xor(sum, axorb, cin);

    // Cout logic...
    and(aandb, a, b);
    and(axorbandcin, axorb, cin);
    or(cout, aandb, axorbandcin);

endmodule
