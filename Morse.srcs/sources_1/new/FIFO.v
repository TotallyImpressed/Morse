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
    input wr,
    input wr_data,
    output r_data,
    output full,
    output empty
    );
    // Internal registers
    reg[fifo_size:0] head, tail; // n-bit counts crossing through the full write/read cycle
    reg[fifo_size - 1:0] mem;
    reg full_reg, empty_reg;
    reg r_data_reg;
    // Write control signal from output
    wire wr_en;
    
    // Writing data in FIFO
    always @(posedge clk, negedge rst)
    begin
    if(!rst) tail <= 'b0;
    else
    begin 
        if(wr_en) 
            begin
                mem[tail] <= wr_data;
                tail <= tail +'b1;
            end
        end        
    end
    
    assign wr_en = wr & ~full_reg;
    // Reading data from FIFO
    always @(posedge clk, negedge rst)
    begin
        if(!rst) head <= 'b0;
        else
        begin
            if(~empty_reg)
            begin
                r_data_reg = mem[head];
                head <= head + 'b1;
            end
        end
    end
    assign r_data = r_data_reg;
    // Full state logic
    always @(posedge clk, negedge rst)
    if(!rst) full_reg <= 1'b0;
    else if((head[fifo_size - 1:0] != tail[fifo_size - 1:0]) & (head[fifo_size] == tail[fifo_size]))
        full_reg <= 1'b1;
    else
        full_reg <= 1'b0;
    // Empty state logic    
    always @(posedge clk, negedge rst)
    if(!rst) empty_reg <= 1'b0;
    else if((head[fifo_size - 1:0] == tail[fifo_size - 1:0]) & (head[fifo_size] == tail[fifo_size]))
        empty_reg <= 1'b1;
    else
        empty_reg <= 1'b0;
        
    assign empty = empty_reg;
    assign full = full_reg;
     
endmodule
