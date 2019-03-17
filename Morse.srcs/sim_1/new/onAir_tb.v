`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: onAir_tb
// Project Name: Morse
//////////////////////////////////////////////////////////////////////////////////

module onAir_tb();

localparam T = 50;
reg clk, reset;
reg bin;
wire out;

onAir uut(.clk(clk), .rst(reset), .bin(bin), .out(out));

always
begin
    clk = 1'b1; #(T/2);
    clk = 1'b0; #(T/2);
end

initial
begin
    reset = 1'b0; #(T);
    reset = 1'b1; #(T/2);
    bin = 1'b0; #T;
    bin = 1'b1; #T;
    bin = 1'b0; #(T*7);
    bin = 1'b1; #(T*2);
    bin = 1'b0; #(T*20);
    bin = 1'b0; #(T*30);
    $stop;
end
endmodule