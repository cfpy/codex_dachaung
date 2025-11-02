// // `timescale 1ns/1ns
// // module test; //testbench模块
// // // 定义时钟
// //     parameter MAIN_TAP          = 28       ;  
// //     parameter PRE_TAP           = 28       ;
// //     parameter POST_TAP          = 28       ;
// //     parameter TOTAL_TAP         = 84      ;   // 总抽头数
// //     parameter INPUT_DATA_WIDTH  = 8        ;   // 输入数据数据位宽
// //     parameter N_HIDDEN          = 96       ;  
 
// //  reg clk;
// //  reg reset;
// //  reg [INPUT_DATA_WIDTH * MAIN_TAP                 -1:0]           input_data                    ;
// //  reg [INPUT_DATA_WIDTH * TOTAL_TAP * N_HIDDEN     -1:0]           weight_input_to_hidden        ;
// //  reg [INPUT_DATA_WIDTH * N_HIDDEN * MAIN_TAP      -1:0]           weight_hidden_to_output       ; 
// //  reg [INPUT_DATA_WIDTH * N_HIDDEN                 -1:0]           bias_hidden                   ;
// //  reg [INPUT_DATA_WIDTH * MAIN_TAP                 -1:0]           bias_output                   ;
// //  wire[INPUT_DATA_WIDTH * MAIN_TAP                 -1:0]           decision_layer_output         ;
// //  wire[2 * MAIN_TAP                                -1:0]           decision_layer_flag           ;
// //  wire[2 * MAIN_TAP                                -1:0]           output_result                 ;
// //  wire     [INPUT_DATA_WIDTH * MAIN_TAP            -1:0]           input_data_d1                 ;  // 前一时刻的数据
// //  wire     [INPUT_DATA_WIDTH * MAIN_TAP            -1:0]           input_data_d2                 ;   // 前前时刻的数据
// //  wire    [INPUT_DATA_WIDTH * TOTAL_TAP            -1:0]           input_data_all                ;        // 输入数据的全体
// //    //-------------------------------------------定义读文件的指针 ------------------------------------------------------------------
// //     integer fp_r_data_input;//读的指针
// //     integer flag_data_input;
// //     integer fp_r_weights1;//读的指针
// //     integer flag_weights1;
// //     integer fp_r_bias1;
// //     integer flag_bias1;
// //     integer fp_r_weights2;//读的指针
// //     integer flag_weights2;
// //     integer fp_r_bias2;
// //     integer flag_bias2;
  
// //     reg [15:0] cnt_data_input = 0;
// //     reg [15:0] cnt_weights1 = 0;
// //     reg [15:0] cnt_bias1 = 0;
// //     reg [15:0] cnt_weights2 = 0;
// //     reg [15:0] cnt_bias2 = 0;
// //     reg [15:0] clk_out = 0;

// // FP#(   MAIN_TAP,
// //        PRE_TAP,
// //        POST_TAP,
// //        TOTAL_TAP,
// //        INPUT_DATA_WIDTH,
// //         N_HIDDEN
// //         )
// //  uut(
// // .clk(clk),
// // .reset(reset),
// // .input_data(input_data),
// // .weight_input_to_hidden(weight_input_to_hidden),
// // .weight_hidden_to_output(weight_hidden_to_output),
// // .bias_hidden(bias_hidden),
// // .bias_output(bias_output),
// // .decision_layer_output(decision_layer_output),
// // .decision_layer_flag(decision_layer_flag),
// // .output_result(output_result),
// // .input_data_d1(input_data_d1),
// // .input_data_d2(input_data_d2),
// // .input_data_all(input_data_all)
// // );
// // initial clk=1;
// // always#10 clk=!clk;

// // initial 
// // begin
// // 	fp_r_data_input=$fopen("H:/2024/verilog/ann/test/xb.txt","r");//读
// // 	fp_r_weights1=$fopen("H:/2024/verilog/ann/test/w11.txt","r");//读
// // 	fp_r_bias1=$fopen("H:/2024/verilog/ann/test/b1.txt","r");//读
// // 	fp_r_weights2=$fopen("H:/2024/verilog/ann/test/w2.txt","r");//读
// // 	fp_r_bias2=$fopen("H:/2024/verilog/ann/test/b2.txt","r");//读
// // end

