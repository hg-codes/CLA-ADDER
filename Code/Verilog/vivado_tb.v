`timescale 1ps/1ps

module vivado_tb;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;
    reg clk;

    // Outputs
    wire [3:0] S;
    wire Cout;
    
    // Instantiate the Unit Under Test (UUT)
    CLAAdder uut (
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .clk(clk), 
        .S(S), 
        .Cout(Cout)
    );

    initial 
    begin
        $dumpfile("Vivado_tb.vcd");
        $dumpvars(0, vivado_tb);

        // Test cases
        // 15 + 7 = 22
        A = 4'b1001;
        B = 4'b1001;
        Cin = 1'b1;
        clk = 1'b0;

        #5 clk = ~clk;
        #5 clk = ~clk;
        #5 clk = ~clk;
        #5 clk = ~clk;
        $finish;
    end
    
    always @(posedge clk) 
    begin
        #0.1;
        // A B Cin A1 B1 Cin1 S Cout
        // A1 B1 Cin1 are the inputs after Dff
        // S Cout are the outputs after Dff
        $display("A=%b B=%b Cin=%b S=%b Cout=%b", A, B, Cin, S, Cout);
    end

endmodule