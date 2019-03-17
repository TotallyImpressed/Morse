`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/27/2019 10:17:49 PM
// Project Name:  Morse
// Module name: onAir
// Description: FSM that sends Morse codes with corresponding duration to the output 
//////////////////////////////////////////////////////////////////////////////////


module onAir(
input clk, rst,
input bin,
input data_valid,
output busy,
output out
    );

localparam point_shift = 3;
localparam dash_shift = 9;
localparam space_shift = 21;

reg [1:0] cnt_flag = 2'b00;
reg [4:0] cnt_point, cnt_dash, cnt_space;    
reg [2:0] state, next_state;
always @(posedge clk, negedge rst)
begin
    if(!rst)
    begin
        cnt_point <= 'b0;
        cnt_dash <= 'b0;
        cnt_space <= 'b0;
        state <= 'b0;
    end
    else
    begin
        state <= next_state;
        case(cnt_flag)
            2'b01: cnt_point <= cnt_point + 'b1;
            2'b10: cnt_dash <= cnt_dash + 'b1;
            2'b11: cnt_space <= cnt_space + 'b1;
            2'b00: begin
                        cnt_point <= 'b0;
                        cnt_dash <= 'b0;
                        cnt_space <= 'b0;
                    end
            default:
                    begin
                        cnt_point <= 'b0;
                        cnt_dash <= 'b0;
                        cnt_space <= 'b0;
                    end
        endcase
    end
end


always @(*)
begin
cnt_flag = 'b0;
next_state = 'b0;
    if(data_valid)
    case(state)
        3'b000: if(bin) next_state = 3'b001;
                else    next_state = 3'b101;
        3'b001: if(bin) next_state = 3'b011;
                else    next_state = 3'b010;
        // Point duration condition
        3'b010: // Point counter logic
                begin
                    cnt_flag = 2'b01;
                    if(cnt_point == point_shift - 1) 
                    begin
                        cnt_flag = 2'b00;
                        if(bin) next_state = 3'b001;
                        else    next_state = 3'b000;
                    end
                end
        3'b011: if(bin) next_state = 3'b000;
                else    next_state = 3'b100;
        // Dash duration condition
        3'b100: // Dash counter logic
                begin
                    cnt_flag = 2'b10;
                    if(cnt_dash == dash_shift - 1)
                    begin
                        cnt_flag = 2'b00;
                        if(bin) next_state = 3'b001;
                        else    next_state = 3'b000;
                    end 
                end
        3'b101: if(bin) next_state = 3'b001;
                else    next_state = 3'b110;
        3'b110: if(bin) next_state = 3'b111;
                else    next_state = 3'b000;
        // Space duration condition
        3'b111: //Space counter logic
                begin
                    cnt_flag = 2'b11;
                    if(cnt_space == space_shift - 1)
                    begin
                        cnt_flag = 2'b00;
                        if(bin) next_state = 3'b011;
                        else    next_state = 3'b000;
                    end
                 end
        default: next_state = 3'b000;
   endcase
end

assign out = cnt_flag;
assign busy = (cnt_flag != 2'b00);
endmodule