// // initial 
// // begin
// //    	while(cnt_weights1<64512)
// // 		begin
// // 			flag_weights1 = $fscanf(fp_r_weights1,"%b",weight_input_to_hidden[INPUT_DATA_WIDTH*cnt_weights1 +:INPUT_DATA_WIDTH]);
// // 			cnt_weights1 = cnt_weights1+1;
// // 		end
// // 	$fclose(fp_r_weights1);
		
// //    	while(cnt_bias1<768)
// // 		begin
// // 			flag_bias1 = $fscanf(fp_r_bias1,"%b",bias_hidden[INPUT_DATA_WIDTH*cnt_bias1 +:INPUT_DATA_WIDTH]);
// // 			cnt_bias1 = cnt_bias1+1;
// // 		end
// // 	$fclose(fp_r_bias1);	
	
// //    	while(cnt_weights2<21504)
// // 		begin
// // 			flag_weights2 = $fscanf(fp_r_weights2,"%b",weight_hidden_to_output[INPUT_DATA_WIDTH*cnt_weights2 +:INPUT_DATA_WIDTH]);
// // 			cnt_weights2 = cnt_weights2+1;
// // 		end
// // 	$fclose(fp_r_weights2);
		
// //    	while(cnt_bias2<224)
// //      	begin
// // 			flag_bias2 = $fscanf(fp_r_bias2,"%b",bias_hidden[INPUT_DATA_WIDTH*cnt_bias2 +:INPUT_DATA_WIDTH]);
// // 			cnt_bias2 = cnt_bias2+1;
// // 			end
// // 	$fclose(fp_r_bias2);			
// // end

// // initial 
// // begin
// // 	reset=1;
// // 	#20
// // 	reset=0;
// // end

// // always @(posedge clk) begin
// //     if (clk_out==16'd19)begin
// //             clk_out<=0;
// //    end
// //      else begin
// //             clk_out<=clk_out+1;
// //                	while(cnt_data_input<224)
// //                  	begin
// // 		            	flag_data_input = $fscanf(fp_r_data_input,"%b",input_data[INPUT_DATA_WIDTH*cnt_data_input +:INPUT_DATA_WIDTH]);//循环结束进入28个8位数据
// // 			            cnt_data_input = cnt_data_input+1;
// // 			        end
// // 			        $fclose(fp_r_data_input);
// // 			        cnt_data_input<=0;
// // 			flag_data_input= $fscanf(fp_r_data_input,"%b",input_data[INPUT_DATA_WIDTH*MAIN_TAP*(clk_out-1)+:INPUT_DATA_WIDTH*MAIN_TAP]);
// //      end
// //      	$fclose(fp_r_data_input);
// //   end


// // initial 
// // begin
// // 	#500
// // 	$stop;
// // end

// // endmodule 

// `timescale 1ns/1ns
// module test; //testbench模块
// // 定义时钟
//     parameter MAIN_TAP          = 32;  
//     parameter PRE_TAP           = 16;
//     parameter POST_TAP          = 16;
//     parameter TOTAL_TAP         = 64;      // 总抽头数
//     parameter INPUT_DATA_WIDTH  = 8;       // 输入数据数据位宽
//     parameter N_HIDDEN          = 74;  
 
//     reg clk;
//     reg reset;
//     reg [INPUT_DATA_WIDTH * MAIN_TAP - 1:0] input_data;// 当前输入数据 224
//     reg [INPUT_DATA_WIDTH * TOTAL_TAP * N_HIDDEN - 1:0] weight_input_to_hidden;// 输入层到隐藏层权重 64512
//     reg [INPUT_DATA_WIDTH * N_HIDDEN * MAIN_TAP - 1:0] weight_hidden_to_output; // 隐藏层到输出层权重21504
//     reg [INPUT_DATA_WIDTH * N_HIDDEN - 1:0] bias_hidden;// 隐藏层偏置 768
//     reg [INPUT_DATA_WIDTH * MAIN_TAP - 1:0] bias_output;// 输出层偏置 224
//     wire [INPUT_DATA_WIDTH * MAIN_TAP - 1:0] decision_layer_output;// 输出层结果 224
//     wire [2 * MAIN_TAP - 1:0] decision_layer_flag;// 输出层标志位 56
//     wire [2 * MAIN_TAP - 1:0] output_result;// 最终输出结果 56
//     reg [INPUT_DATA_WIDTH * TOTAL_TAP - 1:0] input_data_all;// 全部输入数据 672
//     wire [INPUT_DATA_WIDTH * TOTAL_TAP - 1:0] input_data_all_w;// 输出全部输入数据 672
    
