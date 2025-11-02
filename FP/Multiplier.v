`timescale 1ns/1ps
module Multiplier(Multiplier_in1, Multiplier_in2, Multiplier_out);
    // ChenVadder 20240210
    parameter DATA_WIDTH = 8;

    input  signed  [DATA_WIDTH-1:0]   Multiplier_in1 ;
    input  signed  [DATA_WIDTH-1:0]   Multiplier_in2 ;
    output signed  [2*DATA_WIDTH-1:0] Multiplier_out ;

    assign Multiplier_out = Multiplier_in1*Multiplier_in2;
    
endmodule