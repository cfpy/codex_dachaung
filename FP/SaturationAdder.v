`timescale 1ns/1ps
module SaturationAdder #(parameter n = 8) (
    input signed [n-1:0] in1,
    input signed [n-1:0] in2,
    output signed [n-1:0] SaturationAdder_result
//    output of
);

    wire [n - 1 :0] out = in1 + in2;
    
    // Overflow？
    wire of = ((in1[n-1] & in2[n-1] & ~out[n-1]) | (~in1[n-1] & ~in2[n-1] & out[n-1]));
   //11 0|00 1 0
   //10 0|01 1 0
   //01 0|10 1 0
   //00 0|11 1 1
   // Intermediate register
    reg signed [n-1:0] result_reg;

    // Saturate on overflow
    always @* begin
        if (of) begin
            if (in1[n-1] & in2[n-1]) //  Both inputs are negative, result should be the minimum negative value
                result_reg = {1'b1, {(n-1){1'b0}}}; //第一位是1，后面有n-1位的0 
            else //Both inputs are positive, result should be the maximum positive value
                result_reg = {1'b0, {(n-1){1'b1}}}; //第一位是0，后面有n-1位的1
        end else begin
            result_reg = out;
        end
    end

    assign SaturationAdder_result = result_reg;
    
endmodule