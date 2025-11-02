`timescale 1ns/1ps
module neurontb; //testbench模块

    parameter Input_Data_Width = 8;
    parameter Number_of_Inputs = 192;
    parameter ActType="relu"    ;
    reg           [Input_Data_Width * Number_of_Inputs        -1:0]       data_input    ;
    reg           [Input_Data_Width * Number_of_Inputs        -1:0]       weights       ;
    reg           [Input_Data_Width                           -1:0]       bias          ;
    wire          [Input_Data_Width                        -1:0]          result        ;
    
    integer fp_r_data_input;//读的指针
    integer flag_data_input;
    integer fp_r_weights;//读的指针
    integer flag_weights;
    integer fp_r_bias;
    integer flag_bias;
  
    reg [15:0] cnt_data_input = 0;
    reg [15:0] cnt_weights = 0;
    reg [15:0] cnt_bias = 0;

Neuron#( Input_Data_Width,
Number_of_Inputs,
ActType
        )
 uut(
.data_input(data_input),
.weights(weights),
.bias(bias),
.result(result)
);


initial 
begin
	fp_r_data_input=$fopen("H:/2024/verilog/ann/test/xb.txt","r");//读
	fp_r_weights=$fopen("H:/2024/verilog/ann/test/w11.txt","r");//读
	fp_r_bias=$fopen("H:/2024/verilog/ann/test/b1.txt","r");//读
	while(cnt_data_input<1536)
		begin
			flag_data_input= $fscanf(fp_r_data_input,"%b",data_input[Input_Data_Width*cnt_data_input +:Input_Data_Width]);
			cnt_data_input = cnt_data_input+1;
		end
	$fclose(fp_r_data_input);	
	
   	while(cnt_weights<1536)
		begin
			flag_weights = $fscanf(fp_r_weights,"%b",weights[Input_Data_Width*cnt_weights +:Input_Data_Width]);
			cnt_weights = cnt_weights+1;
		end
	$fclose(fp_r_weights);
		
   	while(cnt_bias<1)
		begin
			flag_bias = $fscanf(fp_r_bias,"%b",bias[Input_Data_Width*cnt_bias +:Input_Data_Width]);
			cnt_bias = cnt_bias+1;
		end
	$fclose(fp_r_bias);		

	//关闭读和写的文件
	#1000
	$stop;
end
endmodule 