//     // 定义读取文件的指针
//     integer fp_r_data_input;
//     integer flag_data_input;
//     integer fp_r_weights1;
//     integer flag_weights1;
//     integer fp_r_bias1;
//     integer flag_bias1;
//     integer fp_r_weights2;
//     integer flag_weights2;
//     integer fp_r_bias2;
//     integer flag_bias2;
    
//     reg [15:0] clk_out = 0;
//     reg [15:0] cnt_data_input = 0;
//     reg [15:0] cnt_weights1 = 0;
//     reg [15:0] cnt_bias1 = 0;
//     reg [15:0] cnt_weights2 = 0;
//     reg [15:0] cnt_bias2 = 0;
//     reg [15:0] clk_count = 0;
//     reg data_read_complete = 0;

//     // 实例化FP模块 - 修正了端口连接
//     FP #(
//         .MAIN_TAP(MAIN_TAP),
//         .PRE_TAP(PRE_TAP),
//         .POST_TAP(POST_TAP),
//         .TOTAL_TAP(TOTAL_TAP),
//         .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
//         .N_HIDDEN(N_HIDDEN)
//     ) uut (
//         .clk(clk),
//         .reset(reset),
//         .input_data(input_data),
//         .weight_input_to_hidden(weight_input_to_hidden),
//         .weight_hidden_to_output(weight_hidden_to_output),
//         .bias_hidden(bias_hidden),
//         .bias_output(bias_output),
//         .decision_layer_output(decision_layer_output),
//         .decision_layer_flag(decision_layer_flag),
//         .output_result(output_result),
//         .input_data_all(input_data_all),
//         .input_data_all_w(input_data_all_w)
//     );

//     // 时钟生成
//     initial clk = 1;
//     always #10 clk = !clk;

//     initial 
//     begin
//         fp_r_data_input=$fopen("F:/verilog/test/x_valid_converted.txt","r");//读
//         fp_r_weights1=$fopen("F:/verilog/test/w1_converted.txt","r");//读
//         fp_r_bias1=$fopen("F:/verilog/test/b1_converted.txt","r");//读
//         fp_r_weights2=$fopen("F:/verilog/test/w2_converted.txt","r");//读
//         fp_r_bias2=$fopen("F:/verilog/test/b2_converted.txt","r");//读
//     end
    
//     initial 
//     begin
//         while(cnt_weights1<37888)
//             begin
//                 flag_weights1 = $fscanf(fp_r_weights1,"%b",weight_input_to_hidden[INPUT_DATA_WIDTH*cnt_weights1 +:INPUT_DATA_WIDTH]);
//                 cnt_weights1 = cnt_weights1+1;
//             end
//         $fclose(fp_r_weights1);
            
//         while(cnt_bias1<592)
//             begin
//                 flag_bias1 = $fscanf(fp_r_bias1,"%b",bias_hidden[INPUT_DATA_WIDTH*cnt_bias1 +:INPUT_DATA_WIDTH]);
//                 cnt_bias1 = cnt_bias1+1;
//             end
//         $fclose(fp_r_bias1);	
        
//         while(cnt_weights2<18944)
//             begin
//                 flag_weights2 = $fscanf(fp_r_weights2,"%b",weight_hidden_to_output[INPUT_DATA_WIDTH*cnt_weights2 +:INPUT_DATA_WIDTH]);
//                 cnt_weights2 = cnt_weights2+1;
//             end
//         $fclose(fp_r_weights2);
            
//         while(cnt_bias2<256)
//             begin
//                 flag_bias2 = $fscanf(fp_r_bias2,"%b",bias_output[INPUT_DATA_WIDTH*cnt_bias2 +:INPUT_DATA_WIDTH]);
//                 cnt_bias2 = cnt_bias2+1;
//                 end
//         $fclose(fp_r_bias2);			
//     end
    
//     initial 
//     begin
//         reset=1;
//         #20
//         reset=0;
//     end
    
