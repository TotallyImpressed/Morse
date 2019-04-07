`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FIFO_tb
// Project Name: Morse
//////////////////////////////////////////////////////////////////////////////////


module FIFO_tb();

localparam T = 50;
reg clk, reset;
reg wr, rd;
reg wr_data;
wire full, empty;
wire rd_data;

FIFO uut(.clk(clk), .rst(reset), .wr(wr), .rd(rd), .wr_data(wr_data),
         .full(full), .empty(empty), .r_data(rd_data));
         
always
begin
    clk = 1'b0; #(T/2);
    clk = 1'b1; #(T/2);
end

initial
begin
    rd = 1'b0;
    reset = 1'b0; #(T*2);
    reset = 1'b1; #(T*2);
    wr = 1'b1;
    wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
     wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
     wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
     wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
     wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b1; #(T);
     wr_data = 1'b1; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b0; #(T);
    wr_data = 1'b1; #(T);
    wr_data = 1'b1; #(T);
    wr = 1'b0;
    rd = 1'b1; #(T*9);
    rd = 1'b0;
    $stop;
end
endmodule
