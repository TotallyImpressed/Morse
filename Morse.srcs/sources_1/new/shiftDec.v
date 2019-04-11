`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 04/07/2019 07:44:47 PM 
// Module Name: shiftDec
// Project Name:  
// Tool Versions: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module shiftDec(
    input clk, rst_n, dec_en,
    input [5:0] char,
    output valid,
    output shift_out
    );
    
    localparam [5:0] A = 7'd65, B = 7'd66, C = 7'd67,
                     D = 7'd68, E = 7'd69, F = 7'd70,
                     G = 7'd71, H = 7'd72, I = 7'd73,
                     J = 7'd74, K = 7'd75, L = 7'd76,
                     M = 7'd77, N = 7'd78, O = 7'd79,
                     P = 7'd80, Q = 7'd81, R = 7'd82,
                     S = 7'd83, T = 7'd84, U = 7'd85,
                     V = 7'd86, W = 7'd87, X = 7'd88,
                     Y = 7'd89, Z = 7'd90;
    localparam [5:0] d_0 = 7'd48, d_1 = 7'd49, d_2 = 7'd50,
                     d_3 = 7'd51, d_4 = 7'd52, d_5 = 7'd53,
                     d_6 = 7'd54, d_7 = 7'd55, d_8 = 7'd56,
                     d_9 = 7'd57;
                     
    reg [13:0] dec_out;
    reg [13:0] shift_reg;
    
    always @(*)
    if(dec_en)
    begin
        case(char)
            A: dec_out = 14'b10110000000000;
            B: dec_out = 14'b11010101000000;
            C: dec_out = 14'b11010110100000;
            D: dec_out = 14'b11010100000000;
            E: dec_out = 14'b10000000000000;
            F: dec_out = 14'b10101101000000;
            G: dec_out = 14'b11011010000000;
            H: dec_out = 14'b10101010000000;
            I: dec_out = 14'b10100000000000;
            J: dec_out = 14'b10110110110000;
            K: dec_out = 14'b11010110000000;
            L: dec_out = 14'b10110101000000;
            M: dec_out = 14'b11011000000000;
            N: dec_out = 14'b11010000000000;
            O: dec_out = 14'b11011011000000;
            P: dec_out = 14'b10110110100000;
            Q: dec_out = 14'b11011010110000;
            R: dec_out = 14'b10110100000000;
            S: dec_out = 14'b10101000000000;
            T: dec_out = 14'b11000000000000;
            U: dec_out = 14'b10101100000000;
            V: dec_out = 14'b10101011000000;
            W: dec_out = 14'b10110110000000;
            X: dec_out = 14'b11010101100000;
            Y: dec_out = 14'b11010110110000;
            Z: dec_out = 14'b11011010100000;
            d_0: dec_out = 14'b11011011011011;
            d_1: dec_out = 14'b10110110110110;
            d_2: dec_out = 14'b10101101101100;
            d_3: dec_out = 14'b10101011011000;
            d_4: dec_out = 14'b10101010110000;
            d_5: dec_out = 14'b10101010100000;
            d_6: dec_out = 14'b11010101010000;
            d_7: dec_out = 14'b11011010101000;
            d_8: dec_out = 14'b11011011010100;
            d_9: dec_out = 14'b11011011011010;
        endcase
    end
    
    always @(posedge clk, negedge rst_n)
    begin
        shift_reg <= dec_out;
        shift_reg <= {shift_reg[12:0], 1'b0};
    end
    
    assign valid = (shift_reg != 0);
    assign shift_out = shift_reg[13];
endmodule
