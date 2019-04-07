`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 03/11/2019 11:40:35 PM 
// Module Name: FIFO
// Project Name: Morse
// Description: FIFO buffer storing symbols or words sent from MCU
//////////////////////////////////////////////////////////////////////////////////

module FIFO #(parameter address_size = 5)
    (
    input clk, rst,
    input wr, rd,
    input wr_data,
    output r_data,
    output full,
    output empty
    );
    
    localparam N = 2 ** address_size;
    
    // Internal registers
    reg[N:0] head, tail; // "fifo_size"-bit counter considering full write/read cycle
    reg[N:0] next_head, next_tail;
    reg[N - 1:0] mem;
    reg full_reg, empty_reg;
    reg next_full_reg, next_empty_reg;
    // Write control signal from output
    wire wr_en;
    
    // FIFO controller logic
    always @(posedge clk)
    if(!rst)
    begin
        tail <= 'b0;
        head <= 'b0;
        full_reg <= 1'b0;
        empty_reg <= 1'b1;
    end
    else
    begin
        tail <= next_tail;
        head <= next_head;
        full_reg <= next_full_reg;
        empty_reg <= next_empty_reg;
    end
    
    // Write to the mem register
    always @(posedge clk)
        if(wr_en)
            mem[head] <= wr_data;
    
    assign r_data = mem[tail];
    assign wr_en = wr & ~full_reg;
    
    // Next-state logic
    always @(*)
    begin
        next_tail = tail;
        next_head = head;
        next_empty_reg = empty_reg;
        next_full_reg = full_reg;
        case({wr,rd})
            2'b01:
                if(~empty_reg)
                begin
                    next_tail = next_tail + 32'b1;
                    next_full_reg = 1'b0;
                    if((head[N - 1:0] == tail[N - 1:0]) & (head[N] == tail[N]))
                        next_empty_reg = 1'b1;
                end 
            2'b10:
                if(~full_reg)
                begin
                    next_head = next_head + 32'b1;
                    next_empty_reg = 1'b0;
                    if((head[N - 1:0] == tail[N - 1:0]) & (head[N] != tail[N]))
                        next_full_reg = 1'b1;
                end 
            2'b11:
                begin
                    next_tail = next_tail + 32'b1;
                    next_head = next_head + 32'b1;
                end
        endcase
    end 
        
    assign empty = empty_reg;
    assign full = full_reg;
     
endmodule
