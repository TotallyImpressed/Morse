`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 03/11/2019 11:40:35 PM 
// Module Name: FIFO
// Project Name: Morse
// Description: FIFO buffer storing symbols or words sent from MCU
//////////////////////////////////////////////////////////////////////////////////


module FIFO #(parameter fifo_size = 256)
    (
    input clk, rst,
    input wr, rd,
    input wr_data,
    output r_data,
    output full,
    output empty
    );
    // Internal registers
    reg[fifo_size - 1:0] head, next_head;
    reg[fifo_size - 1:0] tail, next_tail;
    reg[fifo_size - 1:0] mem;
    reg full_reg, empty_reg;
    reg r_data_reg;
    // Write control signal from output
    wire wr_en;
    //reset module
    always @(posedge clk, negedge rst)
    begin
        if(!rst)
        begin
            head <= 'b0;
            tail <= 'b0;
            empty_reg <= 1'b1;
            full_reg <= 1'b0;
        end
    end
    // Writing data in FIFO by using head pointer
    always @(posedge clk)
        if(wr_en) 
        begin
            mem[tail] <= wr_data;
            tail <= tail +'b1;
        end
        
    assign r_data = mem[head];
   
    always @(*)
    begin
        next_tail = tail + 'b1;
        next_head = head + 'b1;
    end
     
endmodule
