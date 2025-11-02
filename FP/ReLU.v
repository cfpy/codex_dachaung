`timescale 1ns/1ps
module ReLU(ReLU_in, ReLU_out);
    // ChenVadder 20240210
    // ReLU activation function:output is zero when input is negative, otherwise it's identical
    parameter DATA_WIDTH = 8;

    input   [DATA_WIDTH-1:0]    ReLU_in  ;
    output  [DATA_WIDTH-1:0]    ReLU_out ;   

    assign ReLU_out = ReLU_in[DATA_WIDTH-1] ? 'd0 : ReLU_in    ;

endmodule
