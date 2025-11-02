`timescale 1ns/1ps
module AdderTree(AdderTree_in, AdderTree_out);
    // 加法树模块，用于递归地将多个输入数据分层相加，最终输出一个结果
    // ChenVadder 20240218

    parameter INPUT_DATA_WIDTH = 8*2; // 输入数据宽度（每个数据的位宽）
    parameter NUM = 4;                // 输入数据个数
    
    localparam NUM_LEFT = NUM / 2;    // 左子树数据个数
    localparam NUM_RIGHT = NUM - NUM_LEFT; // 右子树数据个数

    input signed [INPUT_DATA_WIDTH*NUM-1:0] AdderTree_in; // 所有输入数据拼接成一个总线
    output signed [INPUT_DATA_WIDTH-1:0] AdderTree_out;   // 输出结果

    generate
        if (NUM == 1) begin
            // 递归终止条件：只有一个输入时，直接输出
            assign AdderTree_out = AdderTree_in;
        end else begin
            // 递归分解：将输入分为左右两部分，分别递归处理
            wire signed [INPUT_DATA_WIDTH-1:0] sum_left;   // 左子树结果
            wire signed [INPUT_DATA_WIDTH-1:0] sum_right;  // 右子树结果
            
            wire signed [INPUT_DATA_WIDTH*NUM_LEFT-1:0] l_child;  // 左子树输入
            wire signed [INPUT_DATA_WIDTH*NUM_RIGHT-1:0] r_child; // 右子树输入
            
            // 拆分输入数据为左右两部分
            assign l_child = AdderTree_in[INPUT_DATA_WIDTH*NUM_LEFT-1:0];
            assign r_child = AdderTree_in[INPUT_DATA_WIDTH*NUM-1:INPUT_DATA_WIDTH*NUM_LEFT];
            
            // 递归实例化左子树
            AdderTree #(
                .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
                .NUM(NUM_LEFT)
            ) subtree_a (
                .AdderTree_in(l_child),
                .AdderTree_out(sum_left)
            );
            
            // 递归实例化右子树
            AdderTree #(
                .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
                .NUM(NUM_RIGHT)
            ) subtree_b (
                .AdderTree_in(r_child),
                .AdderTree_out(sum_right)
            );
            // 用饱和加法器将左右子树结果相加，防止溢出
            SaturationAdder #(
                .n(INPUT_DATA_WIDTH)
            ) sat_adder (
                .in1(sum_left),
                .in2(sum_right),
                .SaturationAdder_result(AdderTree_out)
            );

            // 若不需要饱和加法，可直接用普通加法
            // assign AdderTree_out = sum_left + sum_right;
        end
    endgenerate

endmodule