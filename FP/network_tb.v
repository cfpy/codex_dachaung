`timescale 1ns/1ps
module network_tb; //testbench模块

    parameter DataWidth         = 8;
    parameter N_HiddenLayer     = 1;               // 隐藏层的层数
    parameter N_InputNeurons    = 192;               // 全部的输入，包括Pre、MainTap、Post
    parameter N_HiddenNeurons   = 1;           // 隐藏层可以不止一层，但是限制了隐藏层的规模全部相同
    parameter N_OutputNeurons   = 1;                // 输出层，等于MainTap的个数

      // 输入层
    reg signed   [(DataWidth * N_InputNeurons)                           -1:0]   Input_Layer_Data;
    // 隐藏层
    reg signed   [(DataWidth * N_HiddenNeurons * N_InputNeurons)         -1:0]   Weights_Layer_1;
    reg signed   [(DataWidth * N_HiddenNeurons)                          -1:0]   Bias_Layer_1;
    // 输出层
    reg signed   [(DataWidth * N_OutputNeurons * N_HiddenNeurons)        -1:0]   Weights_Output_Layer;
    reg signed   [(DataWidth * N_OutputNeurons)                          -1:0]   Bias_Output_Layer;
    // 输出
     wire signed  [(DataWidth * N_OutputNeurons)                          -1:0]   Output_Data;
     
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

   //------------------------------------------模块例化 ------------------------------------------------------------------
Network#( DataWidth,
N_HiddenLayer,
N_InputNeurons,
N_HiddenNeurons,
N_OutputNeurons
        )
 uut(
.Input_Layer_Data(Input_Layer_Data),
.Weights_Layer_1(Weights_Layer_1),
.Bias_Layer_1(Bias_Layer_1),
.Weights_Output_Layer(Weights_Output_Layer),
.Bias_Output_Layer(Bias_Output_Layer),
.Output_Data(Output_Data)
);

//--------------------------------------------数据------------------------------------------------------------------
initial 
begin
	fp_r_data_input=$fopen("H:/2024/verilog/ann/test/xb.txt","r");//读
	fp_r_weights1=$fopen("H:/2024/verilog/ann/test/w11.txt","r");//读
	fp_r_bias1=$fopen("H:/2024/verilog/ann/test/b1.txt","r");//读
	fp_r_weights2=$fopen("H:/2024/verilog/ann/test/w2.txt","r");//读
	fp_r_bias2=$fopen("H:/2024/verilog/ann/test/b2.txt","r");//读
	
	while(cnt_data_input<1536)
		begin
			flag_data_input= $fscanf(fp_r_data_input,"%b",Input_Layer_Data[DataWidth*cnt_data_input +:DataWidth]);
			cnt_data_input = cnt_data_input+1;
		end
	$fclose(fp_r_data_input);	
	
   	while(cnt_weights1<1536)
		begin
			flag_weights1 = $fscanf(fp_r_weights1,"%b",Weights_Layer_1[DataWidth*cnt_weights1 +:DataWidth]);
			cnt_weights1 = cnt_weights1+1;
		end
	$fclose(fp_r_weights1);
		
   	while(cnt_bias1<1)
		begin
			flag_bias1 = $fscanf(fp_r_bias1,"%b",Bias_Layer_1[DataWidth*cnt_bias1 +:DataWidth]);
			cnt_bias1 = cnt_bias1+1;
		end
	$fclose(fp_r_bias1);	
	
   	while(cnt_weights2<1)
		begin
			flag_weights2 = $fscanf(fp_r_weights2,"%b",Weights_Output_Layer[DataWidth*cnt_weights2 +:DataWidth]);
			cnt_weights2 = cnt_weights2+1;
		end
	$fclose(fp_r_weights2);
		
   	while(cnt_bias2<1)
		begin
			flag_bias2 = $fscanf(fp_r_bias2,"%b",Bias_Output_Layer[DataWidth*cnt_bias2+:DataWidth]);
			cnt_bias2 = cnt_bias2+1;
		end
	$fclose(fp_r_bias2);			

	//关闭读和写的文件
	#1000
	$stop;
end
endmodule 