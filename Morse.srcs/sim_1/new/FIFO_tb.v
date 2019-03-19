`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FIFO_tb
// Project Name: Morse
//////////////////////////////////////////////////////////////////////////////////


module FIFO_tb();

localparam T = 50;
reg clk, reset;
reg wr;
reg wr_data;
wire full, empty;
wire rd_data;

FIFO uut(.clk(clk), .rst(reset), .wr(wr), .wr_data(wr_data),
         .full(full), .empty(empty), .rd_data(rd_data));
         
always
begin
    clk = 1'b0; #(T/2);
    clk = 1'b1; #(T/2);
end

initial
begin
    reset = 1'b0; #(T*2);
    reset = 1'b1; #(T*2);
    wr = 1'b1;
    wr_data = 1'b1;
    $stop;
end
endmodule
