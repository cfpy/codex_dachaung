`timescale 1ns/1ps
module read_write_tb;
// 定义时钟
reg clk;
reg rst;
initial clk = 1;
always #10 clk = ~clk; //时钟周期10ns

reg[4:0]add1;
wire[4:0]sum;
reg [4:0] temp [0:5]; // 于临时存储文件中的数据，假设也是6bit,假设有100个数据
reg [15:0] cnt = 0;

read_write u1(
.add1(add1),
.clk(clk),
.rst(rst),
.sum(sum)
);
// 初始化数据数组 temp
initial begin
$readmemh("F:/verilog/datain.txt", temp);//注意路径使用"/",使用"\"将无法正确读出
	rst=0;
	add1=5'h0;
	#20
	rst=1;
// 从文件 data.txt 读取数据到数组 temp

end
// 在每个时钟上升沿按顺序给 x 赋值
always @(posedge clk) begin
	if (cnt <= 5) begin
		add1 <= temp[cnt];
		cnt  <= cnt + 1;
	end
end
// 等待仿真结束
initial begin
#1000; // 等待足够的时间，以便观察仿真结果
$finish;
end
endmodule