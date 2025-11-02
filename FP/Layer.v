// Layer模块：实现神经网络中的一层，支持参数化神经元数量、输入数量、数据宽度和激活类型

module Layer #(
    DataWidth = 8,          // 数据位宽
    LayerNo = 1,            // 层编号
    N = 10,                 // 当前层神经元数量
    PreN = 10,              // 前一层神经元数量
    ActType="relu"          // 激活函数类型（如relu、sigmoid等）
)
(
    input wire signed   [(DataWidth * PreN)     -1:0]   Input_Data_ThisLayer      , // 当前层输入数据（来自上一层，展平为一维总线）
    input wire signed   [(DataWidth * N * PreN) -1:0]   Weights_ThisLayer         , // 当前层所有神经元的权重（展平为一维总线）
    input wire signed   [(DataWidth * N)        -1:0]   Bias_ThisLayer            , // 当前层所有神经元的偏置（展平为一维总线）
   output wire signed  [(DataWidth * N)        -1:0]   Output_Data_ThisLayer       // 当前层所有神经元的输出（展平为一维总线）
);

    // 用generate语句批量实例化N个神经元，每个神经元分配对应的权重和偏置
    genvar i;
    generate 
        for(i = 0; i < N; i = i + 1) begin : neurons
            Neuron #(
                .Input_Data_Width(DataWidth),    // 输入数据位宽
                .Number_of_Inputs(PreN),         // 输入数量（上一层神经元数）
                .ActType(ActType)                // 激活函数类型
            )   neuron (
                .data_input(    Input_Data_ThisLayer                                                        ), // 所有神经元共享同一输入数据
                .weights(       Weights_ThisLayer       [(DataWidth * PreN * i)     +:  DataWidth * PreN    ]), // 为第i个神经元分配权重
                .bias(          Bias_ThisLayer          [(DataWidth * i)            +:  DataWidth           ]), // 为第i个神经元分配偏置
                .result(        Output_Data_ThisLayer   [(DataWidth * i)            +:  DataWidth           ])  // 第i个神经元输出
            );
        end
    endgenerate

endmodule