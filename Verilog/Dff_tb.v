`timescale 1ps/1ps

module Dff_tb;

  reg clk;
  reg d;
  wire q;

  Dff Dff_inst (
    .clk(clk),
    .D(d),
    .Q(q)
  );

  initial 
    begin
        $dumpfile("Dff_tb.vcd");
        $dumpvars(0, Dff_tb);

        clk = 0;
        d = 0;
        #40 $finish;
    end

    always  begin
        #2 d=~d;
    end

    always  begin
        #5 clk=~clk;
    end

endmodule   