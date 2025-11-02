// Network模块：实现神经网络的顶层结构，支持多层（输入层、隐藏层、输出层）参数化配置

module Network#(
    parameter DataWidth         = 8,           // 数据位宽
    parameter N_HiddenLayer     = 1,           // 隐藏层数（可扩展）
    parameter N_InputNeurons    = 192,         // 输入神经元数
    parameter N_HiddenNeurons   = 1,           // 隐藏层神经元数
    parameter N_OutputNeurons   = 1            // 输出神经元数
)
(
    input wire signed   [(DataWidth * N_InputNeurons)                           -1:0]   Input_Layer_Data,        // 输入层数据
    input wire signed   [(DataWidth * N_HiddenNeurons * N_InputNeurons)         -1:0]   Weights_Layer_1,         // 输入层到隐藏层权重
    input wire signed   [(DataWidth * N_HiddenNeurons)                          -1:0]   Bias_Layer_1,            // 隐藏层偏置
    // 可扩展的多隐藏层权重和偏置（已注释，实际可根据需要扩展）
    // input wire signed   [(DataWidth * N_HiddenNeurons * N_HiddenNeurons)        -1:0]   Weights_Layer_2,
    // input wire signed   [(DataWidth * N_HiddenNeurons)                          -1:0]   Bias_Layer_2,
    input wire signed   [(DataWidth * N_OutputNeurons * N_HiddenNeurons)        -1:0]   Weights_Output_Layer,    // 隐藏层到输出层权重
    input wire signed   [(DataWidth * N_OutputNeurons)                          -1:0]   Bias_Output_Layer,       // 输出层偏置
    output wire signed  [(DataWidth * N_OutputNeurons)                          -1:0]   Output_Data              // 输出层结果
);

    // 实例化第一个隐藏层
    Layer #(
        .DataWidth(DataWidth),
        .LayerNo(1),
        .N(N_HiddenNeurons),
        .PreN(N_InputNeurons),
        .ActType("relu") // 使用relu激活
    )   hidden_layer_1(
        .Input_Data_ThisLayer(Input_Layer_Data),
        .Weights_ThisLayer(Weights_Layer_1),
        .Bias_ThisLayer(Bias_Layer_1)
        // .Output_Data_ThisLayer(hidden_layer_1_out) // 输出自动连接
    );

    /*
    // 可扩展的多隐藏层结构（如有多层可取消注释并补充权重、偏置端口）
    Layer #(
        .DataWidth(DataWidth),
        .LayerNo(2),
        .N(N_HiddenNeurons),
        .PreN(N_HiddenNeurons),
        .ActType("relu")
    )   hidden_layer_2(
        .Input_Data_ThisLayer(hidden_layer_1.Output_Data_ThisLayer),
        .Weights_ThisLayer(Weights_Layer_2),
        .Bias_ThisLayer(Bias_Layer_2)
    )

    Layer #(
        .DataWidth(DataWidth),
        .LayerNo(3),
        .N(N_HiddenNeurons),
        .PreN(N_HiddenNeurons),
        .ActType("relu") 
    )   hidden_layer_3(
        .Input_Data_ThisLayer(hidden_layer_2.Output_Data_ThisLayer),
        .Weights_ThisLayer(Weights_Layer_3),
        .Bias_ThisLayer(Bias_Layer_3)
    )
    */

    // 实例化输出层
    Layer #(
        .DataWidth(DataWidth),
        .LayerNo(2),
        .N(N_OutputNeurons),
        .PreN(N_HiddenNeurons),
        .ActType("")    // 输出层不使用激活函数
    )   output_layer_1(
        .Input_Data_ThisLayer(hidden_layer_1.Output_Data_ThisLayer),
        .Weights_ThisLayer(Weights_Output_Layer),
        .Bias_ThisLayer(Bias_Output_Layer),
        .Output_Data_ThisLayer(Output_Data)
    );

endmodule