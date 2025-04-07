// Carry Look Ahead Adder implementation by Verilog

module Or(
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule

module Or3(
    input a,
    input b,
    input c,
    output out
);
    assign out = a | b | c;
endmodule

module Or4(
    input a,
    input b,
    input c,
    input d,
    output out
);
    assign out = a | b | c | d;
endmodule

module Or5(
    input a,
    input b,
    input c,
    input d,
    input e,
    output out
);
    assign out = a | b | c | d | e;
endmodule

module And(
    input a,
    input b,
    output out
);
    assign out = a & b;
endmodule

module And3(
    input a,
    input b,
    input c,
    output out
);
    assign out = a & (b & c);
endmodule

module And4(
    input a,
    input b,
    input c,
    input d,
    output out
);
    assign out = a & ((b & c) & d);
endmodule

module And5(
    input a,
    input b,
    input c,
    input d,
    input e,
    output out
);
    assign out = a & (((b & c) & d) & e);
endmodule

module Xor(
    input a,
    input b,
    output out
);
    assign out = a ^ b;
endmodule

// D flip-flop for 4-bit input
module D4ff (
    input [3:0] D,
    input clk,
    output [3:0] Q
);
    Dff dff0( D[0], clk, Q[0] );
    Dff dff1( D[1], clk, Q[1] );
    Dff dff2( D[2], clk, Q[2] );
    Dff dff3( D[3], clk, Q[3] );
endmodule

// D flip-flop for 1-bit input
module Dff (
    input D,
    input clk,
    output Q
);
    wire clk_n;
    wire D1, Q_int, Qn;

    // Clock inverter
    not U1 (clk_n, clk);

    // Master latch
    DLatch Master (
        .D(D),
        .clk(clk_n),
        .Q(D1)
    );

    // Slave latch
    DLatch Slave (
        .D(D1),
        .clk(clk),
        .Q(Q)
    );

endmodule

// SR Latch
module DLatch (
    input D,
    input clk,
    output Q
);

    wire Dn, S, R, Qn;

    // Generate Set and Reset signals
    not U1 (Dn, D);
    and U2 (S, D, clk);
    and U3 (R, Dn, clk);

    // SR Latch
    nor U4 (Q, R, Qn);
    nor U5 (Qn, S, Q);

endmodule

module CLAAdder(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    input clk,
    output [3:0] S,
    output Cout
);

    // internal wires

    // G: Generate P: Propagate C: Carry
    wire [3:0] G, P, C;
    // A1, B1: A and B after D flip-flops
    wire [3:0] A1, B1;
    // S1: Sum after carry generation
    wire [3:0] S1;
    wire Cin1;
    // Cin1: Cin after D flip-flop
    wire cc;

    // inputs are feed to D flip-flops and the CLAAdder
    D4ff dff0(A, clk, A1);
    D4ff dff1(B, clk, B1);
    Dff dff4(Cin, clk, Cin1);

    // Carry Generation
    // gi=AiBi
    And and0(A1[0],B1[0],G[0]);
    And and1(A1[1],B1[1],G[1]);
    And and2(A1[2],B1[2],G[2]);
    And and3(A1[3],B1[3],G[3]);

    // Carry Propagation
    // pi=Ai^Bi
    Xor xor0(A1[0],B1[0],P[0]);
    Xor xor1(A1[1],B1[1],P[1]);
    Xor xor2(A1[2],B1[2],P[2]);
    Xor xor3(A1[3],B1[3],P[3]);

    // Carry Calculation Using Carry Generation and Propagation
    
    // c0=g0+p0Cin
    And and4(Cin1,P[0],P0Cin);
    Or or0(P0Cin,G[0],C[0]);

    // c1=g1+p1g0+p1p0Cin
    And and5(P[1],G[0],P1G0);
    And3 and6(P[1],P[0],Cin1,P1P0Cin);
    Or3 or1(G[1],P1G0,P1P0Cin,C[1]);

    // c2=g2+p2g1+p2p1g0+p2p1p0Cin
    And and7(P[2],G[1],P2G1);
    And3 and8(P[2],P[1],G[0],P2P1G0);
    And4 and9(P[2],P[1],P[0],Cin1,P2P1P0Cin);
    Or4 or2(G[2],P2G1,P2P1G0,P2P1P0Cin,C[2]);

    // c3 or cout=g3+p3g2+p3p2g1+p3p2p1g0+p3p2p1p0Cin
    And and10(P[3],G[2],P3G2);
    And3 and11(P[3],P[2],G[1],P3P2G1);
    And4 and12(P[3],P[2],P[1],G[0],P3P2P1G0);
    And5 and13(P[3],P[2],P[1],P[0],G[0],P3P2P1P0G0);
    Or5 or3(G[3],P3G2,P3P2G1,P3P2P1G0,P3P2P1P0G0,C[3]);

    // Sum Calculation
    // si=pi^Ci
    Xor xor4(P[0],Cin1,S1[0]);
    Xor xor5(P[1],C[0],S1[1]);
    Xor xor6(P[2],C[1],S1[2]);
    Xor xor7(P[3],C[2],S1[3]);

    // output carry
    assign cc = C[3];

    // outputs are feed to D flip-flops
    D4ff dff2(S1, clk, S);
    Dff dff3(cc, clk, Cout);

endmodule