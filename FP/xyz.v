module xyz#(
    parameter MAIN_TAP          = 2         ,   // 主抽头数
    parameter PRE_TAP           = 1         ,
    parameter POST_TAP          = 1         ,
    parameter TOTAL_TAP         = 1 * 4     ,   // 总抽头数
    parameter INPUT_DATA_WIDTH  = 8            // 输入数据数据位宽
)
(
    input wire clk,
    input wire reset,
    input wire     [INPUT_DATA_WIDTH * MAIN_TAP                    -1:0]           input_data               ,
    output reg     [INPUT_DATA_WIDTH * MAIN_TAP                    -1:0]           input_data_d1            ,   // 前一时刻的数据
    output reg     [INPUT_DATA_WIDTH * MAIN_TAP                    -1:0]           input_data_d2            ,   // 前前时刻的数据
    output wire    [INPUT_DATA_WIDTH * TOTAL_TAP                   -1:0]           input_data_all               // 输入数据的全体
);

    //-------------------保存三个节拍的数据----------------------//
    always @(posedge clk or posedge reset) begin
        if (reset)  input_data_d1   <=  'b0                                 ;
        else        input_data_d1   <=  input_data                          ;   // 保存当前节拍的数据
    end

    always @(posedge clk or posedge reset) begin
        if(reset)   input_data_d2   <=  'b0                                 ;
        else        input_data_d2   <=  input_data_d1                       ;   // 保存上一节拍的数据
    end

    assign input_data_all    =   {
        input_data      [0      +: INPUT_DATA_WIDTH * POST_TAP]                         ,   // 此时   大端[8 * POST_TAP-1 : 0]
        input_data_d1                                                                   ,   // 前-->接收到下一拍（也就是此时的）数据后，才能开始处理这个节拍的数据 [8 * MAIN_TAP -1:0] 
        input_data_d2   [INPUT_DATA_WIDTH * MAIN_TAP-1 -: INPUT_DATA_WIDTH * PRE_TAP]       // 前前  大端[8 * PRE_TAP-1:0]
    };
 
    endmodule
