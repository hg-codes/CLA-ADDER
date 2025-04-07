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