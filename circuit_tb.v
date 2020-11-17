`timescale 1ns / 1ps
`include "iob_lib.vh"

`define W 98

module circuit_tb;

   `CLOCK(clk, 10)
   `RESET(rst, 1, 10)
   `SIGNAL(x, 32)
   `SIGNAL(en, 1)
   `SIGNAL_OUT(y, `W)

   integer i;
   
   initial begin
      $dumpfile("circuit.vcd");
      $dumpvars();
      en=0;
      x=0;
      for (i=0; i<100; i=i+1) begin
         @(posedge clk) #1 en=1; x=$urandom%1024;
      end

      $display("%d", y);
      @(posedge clk) #100 $finish;

   end 

   circuit
     #(
       .W(`W)
       ) 
   c0
     (
      .rst(rst),
      .clk(clk),
      .en(en),
      .x(x),
      .y(y)
      );


endmodule
