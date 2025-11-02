`timescale 1ns/1ns
module test; //testbench模块
// 定义时钟
    parameter MAIN_TAP          = 28       ;  
    parameter PRE_TAP           = 28       ;
    parameter POST_TAP          = 28       ;
    parameter TOTAL_TAP         = 84      ;   // 总抽头数
    parameter INPUT_DATA_WIDTH  = 8        ;   // 输入数据数据位宽
    parameter N_HIDDEN          = 96       ;  
 
 reg clk;
 reg reset;
 reg [INPUT_DATA_WIDTH * MAIN_TAP                 -1:0]           input_data                    ;
 reg [INPUT_DATA_WIDTH * TOTAL_TAP * N_HIDDEN     -1:0]           weight_input_to_hidden        ;
 reg [INPUT_DATA_WIDTH * N_HIDDEN * MAIN_TAP      -1:0]           weight_hidden_to_output       ; 
 reg [INPUT_DATA_WIDTH * N_HIDDEN                 -1:0]           bias_hidden                   ;
 reg [INPUT_DATA_WIDTH * MAIN_TAP                 -1:0]           bias_output                   ;
 wire[INPUT_DATA_WIDTH * MAIN_TAP                 -1:0]           decision_layer_output         ;
 wire[2 * MAIN_TAP                                -1:0]           decision_layer_flag           ;
 wire[2 * MAIN_TAP                                -1:0]           output_result                 ;
 wire     [INPUT_DATA_WIDTH * MAIN_TAP            -1:0]           input_data_d1                 ;  // 前一时刻的数据
 wire     [INPUT_DATA_WIDTH * MAIN_TAP            -1:0]           input_data_d2                 ;   // 前前时刻的数据
 wire    [INPUT_DATA_WIDTH * TOTAL_TAP            -1:0]           input_data_all                ;        // 输入数据的全体
   //-------------------------------------------定义读文件的指针 ------------------------------------------------------------------
    integer fp_r_data_input;//读的指针
    integer flag_data_input;
    integer fp_r_weights1;//读的指针
    integer flag_weights1;
    integer fp_r_bias1;
    integer flag_bias1;
    integer fp_r_weights2;//读的指针
    integer flag_weights2;
    integer fp_r_bias2;
    integer flag_bias2;
  
    reg [15:0] cnt_data_input = 0;
    reg [15:0] cnt_weights1 = 0;
    reg [15:0] cnt_bias1 = 0;
    reg [15:0] cnt_weights2 = 0;
    reg [15:0] cnt_bias2 = 0;
    reg [15:0] clk_out = 0;

FP#(   MAIN_TAP,
       PRE_TAP,
       POST_TAP,
       TOTAL_TAP,
       INPUT_DATA_WIDTH,
        N_HIDDEN
        )
 uut(
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
.input_data_d1(input_data_d1),
.input_data_d2(input_data_d2),
.input_data_all(input_data_all)
);
initial clk=1;
always#10 clk=!clk;

initial 
begin
	fp_r_data_input=$fopen("H:/2024/verilog/ann/test/xb.txt","r");//读
	fp_r_weights1=$fopen("H:/2024/verilog/ann/test/w11.txt","r");//读
	fp_r_bias1=$fopen("H:/2024/verilog/ann/test/b1.txt","r");//读
	fp_r_weights2=$fopen("H:/2024/verilog/ann/test/w2.txt","r");//读
	fp_r_bias2=$fopen("H:/2024/verilog/ann/test/b2.txt","r");//读
end

initial 
begin
   	while(cnt_weights1<64512)
		begin
			flag_weights1 = $fscanf(fp_r_weights1,"%b",weight_input_to_hidden[INPUT_DATA_WIDTH*cnt_weights1 +:INPUT_DATA_WIDTH]);
			cnt_weights1 = cnt_weights1+1;
		end
	$fclose(fp_r_weights1);
		
   	while(cnt_bias1<768)
		begin
			flag_bias1 = $fscanf(fp_r_bias1,"%b",bias_hidden[INPUT_DATA_WIDTH*cnt_bias1 +:INPUT_DATA_WIDTH]);
			cnt_bias1 = cnt_bias1+1;
		end
	$fclose(fp_r_bias1);	
	
   	while(cnt_weights2<21504)
		begin
			flag_weights2 = $fscanf(fp_r_weights2,"%b",weight_hidden_to_output[INPUT_DATA_WIDTH*cnt_weights2 +:INPUT_DATA_WIDTH]);
			cnt_weights2 = cnt_weights2+1;
		end
	$fclose(fp_r_weights2);
		
   	while(cnt_bias2<224)
     	begin
			flag_bias2 = $fscanf(fp_r_bias2,"%b",bias_hidden[INPUT_DATA_WIDTH*cnt_bias2 +:INPUT_DATA_WIDTH]);
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

always @(posedge clk) begin
    if (clk_out==16'd19)begin
            clk_out<=0;
   end
     else begin
            clk_out<=clk_out+1;
               	while(cnt_data_input<224)
                 	begin
		            	flag_data_input = $fscanf(fp_r_data_input,"%b",input_data[INPUT_DATA_WIDTH*cnt_data_input +:INPUT_DATA_WIDTH]);//循环结束进入28个8位数据
			            cnt_data_input = cnt_data_input+1;
			        end
			        $fclose(fp_r_data_input);
			        cnt_data_input<=0;
			flag_data_input= $fscanf(fp_r_data_input,"%b",input_data[INPUT_DATA_WIDTH*MAIN_TAP*(clk_out-1)+:INPUT_DATA_WIDTH*MAIN_TAP]);
     end
     	$fclose(fp_r_data_input);
  end


initial 
begin
	#500
	$stop;
end

endmodule 