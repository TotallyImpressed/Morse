`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 04/07/2019 07:44:47 PM 
// Module Name: shiftDec
// Project Name:  
// Tool Versions: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////


module shiftDec(
    input clk, dec_en,
    input [5:0] char,
    output dec_out
    );
    
    localparam [5:0] A = 6'd65, B = 6'd66, C = 7'd67,
                     D = 7'd68, E = 7'd69, F = 7'd70,
                     G = 7'd71, d = 7'd72, I = 7'd73,
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
    always @(*)
    if(dec_en)
    begin
        case(char)
            A: dec_out = 10'b01010101;
            B: dec_out = 3'b010;
//            C:
//            D:
//            E:
//            F:
//            G:
//            H:
//            I:
//            J:
//            K:
//            L:
//            M:
//            N:
//            O:
//            P:
//            Q:
//            R:
//            S:
//            T:
//            U:
//            V:
//            W:
//            X:
//            Y:
//            Z:
//            0:
//            d_1:
//            d_2:
//            d_3:
//            d_4:
//            d_5:
//            d_6:
//            d_7:
//            d_8:
//            d_9
        endcase
    end
    
endmodule
