`timescale 1ps/1ps

module CarryLookAheadAdder_tb;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;
    reg clk;

    // Outputs
    wire [3:0] S;
    wire Cout;
    wire [3:0] A1, B1;
    wire Cin1;
    
    // Instantiate the Unit Under Test (UUT)
    CLAAdder uut (
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .clk(clk), 
        .S(S), 
        .Cout(Cout),
        .A1(A1),
        .B1(B1),
        .Cin1(Cin1)
    );

    initial 
    begin
        $dumpfile("CarryLookAheadAdder_tb.vcd");
        $dumpvars(0, CarryLookAheadAdder_tb);

        // Test cases
        // 15 + 15 = 22
        A = 4'b1111;
        B = 4'b1111;
        Cin = 1'b1;
        clk = 1'b0;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1;

        // 10 +12 +1 = 23
        A = 4'b1010;
        B = 4'b1100;
        Cin = 1'b1;
        clk = 1'b0;

        #1 clk = ~clk;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1;
        // 10 + 8 = 18
        A = 4'b1010;
        B = 4'b1000;
        Cin = 1'b0;
        clk = 1'b0;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1 clk = ~clk;
        $finish;
    end
    
    always @(posedge clk) 
    begin
        #0.1;
        // A B Cin A1 B1 Cin1 S Cout
        // A1 B1 Cin1 are the inputs after Dff
        // S Cout are the outputs after Dff
        $display("A=%b B=%b Cin=%b A1=%b B1=%b Cin1=%b S=%b Cout=%b", A, B, Cin, A1, B1, Cin1, S, Cout);
    end

endmodule