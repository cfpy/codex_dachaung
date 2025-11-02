module FP#(
    parameter MAIN_TAP          = 2         ,   // 输出神经元数
    parameter PRE_TAP           = 1         ,   // 前置tap数
    parameter POST_TAP          = 1         ,   // 后置tap数
    parameter TOTAL_TAP         = 1 * 4     ,   // 输入总tap数
    parameter INPUT_DATA_WIDTH  = 8         ,   // 输入数据位宽
    parameter N_HIDDEN          = 2             // 隐藏层神经元数
)
(
    input wire clk,
    input wire reset,
    input wire [INPUT_DATA_WIDTH * MAIN_TAP                 -1:0]           input_data                      , // 当前输入数据
    input wire [INPUT_DATA_WIDTH * TOTAL_TAP * N_HIDDEN     -1:0]           weight_input_to_hidden          , // 输入层到隐藏层权重
    input wire [INPUT_DATA_WIDTH * N_HIDDEN * MAIN_TAP      -1:0]           weight_hidden_to_output         , // 隐藏层到输出层权重
    input wire  [INPUT_DATA_WIDTH * N_HIDDEN                -1:0]           bias_hidden                     , // 隐藏层偏置
    input wire  [INPUT_DATA_WIDTH * MAIN_TAP                -1:0]           bias_output                     , // 输出层偏置
    output wire [INPUT_DATA_WIDTH * MAIN_TAP                -1:0]           decision_layer_output           , // 输出层结果
    output wire [2 * MAIN_TAP                               -1:0]           decision_layer_flag             , // 输出层标志位
    output reg  [2 * MAIN_TAP                               -1:0]           output_result                   , // 最终输出结果

    input wire     [INPUT_DATA_WIDTH * TOTAL_TAP                   -1:0]           input_data_all                 , // 全部输入数据
    output wire    [INPUT_DATA_WIDTH * TOTAL_TAP                   -1:0]           input_data_all_w                   // 输出全部输入数据
);

    //-------------------输入数据拼接----------------------//
    // 这里可以实现输入数据的时序缓存和拼接，便于后续网络处理
    // 相关代码已注释，实际使用时可根据需要启用

    // 直接将输入数据总线赋值给输出
    assign input_data_all_w = input_data_all;

    //-------------------神经网络实例化----------------------//
    // 实例化 Network 神经网络模块，参数化各层神经元数量和数据宽度
    Network #(
        .DataWidth(INPUT_DATA_WIDTH),
        .N_HiddenLayer(N_HIDDEN),
        .N_InputNeurons(TOTAL_TAP),
        .N_HiddenNeurons(N_HIDDEN),
        .N_OutputNeurons(MAIN_TAP)
    )   network(
        .Input_Layer_Data(input_data_all_w),         // 输入层数据
        .Weights_Layer_1(weight_input_to_hidden),    // 输入层到隐藏层权重
        .Bias_Layer_1(bias_hidden),                  // 隐藏层偏置
        .Weights_Output_Layer(weight_hidden_to_output), // 隐藏层到输出层权重
        .Bias_Output_Layer(bias_output),             // 输出层偏置
        .Output_Data(decision_layer_output)          // 输出层结果
    );

    //-------------------硬判决标志位生成----------------------//
    genvar j;
    generate 
        for(j = 0; j < MAIN_TAP; j = j + 1) begin: hd
            // 从输出层结果中提取判决标志位
            assign decision_layer_flag[2 * j    +:  2]  =   decision_layer_output[INPUT_DATA_WIDTH * j + 5  +:  2];
        end
    endgenerate

    //---------------输出结果时序寄存-------------------//
    always  @(posedge clk or posedge reset) begin
        if(reset)   
            output_result <=  'b0;                   // 复位时输出清零
        else        
            output_result <=  decision_layer_flag;   // 正常时输出判决标志位
    end

endmodule