// Neuron模块：实现神经网络中的单个神经元，功能包括加权乘法、加法树求和、加偏置、激活函数

`timescale 1ns/1ps
module Neuron #(
    parameter Input_Data_Width = 8,         // 输入数据位宽
    parameter Number_of_Inputs = 192,       // 输入数量（上一层神经元数）
    parameter ActType="relu"                // 激活函数类型（如relu、sigmoid等）
)
(
    input           [Input_Data_Width * Number_of_Inputs        -1:0]       data_input  , // 输入数据总线
    input           [Input_Data_Width * Number_of_Inputs        -1:0]       weights     , // 权重总线
    input           [Input_Data_Width                           -1:0]       bias        , // 偏置
    output          [Input_Data_Width                           -1:0]       result        // 输出结果
);

   wire signed     [2 * Input_Data_Width * Number_of_Inputs    -1:0]       mult_ans    ;   // 所有输入与权重乘积结果
   wire signed     [2 * Input_Data_Width                       -1:0]       sum_ans     ;   // 所有乘积求和结果
   wire signed     [Input_Data_Width                           -1:0]       sum_bias    ;   // 加偏置后的结果

    //------------------------------加权乘法------------------------------//
    // 对每个输入和对应权重做乘法，结果拼接到mult_ans总线
    genvar i;
    generate
        for (i = 0; i < Number_of_Inputs; i = i + 1) begin : Mult
            Multiplier #(
                .DATA_WIDTH(Input_Data_Width)
            )   Multiplier_inst  (
                .Multiplier_in1(    data_input      [Input_Data_Width * i       +:  Input_Data_Width]           ), // 第i个输入
                .Multiplier_in2(    weights         [Input_Data_Width * i       +:  Input_Data_Width]           ), // 第i个权重
                .Multiplier_out(    mult_ans        [2 * Input_Data_Width * i   +:  2 * Input_Data_Width]       )  // 第i个乘积
            );
        end
    endgenerate
    
    //---------------------------------加法树求和---------------------------------//
    // 使用AdderTree模块将所有乘积结果累加，得到总和
    AdderTree #(
        .INPUT_DATA_WIDTH(2 * Input_Data_Width),
        .NUM(Number_of_Inputs)
    )   adder_tree_inst (
        .AdderTree_in(mult_ans),
        .AdderTree_out(sum_ans)
    );
    
    //-----------------------------------加偏置---------------------------------//
    // 取加法树结果的高Input_Data_Width位，与偏置做饱和加法
    SaturationAdder #(
        .n(Input_Data_Width)
    ) sat_adder (
        .in1(sum_ans[2 * Input_Data_Width-1  -:  Input_Data_Width]), // 取高位
        .in2(bias),
        .SaturationAdder_result(sum_bias)
    );

    //----------------------------------激活函数------------------------------------// 
    // 根据参数选择激活函数，默认为relu，否则直接输出
    generate
        if(ActType == "relu") begin
            ReLU #(
                .DATA_WIDTH(Input_Data_Width)
            )   ReLu_ins (
                .ReLU_in(sum_bias),
                .ReLU_out(result)
            );
        end else begin
            assign result = sum_bias;
        end
    endgenerate
  
endmodule