//     always @(posedge clk) begin
//         if (clk_out==16'd19)begin
//                 clk_out<=0;
//        end
//          else begin
//                 clk_out<=clk_out+1;
//                     while(cnt_data_input<512)
//                         begin
//                             flag_data_input = $fscanf(fp_r_data_input,"%b",input_data_all[INPUT_DATA_WIDTH*cnt_data_input +:INPUT_DATA_WIDTH]);//
//                             cnt_data_input = cnt_data_input+1;
//                         end
//                         $fclose(fp_r_data_input);
//                         cnt_data_input<=0;
//                 flag_data_input= $fscanf(fp_r_data_input,"%b",input_data_all[INPUT_DATA_WIDTH*TOTAL_TAP*(clk_out-1)+:INPUT_DATA_WIDTH*TOTAL_TAP]);
//          end
//             $fclose(fp_r_data_input);
//       end

//     initial 
//     begin
//         #50000
//         $stop;
//     end
    
//     endmodule 
`timescale 1ns/1ns
module test; //testbench模块
// 定义时钟
    parameter MAIN_TAP          = 32;  
    parameter PRE_TAP           = 10;
    parameter POST_TAP          = 22;
    parameter TOTAL_TAP         = 64;      // 总抽头数
    parameter INPUT_DATA_WIDTH  = 8;       // 输入数据数据位宽
    parameter N_HIDDEN          = 74;  
 
    reg clk;
    reg reset;
    reg [INPUT_DATA_WIDTH * MAIN_TAP - 1:0] input_data;// 当前输入数据 224
    reg [INPUT_DATA_WIDTH * TOTAL_TAP * N_HIDDEN - 1:0] weight_input_to_hidden;// 输入层到隐藏层权重 64512
    reg [INPUT_DATA_WIDTH * N_HIDDEN * MAIN_TAP - 1:0] weight_hidden_to_output; // 隐藏层到输出层权重21504
    reg [INPUT_DATA_WIDTH * N_HIDDEN - 1:0] bias_hidden;// 隐藏层偏置 768
    reg [INPUT_DATA_WIDTH * MAIN_TAP - 1:0] bias_output;// 输出层偏置 224
    wire [INPUT_DATA_WIDTH * MAIN_TAP - 1:0] decision_layer_output;// 输出层结果 224
    wire [2 * MAIN_TAP - 1:0] decision_layer_flag;// 输出层标志位 56
    wire [2 * MAIN_TAP - 1:0] output_result;// 最终输出结果 56
    reg [INPUT_DATA_WIDTH * TOTAL_TAP - 1:0] input_data_all;// 全部输入数据 672
    wire [INPUT_DATA_WIDTH * TOTAL_TAP - 1:0] input_data_all_w;// 输出全部输入数据 672
//    reg [12799 * INPUT_DATA_WIDTH * TOTAL_TAP - 1:0] inputdata;
    
    // 定义读取文件的指针
    integer fp_r_data_input;
    integer flag_data_input;
    integer fp_r_weights1;
    integer flag_weights1;
    integer fp_r_bias1;
    integer flag_bias1;
    integer fp_r_weights2;
    integer flag_weights2;
    integer fp_r_bias2;
    integer flag_bias2;
    integer file_w;
    integer file_o=0;
    
    reg [15:0] clk_out = 0;
    reg [15:0] cnt_data_input = 0;
    reg [15:0] cnt_weights1 = 0;
    reg [15:0] cnt_bias1 = 0;
    reg [15:0] cnt_weights2 = 0;
    reg [15:0] cnt_bias2 = 0;
    reg [15:0] clk_count = 0;
    reg data_read_complete = 0;

    // 实例化FP模块 - 修正了端口连接
    FP #(
        .MAIN_TAP(MAIN_TAP),
        .PRE_TAP(PRE_TAP),
        .POST_TAP(POST_TAP),
        .TOTAL_TAP(TOTAL_TAP),
        .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
        .N_HIDDEN(N_HIDDEN)
    ) uut (
        .clk(clk),
        .reset(reset),
        .input_data(input_data),
        .weight_input_to_hidden(weight_input_to_hidden),
        .weight_hidden_to_output(weight_hidden_to_output),
        .bias_hidden(bias_hidden),
        .bias_output(bias_output),
        .decision_layer_output(decision_layer_output),
        .decision_layer_flag(decision_layer_flag),
        .output_result(output_result),
        .input_data_all(input_data_all),
        .input_data_all_w(input_data_all_w)
    );

    // 时钟生成
    initial clk = 1;
    always #10 clk = !clk;

    initial 
    begin
        fp_r_data_input=$fopen("F:/verilog/test/x_valid_converted.txt","r");//读
        fp_r_weights1=$fopen("F:/verilog/test/w1_converted.txt","r");//读
        fp_r_bias1=$fopen("F:/verilog/test/b1_converted.txt","r");//读
        fp_r_weights2=$fopen("F:/verilog/test/w2_converted.txt","r");//读
        fp_r_bias2=$fopen("F:/verilog/test/b2_converted.txt","r");//读
        file_w = $fopen("F:/verilog/test/result.txt", "w");
        if (file_w) begin file_o = 1;    end    
    end
    
    initial 
    begin
        while(cnt_weights1<4736)
            begin
                flag_weights1 = $fscanf(fp_r_weights1,"%b",weight_input_to_hidden[INPUT_DATA_WIDTH*cnt_weights1 +:INPUT_DATA_WIDTH]);
                cnt_weights1 = cnt_weights1+1;
            end
        $fclose(fp_r_weights1);
            
        while(cnt_bias1<74)
            begin
                flag_bias1 = $fscanf(fp_r_bias1,"%b",bias_hidden[INPUT_DATA_WIDTH*cnt_bias1 +:INPUT_DATA_WIDTH]);
                cnt_bias1 = cnt_bias1+1;
            end
        $fclose(fp_r_bias1);	
        
        while(cnt_weights2<2368)
            begin
                flag_weights2 = $fscanf(fp_r_weights2,"%b",weight_hidden_to_output[INPUT_DATA_WIDTH*cnt_weights2 +:INPUT_DATA_WIDTH]);
                cnt_weights2 = cnt_weights2+1;
            end
        $fclose(fp_r_weights2);
            
        while(cnt_bias2<32)
            begin
                flag_bias2 = $fscanf(fp_r_bias2,"%b",bias_output[INPUT_DATA_WIDTH*cnt_bias2 +:INPUT_DATA_WIDTH]);
                cnt_bias2 = cnt_bias2+1;
                end
        $fclose(fp_r_bias2);
        			
    end
    
    initial 
    begin
        reset=1;
        #20
        reset=0;
    end
    
//    always @(posedge clk) begin
//        if (clk_out==16'd12799)begin
//                clk_out<=0;
//       end
//         else begin
//                clk_out<=clk_out+1;
//                    while(cnt_data_input<64)
//                        begin
//                            flag_data_input = $fscanf(fp_r_data_input,"%b",input_data_all[INPUT_DATA_WIDTH*cnt_data_input +:INPUT_DATA_WIDTH]);//循环结束进入28个8位数据
//                            cnt_data_input = cnt_data_input+1;
//                        end
//                        $fclose(fp_r_data_input);
//                        cnt_data_input<=0;
//                flag_data_input = $fscanf(fp_r_data_input,"%b",input_data_all[INPUT_DATA_WIDTH*TOTAL_TAP*(clk_out-1)+:INPUT_DATA_WIDTH*TOTAL_TAP]);
//         end
//         $fclose(fp_r_data_input);
//      end

    always @(posedge clk) begin
        clk_out <= (clk_out == 16'd12799) ? 0 : clk_out + 1;
        
        if (clk_out != 16'd12799) begin
            // 读取512个数据
            for (integer i = 0; i < 64; i = i + 1) begin
                if ($fscanf(fp_r_data_input, "%b", 
                    input_data_all[INPUT_DATA_WIDTH*i +: INPUT_DATA_WIDTH]) != 1) begin
                    $fclose(fp_r_data_input);
                    $finish;
                end
            end
            // 处理读取的数据
//            flag_data_input = $fscanf(fp_r_data_input, "%b", 
//                input_data_all[INPUT_DATA_WIDTH*TOTAL_TAP*(clk_out-1)+:INPUT_DATA_WIDTH*TOTAL_TAP]);
        end
    end
    
    always @(posedge clk) begin
        if(file_o) begin
             $fwrite(file_w, "%064b\n", output_result);
        end 
    end
    
    initial 
    begin
        #100
        $fclose(fp_r_data_input);
        $fclose(file_w);
        $stop;
    end
    
    endmodule 
