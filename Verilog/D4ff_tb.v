`timescale 1ps/1ps

module D4ff_tb;

    reg clk;
    reg [3:0] d;
    wire [3:0] q;

    D4ff D4ff_inst (
        .clk(clk),
        .D(d),
        .Q(q)
    );

    initial 
    begin
        $dumpfile("D4ff_tb.vcd");
        $dumpvars(0, D4ff_tb);

        clk = 0;
        d = 0;
        #40 $finish;
    end

    always
    begin
        // d is now 4 bit number
        #2 d[0]=~d[0];
        #2 d[1]=~d[1];
        #2 d[2]=~d[2];
        #2 d[3]=~d[3];
    end

    always  
    begin
        #5 clk=~clk;
    end
endmodule   