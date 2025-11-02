//简单的累加模块
`timescale 1ns/1ps
module read_write(
input clk,//时钟
input rst,//复位
input [4:0]add1,//输入的加数

output reg [4:0]sum//输出的总和
);
initial sum=5'h0;
always@(posedge clk,negedge rst)
begin
	if(!rst)
		begin
			sum<=5'h0;	
		end
	else
		begin
			sum<=sum + add1;
		end
end
endmodule 