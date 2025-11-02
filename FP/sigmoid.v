module sigmoid(res_flag,sigmoid_in,sigmoid_out);

input           res_flag;
input  [15:0]   sigmoid_in;
output [15:0]   sigmoid_out;
reg    [15:0]   sigmoid_value;
wire    [9:0]    sigmoid_in_tmp;

assign sigmoid_out = sigmoid_value;
assign sigmoid_in_tmp = sigmoid_in[15:6];
	always @(*) begin
	   sigmoid_value = 15'b0;
		if(res_flag) begin
			case(sigmoid_in_tmp)
                // 请根据需求选择原码表示还是补码表示！！

                // 本部分为原码表示-Start
                // {
                //     1100000000: sigmoid_value = 0000000001001001;        // sigmoid_in = -4.0
                //     1011111111: sigmoid_value = 0000000001001010;        // sigmoid_in = -3.984375
                //     1011111110: sigmoid_value = 0000000001001011;        // sigmoid_in = -3.96875
                //     1011111101: sigmoid_value = 0000000001001101;        // sigmoid_in = -3.953125
                //     1011111100: sigmoid_value = 0000000001001110;        // sigmoid_in = -3.9375
                //     1011111011: sigmoid_value = 0000000001001111;        // sigmoid_in = -3.921875
                //     1011111010: sigmoid_value = 0000000001010000;        // sigmoid_in = -3.90625
                //     1011111001: sigmoid_value = 0000000001010010;        // sigmoid_in = -3.890625
                //     1011111000: sigmoid_value = 0000000001010011;        // sigmoid_in = -3.875
                //     1011110111: sigmoid_value = 0000000001010100;        // sigmoid_in = -3.859375
                //     1011110110: sigmoid_value = 0000000001010101;        // sigmoid_in = -3.84375
                //     1011110101: sigmoid_value = 0000000001010111;        // sigmoid_in = -3.828125
                //     1011110100: sigmoid_value = 0000000001011000;        // sigmoid_in = -3.8125
                //     1011110011: sigmoid_value = 0000000001011001;        // sigmoid_in = -3.796875
                //     1011110010: sigmoid_value = 0000000001011011;        // sigmoid_in = -3.78125
                //     1011110001: sigmoid_value = 0000000001011100;        // sigmoid_in = -3.765625
                //     1011110000: sigmoid_value = 0000000001011110;        // sigmoid_in = -3.75
                //     1011101111: sigmoid_value = 0000000001011111;        // sigmoid_in = -3.734375
                //     1011101110: sigmoid_value = 0000000001100001;        // sigmoid_in = -3.71875
                //     1011101101: sigmoid_value = 0000000001100010;        // sigmoid_in = -3.703125
                //     1011101100: sigmoid_value = 0000000001100100;        // sigmoid_in = -3.6875
                //     1011101011: sigmoid_value = 0000000001100101;        // sigmoid_in = -3.671875
                //     1011101010: sigmoid_value = 0000000001100111;        // sigmoid_in = -3.65625
                //     1011101001: sigmoid_value = 0000000001101000;        // sigmoid_in = -3.640625
                //     1011101000: sigmoid_value = 0000000001101010;        // sigmoid_in = -3.625
                //     1011100111: sigmoid_value = 0000000001101011;        // sigmoid_in = -3.609375
                //     1011100110: sigmoid_value = 0000000001101101;        // sigmoid_in = -3.59375
                //     1011100101: sigmoid_value = 0000000001101111;        // sigmoid_in = -3.578125
                //     1011100100: sigmoid_value = 0000000001110000;        // sigmoid_in = -3.5625
                //     1011100011: sigmoid_value = 0000000001110010;        // sigmoid_in = -3.546875
                //     1011100010: sigmoid_value = 0000000001110100;        // sigmoid_in = -3.53125
                //     1011100001: sigmoid_value = 0000000001110110;        // sigmoid_in = -3.515625
                //     1011100000: sigmoid_value = 0000000001111000;        // sigmoid_in = -3.5
                //     1011011111: sigmoid_value = 0000000001111001;        // sigmoid_in = -3.484375
                //     1011011110: sigmoid_value = 0000000001111011;        // sigmoid_in = -3.46875
                //     1011011101: sigmoid_value = 0000000001111101;        // sigmoid_in = -3.453125
                //     1011011100: sigmoid_value = 0000000001111111;        // sigmoid_in = -3.4375
                //     1011011011: sigmoid_value = 0000000010000001;        // sigmoid_in = -3.421875
                //     1011011010: sigmoid_value = 0000000010000011;        // sigmoid_in = -3.40625
                //     1011011001: sigmoid_value = 0000000010000101;        // sigmoid_in = -3.390625
                //     1011011000: sigmoid_value = 0000000010000111;        // sigmoid_in = -3.375
                //     1011010111: sigmoid_value = 0000000010001001;        // sigmoid_in = -3.359375
                //     1011010110: sigmoid_value = 0000000010001011;        // sigmoid_in = -3.34375
                //     1011010101: sigmoid_value = 0000000010001101;        // sigmoid_in = -3.328125
                //     1011010100: sigmoid_value = 0000000010001111;        // sigmoid_in = -3.3125
                //     1011010011: sigmoid_value = 0000000010010010;        // sigmoid_in = -3.296875
                //     1011010010: sigmoid_value = 0000000010010100;        // sigmoid_in = -3.28125
                //     1011010001: sigmoid_value = 0000000010010110;        // sigmoid_in = -3.265625
                //     1011010000: sigmoid_value = 0000000010011000;        // sigmoid_in = -3.25
                //     1011001111: sigmoid_value = 0000000010011011;        // sigmoid_in = -3.234375
                //     1011001110: sigmoid_value = 0000000010011101;        // sigmoid_in = -3.21875
                //     1011001101: sigmoid_value = 0000000010011111;        // sigmoid_in = -3.203125
                //     1011001100: sigmoid_value = 0000000010100010;        // sigmoid_in = -3.1875
                //     1011001011: sigmoid_value = 0000000010100100;        // sigmoid_in = -3.171875
                //     1011001010: sigmoid_value = 0000000010100111;        // sigmoid_in = -3.15625
                //     1011001001: sigmoid_value = 0000000010101001;        // sigmoid_in = -3.140625
                //     1011001000: sigmoid_value = 0000000010101100;        // sigmoid_in = -3.125
                //     1011000111: sigmoid_value = 0000000010101110;        // sigmoid_in = -3.109375
                //     1011000110: sigmoid_value = 0000000010110001;        // sigmoid_in = -3.09375
                //     1011000101: sigmoid_value = 0000000010110100;        // sigmoid_in = -3.078125
                //     1011000100: sigmoid_value = 0000000010110111;        // sigmoid_in = -3.0625
                //     1011000011: sigmoid_value = 0000000010111001;        // sigmoid_in = -3.046875
                //     1011000010: sigmoid_value = 0000000010111100;        // sigmoid_in = -3.03125
                //     1011000001: sigmoid_value = 0000000010111111;        // sigmoid_in = -3.015625
                //     1011000000: sigmoid_value = 0000000011000010;        // sigmoid_in = -3.0
                //     1010111111: sigmoid_value = 0000000011000101;        // sigmoid_in = -2.984375
                //     1010111110: sigmoid_value = 0000000011001000;        // sigmoid_in = -2.96875
                //     1010111101: sigmoid_value = 0000000011001011;        // sigmoid_in = -2.953125
                //     1010111100: sigmoid_value = 0000000011001110;        // sigmoid_in = -2.9375
                //     1010111011: sigmoid_value = 0000000011010001;        // sigmoid_in = -2.921875
                //     1010111010: sigmoid_value = 0000000011010100;        // sigmoid_in = -2.90625
                //     1010111001: sigmoid_value = 0000000011010111;        // sigmoid_in = -2.890625
                //     1010111000: sigmoid_value = 0000000011011010;        // sigmoid_in = -2.875
                //     1010110111: sigmoid_value = 0000000011011101;        // sigmoid_in = -2.859375
                //     1010110110: sigmoid_value = 0000000011100001;        // sigmoid_in = -2.84375
                //     1010110101: sigmoid_value = 0000000011100100;        // sigmoid_in = -2.828125
                //     1010110100: sigmoid_value = 0000000011101000;        // sigmoid_in = -2.8125
                //     1010110011: sigmoid_value = 0000000011101011;        // sigmoid_in = -2.796875
                //     1010110010: sigmoid_value = 0000000011101110;        // sigmoid_in = -2.78125
                //     1010110001: sigmoid_value = 0000000011110010;        // sigmoid_in = -2.765625
                //     1010110000: sigmoid_value = 0000000011110110;        // sigmoid_in = -2.75
                //     1010101111: sigmoid_value = 0000000011111001;        // sigmoid_in = -2.734375
                //     1010101110: sigmoid_value = 0000000011111101;        // sigmoid_in = -2.71875
                //     1010101101: sigmoid_value = 0000000100000001;        // sigmoid_in = -2.703125
                //     1010101100: sigmoid_value = 0000000100000100;        // sigmoid_in = -2.6875
                //     1010101011: sigmoid_value = 0000000100001000;        // sigmoid_in = -2.671875
                //     1010101010: sigmoid_value = 0000000100001100;        // sigmoid_in = -2.65625
                //     1010101001: sigmoid_value = 0000000100010000;        // sigmoid_in = -2.640625
                //     1010101000: sigmoid_value = 0000000100010100;        // sigmoid_in = -2.625
                //     1010100111: sigmoid_value = 0000000100011000;        // sigmoid_in = -2.609375
                //     1010100110: sigmoid_value = 0000000100011100;        // sigmoid_in = -2.59375
                //     1010100101: sigmoid_value = 0000000100100001;        // sigmoid_in = -2.578125
                //     1010100100: sigmoid_value = 0000000100100101;        // sigmoid_in = -2.5625
                //     1010100011: sigmoid_value = 0000000100101001;        // sigmoid_in = -2.546875
                //     1010100010: sigmoid_value = 0000000100101101;        // sigmoid_in = -2.53125
                //     1010100001: sigmoid_value = 0000000100110010;        // sigmoid_in = -2.515625
                //     1010100000: sigmoid_value = 0000000100110110;        // sigmoid_in = -2.5
                //     1010011111: sigmoid_value = 0000000100111011;        // sigmoid_in = -2.484375
                //     1010011110: sigmoid_value = 0000000100111111;        // sigmoid_in = -2.46875
                //     1010011101: sigmoid_value = 0000000101000100;        // sigmoid_in = -2.453125
                //     1010011100: sigmoid_value = 0000000101001001;        // sigmoid_in = -2.4375
                //     1010011011: sigmoid_value = 0000000101001101;        // sigmoid_in = -2.421875
                //     1010011010: sigmoid_value = 0000000101010010;        // sigmoid_in = -2.40625
                //     1010011001: sigmoid_value = 0000000101010111;        // sigmoid_in = -2.390625
                //     1010011000: sigmoid_value = 0000000101011100;        // sigmoid_in = -2.375
                //     1010010111: sigmoid_value = 0000000101100001;        // sigmoid_in = -2.359375
                //     1010010110: sigmoid_value = 0000000101100110;        // sigmoid_in = -2.34375
                //     1010010101: sigmoid_value = 0000000101101011;        // sigmoid_in = -2.328125
                //     1010010100: sigmoid_value = 0000000101110001;        // sigmoid_in = -2.3125
                //     1010010011: sigmoid_value = 0000000101110110;        // sigmoid_in = -2.296875
                //     1010010010: sigmoid_value = 0000000101111011;        // sigmoid_in = -2.28125
                //     1010010001: sigmoid_value = 0000000110000001;        // sigmoid_in = -2.265625
                //     1010010000: sigmoid_value = 0000000110000110;        // sigmoid_in = -2.25
                //     1010001111: sigmoid_value = 0000000110001100;        // sigmoid_in = -2.234375
                //     1010001110: sigmoid_value = 0000000110010001;        // sigmoid_in = -2.21875
                //     1010001101: sigmoid_value = 0000000110010111;        // sigmoid_in = -2.203125
                //     1010001100: sigmoid_value = 0000000110011101;        // sigmoid_in = -2.1875
                //     1010001011: sigmoid_value = 0000000110100011;        // sigmoid_in = -2.171875
                //     1010001010: sigmoid_value = 0000000110101000;        // sigmoid_in = -2.15625
                //     1010001001: sigmoid_value = 0000000110101110;        // sigmoid_in = -2.140625
                //     1010001000: sigmoid_value = 0000000110110101;        // sigmoid_in = -2.125
                //     1010000111: sigmoid_value = 0000000110111011;        // sigmoid_in = -2.109375
                //     1010000110: sigmoid_value = 0000000111000001;        // sigmoid_in = -2.09375
                //     1010000101: sigmoid_value = 0000000111000111;        // sigmoid_in = -2.078125
                //     1010000100: sigmoid_value = 0000000111001110;        // sigmoid_in = -2.0625
                //     1010000011: sigmoid_value = 0000000111010100;        // sigmoid_in = -2.046875
                //     1010000010: sigmoid_value = 0000000111011010;        // sigmoid_in = -2.03125
                //     1010000001: sigmoid_value = 0000000111100001;        // sigmoid_in = -2.015625
                //     1010000000: sigmoid_value = 0000000111101000;        // sigmoid_in = -2.0
                //     1001111111: sigmoid_value = 0000000111101111;        // sigmoid_in = -1.984375
                //     1001111110: sigmoid_value = 0000000111110101;        // sigmoid_in = -1.96875
                //     1001111101: sigmoid_value = 0000000111111100;        // sigmoid_in = -1.953125
                //     1001111100: sigmoid_value = 0000001000000011;        // sigmoid_in = -1.9375
                //     1001111011: sigmoid_value = 0000001000001010;        // sigmoid_in = -1.921875
                //     1001111010: sigmoid_value = 0000001000010010;        // sigmoid_in = -1.90625
                //     1001111001: sigmoid_value = 0000001000011001;        // sigmoid_in = -1.890625
                //     1001111000: sigmoid_value = 0000001000100000;        // sigmoid_in = -1.875
                //     1001110111: sigmoid_value = 0000001000101000;        // sigmoid_in = -1.859375
                //     1001110110: sigmoid_value = 0000001000101111;        // sigmoid_in = -1.84375
                //     1001110101: sigmoid_value = 0000001000110111;        // sigmoid_in = -1.828125
                //     1001110100: sigmoid_value = 0000001000111110;        // sigmoid_in = -1.8125
                //     1001110011: sigmoid_value = 0000001001000110;        // sigmoid_in = -1.796875
                //     1001110010: sigmoid_value = 0000001001001110;        // sigmoid_in = -1.78125
                //     1001110001: sigmoid_value = 0000001001010110;        // sigmoid_in = -1.765625
                //     1001110000: sigmoid_value = 0000001001011110;        // sigmoid_in = -1.75
                //     1001101111: sigmoid_value = 0000001001100110;        // sigmoid_in = -1.734375
                //     1001101110: sigmoid_value = 0000001001101110;        // sigmoid_in = -1.71875
                //     1001101101: sigmoid_value = 0000001001110111;        // sigmoid_in = -1.703125
                //     1001101100: sigmoid_value = 0000001001111111;        // sigmoid_in = -1.6875
                //     1001101011: sigmoid_value = 0000001010000111;        // sigmoid_in = -1.671875
                //     1001101010: sigmoid_value = 0000001010010000;        // sigmoid_in = -1.65625
                //     1001101001: sigmoid_value = 0000001010011001;        // sigmoid_in = -1.640625
                //     1001101000: sigmoid_value = 0000001010100001;        // sigmoid_in = -1.625
                //     1001100111: sigmoid_value = 0000001010101010;        // sigmoid_in = -1.609375
                //     1001100110: sigmoid_value = 0000001010110011;        // sigmoid_in = -1.59375
                //     1001100101: sigmoid_value = 0000001010111100;        // sigmoid_in = -1.578125
                //     1001100100: sigmoid_value = 0000001011000101;        // sigmoid_in = -1.5625
                //     1001100011: sigmoid_value = 0000001011001111;        // sigmoid_in = -1.546875
                //     1001100010: sigmoid_value = 0000001011011000;        // sigmoid_in = -1.53125
                //     1001100001: sigmoid_value = 0000001011100001;        // sigmoid_in = -1.515625
                //     1001100000: sigmoid_value = 0000001011101011;        // sigmoid_in = -1.5
                //     1001011111: sigmoid_value = 0000001011110100;        // sigmoid_in = -1.484375
                //     1001011110: sigmoid_value = 0000001011111110;        // sigmoid_in = -1.46875
                //     1001011101: sigmoid_value = 0000001100001000;        // sigmoid_in = -1.453125
                //     1001011100: sigmoid_value = 0000001100010010;        // sigmoid_in = -1.4375
                //     1001011011: sigmoid_value = 0000001100011100;        // sigmoid_in = -1.421875
                //     1001011010: sigmoid_value = 0000001100100110;        // sigmoid_in = -1.40625
                //     1001011001: sigmoid_value = 0000001100110000;        // sigmoid_in = -1.390625
                //     1001011000: sigmoid_value = 0000001100111010;        // sigmoid_in = -1.375
                //     1001010111: sigmoid_value = 0000001101000100;        // sigmoid_in = -1.359375
                //     1001010110: sigmoid_value = 0000001101001111;        // sigmoid_in = -1.34375
                //     1001010101: sigmoid_value = 0000001101011001;        // sigmoid_in = -1.328125
                //     1001010100: sigmoid_value = 0000001101100100;        // sigmoid_in = -1.3125
                //     1001010011: sigmoid_value = 0000001101101111;        // sigmoid_in = -1.296875
                //     1001010010: sigmoid_value = 0000001101111010;        // sigmoid_in = -1.28125
                //     1001010001: sigmoid_value = 0000001110000101;        // sigmoid_in = -1.265625
                //     1001010000: sigmoid_value = 0000001110010000;        // sigmoid_in = -1.25
                //     1001001111: sigmoid_value = 0000001110011011;        // sigmoid_in = -1.234375
                //     1001001110: sigmoid_value = 0000001110100110;        // sigmoid_in = -1.21875
                //     1001001101: sigmoid_value = 0000001110110001;        // sigmoid_in = -1.203125
                //     1001001100: sigmoid_value = 0000001110111101;        // sigmoid_in = -1.1875
                //     1001001011: sigmoid_value = 0000001111001000;        // sigmoid_in = -1.171875
                //     1001001010: sigmoid_value = 0000001111010100;        // sigmoid_in = -1.15625
                //     1001001001: sigmoid_value = 0000001111100000;        // sigmoid_in = -1.140625
                //     1001001000: sigmoid_value = 0000001111101011;        // sigmoid_in = -1.125
                //     1001000111: sigmoid_value = 0000001111110111;        // sigmoid_in = -1.109375
                //     1001000110: sigmoid_value = 0000010000000011;        // sigmoid_in = -1.09375
                //     1001000101: sigmoid_value = 0000010000001111;        // sigmoid_in = -1.078125
                //     1001000100: sigmoid_value = 0000010000011011;        // sigmoid_in = -1.0625
                //     1001000011: sigmoid_value = 0000010000101000;        // sigmoid_in = -1.046875
                //     1001000010: sigmoid_value = 0000010000110100;        // sigmoid_in = -1.03125
                //     1001000001: sigmoid_value = 0000010001000001;        // sigmoid_in = -1.015625
                //     1001000000: sigmoid_value = 0000010001001101;        // sigmoid_in = -1.0
                //     1000111111: sigmoid_value = 0000010001011010;        // sigmoid_in = -0.984375
                //     1000111110: sigmoid_value = 0000010001100110;        // sigmoid_in = -0.96875
                //     1000111101: sigmoid_value = 0000010001110011;        // sigmoid_in = -0.953125
                //     1000111100: sigmoid_value = 0000010010000000;        // sigmoid_in = -0.9375
                //     1000111011: sigmoid_value = 0000010010001101;        // sigmoid_in = -0.921875
                //     1000111010: sigmoid_value = 0000010010011010;        // sigmoid_in = -0.90625
                //     1000111001: sigmoid_value = 0000010010100111;        // sigmoid_in = -0.890625
                //     1000111000: sigmoid_value = 0000010010110101;        // sigmoid_in = -0.875
                //     1000110111: sigmoid_value = 0000010011000010;        // sigmoid_in = -0.859375
                //     1000110110: sigmoid_value = 0000010011001111;        // sigmoid_in = -0.84375
                //     1000110101: sigmoid_value = 0000010011011101;        // sigmoid_in = -0.828125
                //     1000110100: sigmoid_value = 0000010011101010;        // sigmoid_in = -0.8125
                //     1000110011: sigmoid_value = 0000010011111000;        // sigmoid_in = -0.796875
                //     1000110010: sigmoid_value = 0000010100000110;        // sigmoid_in = -0.78125
                //     1000110001: sigmoid_value = 0000010100010100;        // sigmoid_in = -0.765625
                //     1000110000: sigmoid_value = 0000010100100010;        // sigmoid_in = -0.75
                //     1000101111: sigmoid_value = 0000010100110000;        // sigmoid_in = -0.734375
                //     1000101110: sigmoid_value = 0000010100111110;        // sigmoid_in = -0.71875
                //     1000101101: sigmoid_value = 0000010101001100;        // sigmoid_in = -0.703125
                //     1000101100: sigmoid_value = 0000010101011010;        // sigmoid_in = -0.6875
                //     1000101011: sigmoid_value = 0000010101101000;        // sigmoid_in = -0.671875
                //     1000101010: sigmoid_value = 0000010101110111;        // sigmoid_in = -0.65625
                //     1000101001: sigmoid_value = 0000010110000101;        // sigmoid_in = -0.640625
                //     1000101000: sigmoid_value = 0000010110010100;        // sigmoid_in = -0.625
                //     1000100111: sigmoid_value = 0000010110100010;        // sigmoid_in = -0.609375
                //     1000100110: sigmoid_value = 0000010110110001;        // sigmoid_in = -0.59375
                //     1000100101: sigmoid_value = 0000010110111111;        // sigmoid_in = -0.578125
                //     1000100100: sigmoid_value = 0000010111001110;        // sigmoid_in = -0.5625
                //     1000100011: sigmoid_value = 0000010111011101;        // sigmoid_in = -0.546875
                //     1000100010: sigmoid_value = 0000010111101100;        // sigmoid_in = -0.53125
                //     1000100001: sigmoid_value = 0000010111111011;        // sigmoid_in = -0.515625
                //     1000100000: sigmoid_value = 0000011000001010;        // sigmoid_in = -0.5
                //     1000011111: sigmoid_value = 0000011000011001;        // sigmoid_in = -0.484375
                //     1000011110: sigmoid_value = 0000011000101000;        // sigmoid_in = -0.46875
                //     1000011101: sigmoid_value = 0000011000110111;        // sigmoid_in = -0.453125
                //     1000011100: sigmoid_value = 0000011001000111;        // sigmoid_in = -0.4375
                //     1000011011: sigmoid_value = 0000011001010110;        // sigmoid_in = -0.421875
                //     1000011010: sigmoid_value = 0000011001100101;        // sigmoid_in = -0.40625
                //     1000011001: sigmoid_value = 0000011001110101;        // sigmoid_in = -0.390625
                //     1000011000: sigmoid_value = 0000011010000100;        // sigmoid_in = -0.375
                //     1000010111: sigmoid_value = 0000011010010011;        // sigmoid_in = -0.359375
                //     1000010110: sigmoid_value = 0000011010100011;        // sigmoid_in = -0.34375
                //     1000010101: sigmoid_value = 0000011010110010;        // sigmoid_in = -0.328125
                //     1000010100: sigmoid_value = 0000011011000010;        // sigmoid_in = -0.3125
                //     1000010011: sigmoid_value = 0000011011010010;        // sigmoid_in = -0.296875
                //     1000010010: sigmoid_value = 0000011011100001;        // sigmoid_in = -0.28125
                //     1000010001: sigmoid_value = 0000011011110001;        // sigmoid_in = -0.265625
                //     1000010000: sigmoid_value = 0000011100000001;        // sigmoid_in = -0.25
                //     1000001111: sigmoid_value = 0000011100010001;        // sigmoid_in = -0.234375
                //     1000001110: sigmoid_value = 0000011100100000;        // sigmoid_in = -0.21875
                //     1000001101: sigmoid_value = 0000011100110000;        // sigmoid_in = -0.203125
                //     1000001100: sigmoid_value = 0000011101000000;        // sigmoid_in = -0.1875
                //     1000001011: sigmoid_value = 0000011101010000;        // sigmoid_in = -0.171875
                //     1000001010: sigmoid_value = 0000011101100000;        // sigmoid_in = -0.15625
                //     1000001001: sigmoid_value = 0000011101110000;        // sigmoid_in = -0.140625
                //     1000001000: sigmoid_value = 0000011110000000;        // sigmoid_in = -0.125
                //     1000000111: sigmoid_value = 0000011110010000;        // sigmoid_in = -0.109375
                //     1000000110: sigmoid_value = 0000011110100000;        // sigmoid_in = -0.09375
                //     1000000101: sigmoid_value = 0000011110110000;        // sigmoid_in = -0.078125
                //     1000000100: sigmoid_value = 0000011111000000;        // sigmoid_in = -0.0625
                //     1000000011: sigmoid_value = 0000011111010000;        // sigmoid_in = -0.046875
                //     1000000010: sigmoid_value = 0000011111100000;        // sigmoid_in = -0.03125
                //     1000000001: sigmoid_value = 0000011111110000;        // sigmoid_in = -0.015625
                //     0000000000: sigmoid_value = 0000100000000000;        // sigmoid_in = 0.0
                //     0000000001: sigmoid_value = 0000100000001111;        // sigmoid_in = 0.015625
                //     0000000010: sigmoid_value = 0000100000011111;        // sigmoid_in = 0.03125
                //     0000000011: sigmoid_value = 0000100000101111;        // sigmoid_in = 0.046875
                //     0000000100: sigmoid_value = 0000100000111111;        // sigmoid_in = 0.0625
                //     0000000101: sigmoid_value = 0000100001001111;        // sigmoid_in = 0.078125
                //     0000000110: sigmoid_value = 0000100001011111;        // sigmoid_in = 0.09375
                //     0000000111: sigmoid_value = 0000100001101111;        // sigmoid_in = 0.109375
                //     0000001000: sigmoid_value = 0000100001111111;        // sigmoid_in = 0.125
                //     0000001001: sigmoid_value = 0000100010001111;        // sigmoid_in = 0.140625
                //     0000001010: sigmoid_value = 0000100010011111;        // sigmoid_in = 0.15625
                //     0000001011: sigmoid_value = 0000100010101111;        // sigmoid_in = 0.171875
                //     0000001100: sigmoid_value = 0000100010111111;        // sigmoid_in = 0.1875
                //     0000001101: sigmoid_value = 0000100011001111;        // sigmoid_in = 0.203125
                //     0000001110: sigmoid_value = 0000100011011111;        // sigmoid_in = 0.21875
                //     0000001111: sigmoid_value = 0000100011101110;        // sigmoid_in = 0.234375
                //     0000010000: sigmoid_value = 0000100011111110;        // sigmoid_in = 0.25
                //     0000010001: sigmoid_value = 0000100100001110;        // sigmoid_in = 0.265625
                //     0000010010: sigmoid_value = 0000100100011110;        // sigmoid_in = 0.28125
                //     0000010011: sigmoid_value = 0000100100101101;        // sigmoid_in = 0.296875
                //     0000010100: sigmoid_value = 0000100100111101;        // sigmoid_in = 0.3125
                //     0000010101: sigmoid_value = 0000100101001101;        // sigmoid_in = 0.328125
                //     0000010110: sigmoid_value = 0000100101011100;        // sigmoid_in = 0.34375
                //     0000010111: sigmoid_value = 0000100101101100;        // sigmoid_in = 0.359375
                //     0000011000: sigmoid_value = 0000100101111011;        // sigmoid_in = 0.375
                //     0000011001: sigmoid_value = 0000100110001010;        // sigmoid_in = 0.390625
                //     0000011010: sigmoid_value = 0000100110011010;        // sigmoid_in = 0.40625
                //     0000011011: sigmoid_value = 0000100110101001;        // sigmoid_in = 0.421875
                //     0000011100: sigmoid_value = 0000100110111000;        // sigmoid_in = 0.4375
                //     0000011101: sigmoid_value = 0000100111001000;        // sigmoid_in = 0.453125
                //     0000011110: sigmoid_value = 0000100111010111;        // sigmoid_in = 0.46875
                //     0000011111: sigmoid_value = 0000100111100110;        // sigmoid_in = 0.484375
                //     0000100000: sigmoid_value = 0000100111110101;        // sigmoid_in = 0.5
                //     0000100001: sigmoid_value = 0000101000000100;        // sigmoid_in = 0.515625
                //     0000100010: sigmoid_value = 0000101000010011;        // sigmoid_in = 0.53125
                //     0000100011: sigmoid_value = 0000101000100010;        // sigmoid_in = 0.546875
                //     0000100100: sigmoid_value = 0000101000110001;        // sigmoid_in = 0.5625
                //     0000100101: sigmoid_value = 0000101001000000;        // sigmoid_in = 0.578125
                //     0000100110: sigmoid_value = 0000101001001110;        // sigmoid_in = 0.59375
                //     0000100111: sigmoid_value = 0000101001011101;        // sigmoid_in = 0.609375
                //     0000101000: sigmoid_value = 0000101001101011;        // sigmoid_in = 0.625
                //     0000101001: sigmoid_value = 0000101001111010;        // sigmoid_in = 0.640625
                //     0000101010: sigmoid_value = 0000101010001000;        // sigmoid_in = 0.65625
                //     0000101011: sigmoid_value = 0000101010010111;        // sigmoid_in = 0.671875
                //     0000101100: sigmoid_value = 0000101010100101;        // sigmoid_in = 0.6875
                //     0000101101: sigmoid_value = 0000101010110011;        // sigmoid_in = 0.703125
                //     0000101110: sigmoid_value = 0000101011000001;        // sigmoid_in = 0.71875
                //     0000101111: sigmoid_value = 0000101011001111;        // sigmoid_in = 0.734375
                //     0000110000: sigmoid_value = 0000101011011101;        // sigmoid_in = 0.75
                //     0000110001: sigmoid_value = 0000101011101011;        // sigmoid_in = 0.765625
                //     0000110010: sigmoid_value = 0000101011111001;        // sigmoid_in = 0.78125
                //     0000110011: sigmoid_value = 0000101100000111;        // sigmoid_in = 0.796875
                //     0000110100: sigmoid_value = 0000101100010101;        // sigmoid_in = 0.8125
                //     0000110101: sigmoid_value = 0000101100100010;        // sigmoid_in = 0.828125
                //     0000110110: sigmoid_value = 0000101100110000;        // sigmoid_in = 0.84375
                //     0000110111: sigmoid_value = 0000101100111101;        // sigmoid_in = 0.859375
                //     0000111000: sigmoid_value = 0000101101001010;        // sigmoid_in = 0.875
                //     0000111001: sigmoid_value = 0000101101011000;        // sigmoid_in = 0.890625
                //     0000111010: sigmoid_value = 0000101101100101;        // sigmoid_in = 0.90625
                //     0000111011: sigmoid_value = 0000101101110010;        // sigmoid_in = 0.921875
                //     0000111100: sigmoid_value = 0000101101111111;        // sigmoid_in = 0.9375
                //     0000111101: sigmoid_value = 0000101110001100;        // sigmoid_in = 0.953125
                //     0000111110: sigmoid_value = 0000101110011001;        // sigmoid_in = 0.96875
                //     0000111111: sigmoid_value = 0000101110100101;        // sigmoid_in = 0.984375
                //     0001000000: sigmoid_value = 0000101110110010;        // sigmoid_in = 1.0
                //     0001000001: sigmoid_value = 0000101110111110;        // sigmoid_in = 1.015625
                //     0001000010: sigmoid_value = 0000101111001011;        // sigmoid_in = 1.03125
                //     0001000011: sigmoid_value = 0000101111010111;        // sigmoid_in = 1.046875
                //     0001000100: sigmoid_value = 0000101111100100;        // sigmoid_in = 1.0625
                //     0001000101: sigmoid_value = 0000101111110000;        // sigmoid_in = 1.078125
                //     0001000110: sigmoid_value = 0000101111111100;        // sigmoid_in = 1.09375
                //     0001000111: sigmoid_value = 0000110000001000;        // sigmoid_in = 1.109375
                //     0001001000: sigmoid_value = 0000110000010100;        // sigmoid_in = 1.125
                //     0001001001: sigmoid_value = 0000110000011111;        // sigmoid_in = 1.140625
                //     0001001010: sigmoid_value = 0000110000101011;        // sigmoid_in = 1.15625
                //     0001001011: sigmoid_value = 0000110000110111;        // sigmoid_in = 1.171875
                //     0001001100: sigmoid_value = 0000110001000010;        // sigmoid_in = 1.1875
                //     0001001101: sigmoid_value = 0000110001001110;        // sigmoid_in = 1.203125
                //     0001001110: sigmoid_value = 0000110001011001;        // sigmoid_in = 1.21875
                //     0001001111: sigmoid_value = 0000110001100100;        // sigmoid_in = 1.234375
                //     0001010000: sigmoid_value = 0000110001101111;        // sigmoid_in = 1.25
                //     0001010001: sigmoid_value = 0000110001111010;        // sigmoid_in = 1.265625
                //     0001010010: sigmoid_value = 0000110010000101;        // sigmoid_in = 1.28125
                //     0001010011: sigmoid_value = 0000110010010000;        // sigmoid_in = 1.296875
                //     0001010100: sigmoid_value = 0000110010011011;        // sigmoid_in = 1.3125
                //     0001010101: sigmoid_value = 0000110010100110;        // sigmoid_in = 1.328125
                //     0001010110: sigmoid_value = 0000110010110000;        // sigmoid_in = 1.34375
                //     0001010111: sigmoid_value = 0000110010111011;        // sigmoid_in = 1.359375
                //     0001011000: sigmoid_value = 0000110011000101;        // sigmoid_in = 1.375
                //     0001011001: sigmoid_value = 0000110011001111;        // sigmoid_in = 1.390625
                //     0001011010: sigmoid_value = 0000110011011001;        // sigmoid_in = 1.40625
                //     0001011011: sigmoid_value = 0000110011100011;        // sigmoid_in = 1.421875
                //     0001011100: sigmoid_value = 0000110011101101;        // sigmoid_in = 1.4375
                //     0001011101: sigmoid_value = 0000110011110111;        // sigmoid_in = 1.453125
                //     0001011110: sigmoid_value = 0000110100000001;        // sigmoid_in = 1.46875
                //     0001011111: sigmoid_value = 0000110100001011;        // sigmoid_in = 1.484375
                //     0001100000: sigmoid_value = 0000110100010100;        // sigmoid_in = 1.5
                //     0001100001: sigmoid_value = 0000110100011110;        // sigmoid_in = 1.515625
                //     0001100010: sigmoid_value = 0000110100100111;        // sigmoid_in = 1.53125
                //     0001100011: sigmoid_value = 0000110100110000;        // sigmoid_in = 1.546875
                //     0001100100: sigmoid_value = 0000110100111010;        // sigmoid_in = 1.5625
                //     0001100101: sigmoid_value = 0000110101000011;        // sigmoid_in = 1.578125
                //     0001100110: sigmoid_value = 0000110101001100;        // sigmoid_in = 1.59375
                //     0001100111: sigmoid_value = 0000110101010101;        // sigmoid_in = 1.609375
                //     0001101000: sigmoid_value = 0000110101011110;        // sigmoid_in = 1.625
                //     0001101001: sigmoid_value = 0000110101100110;        // sigmoid_in = 1.640625
                //     0001101010: sigmoid_value = 0000110101101111;        // sigmoid_in = 1.65625
                //     0001101011: sigmoid_value = 0000110101111000;        // sigmoid_in = 1.671875
                //     0001101100: sigmoid_value = 0000110110000000;        // sigmoid_in = 1.6875
                //     0001101101: sigmoid_value = 0000110110001000;        // sigmoid_in = 1.703125
                //     0001101110: sigmoid_value = 0000110110010001;        // sigmoid_in = 1.71875
                //     0001101111: sigmoid_value = 0000110110011001;        // sigmoid_in = 1.734375
                //     0001110000: sigmoid_value = 0000110110100001;        // sigmoid_in = 1.75
                //     0001110001: sigmoid_value = 0000110110101001;        // sigmoid_in = 1.765625
                //     0001110010: sigmoid_value = 0000110110110001;        // sigmoid_in = 1.78125
                //     0001110011: sigmoid_value = 0000110110111001;        // sigmoid_in = 1.796875
                //     0001110100: sigmoid_value = 0000110111000001;        // sigmoid_in = 1.8125
                //     0001110101: sigmoid_value = 0000110111001000;        // sigmoid_in = 1.828125
                //     0001110110: sigmoid_value = 0000110111010000;        // sigmoid_in = 1.84375
                //     0001110111: sigmoid_value = 0000110111010111;        // sigmoid_in = 1.859375
                //     0001111000: sigmoid_value = 0000110111011111;        // sigmoid_in = 1.875
                //     0001111001: sigmoid_value = 0000110111100110;        // sigmoid_in = 1.890625
                //     0001111010: sigmoid_value = 0000110111101101;        // sigmoid_in = 1.90625
                //     0001111011: sigmoid_value = 0000110111110101;        // sigmoid_in = 1.921875
                //     0001111100: sigmoid_value = 0000110111111100;        // sigmoid_in = 1.9375
                //     0001111101: sigmoid_value = 0000111000000011;        // sigmoid_in = 1.953125
                //     0001111110: sigmoid_value = 0000111000001010;        // sigmoid_in = 1.96875
                //     0001111111: sigmoid_value = 0000111000010000;        // sigmoid_in = 1.984375
                //     0010000000: sigmoid_value = 0000111000010111;        // sigmoid_in = 2.0
                //     0010000001: sigmoid_value = 0000111000011110;        // sigmoid_in = 2.015625
                //     0010000010: sigmoid_value = 0000111000100101;        // sigmoid_in = 2.03125
                //     0010000011: sigmoid_value = 0000111000101011;        // sigmoid_in = 2.046875
                //     0010000100: sigmoid_value = 0000111000110001;        // sigmoid_in = 2.0625
                //     0010000101: sigmoid_value = 0000111000111000;        // sigmoid_in = 2.078125
                //     0010000110: sigmoid_value = 0000111000111110;        // sigmoid_in = 2.09375
                //     0010000111: sigmoid_value = 0000111001000100;        // sigmoid_in = 2.109375
                //     0010001000: sigmoid_value = 0000111001001010;        // sigmoid_in = 2.125
                //     0010001001: sigmoid_value = 0000111001010001;        // sigmoid_in = 2.140625
                //     0010001010: sigmoid_value = 0000111001010111;        // sigmoid_in = 2.15625
                //     0010001011: sigmoid_value = 0000111001011100;        // sigmoid_in = 2.171875
                //     0010001100: sigmoid_value = 0000111001100010;        // sigmoid_in = 2.1875
                //     0010001101: sigmoid_value = 0000111001101000;        // sigmoid_in = 2.203125
                //     0010001110: sigmoid_value = 0000111001101110;        // sigmoid_in = 2.21875
                //     0010001111: sigmoid_value = 0000111001110011;        // sigmoid_in = 2.234375
                //     0010010000: sigmoid_value = 0000111001111001;        // sigmoid_in = 2.25
                //     0010010001: sigmoid_value = 0000111001111110;        // sigmoid_in = 2.265625
                //     0010010010: sigmoid_value = 0000111010000100;        // sigmoid_in = 2.28125
                //     0010010011: sigmoid_value = 0000111010001001;        // sigmoid_in = 2.296875
                //     0010010100: sigmoid_value = 0000111010001110;        // sigmoid_in = 2.3125
                //     0010010101: sigmoid_value = 0000111010010100;        // sigmoid_in = 2.328125
                //     0010010110: sigmoid_value = 0000111010011001;        // sigmoid_in = 2.34375
                //     0010010111: sigmoid_value = 0000111010011110;        // sigmoid_in = 2.359375
                //     0010011000: sigmoid_value = 0000111010100011;        // sigmoid_in = 2.375
                //     0010011001: sigmoid_value = 0000111010101000;        // sigmoid_in = 2.390625
                //     0010011010: sigmoid_value = 0000111010101101;        // sigmoid_in = 2.40625
                //     0010011011: sigmoid_value = 0000111010110010;        // sigmoid_in = 2.421875
                //     0010011100: sigmoid_value = 0000111010110110;        // sigmoid_in = 2.4375
                //     0010011101: sigmoid_value = 0000111010111011;        // sigmoid_in = 2.453125
                //     0010011110: sigmoid_value = 0000111011000000;        // sigmoid_in = 2.46875
                //     0010011111: sigmoid_value = 0000111011000100;        // sigmoid_in = 2.484375
                //     0010100000: sigmoid_value = 0000111011001001;        // sigmoid_in = 2.5
                //     0010100001: sigmoid_value = 0000111011001101;        // sigmoid_in = 2.515625
                //     0010100010: sigmoid_value = 0000111011010010;        // sigmoid_in = 2.53125
                //     0010100011: sigmoid_value = 0000111011010110;        // sigmoid_in = 2.546875
                //     0010100100: sigmoid_value = 0000111011011010;        // sigmoid_in = 2.5625
                //     0010100101: sigmoid_value = 0000111011011110;        // sigmoid_in = 2.578125
                //     0010100110: sigmoid_value = 0000111011100011;        // sigmoid_in = 2.59375
                //     0010100111: sigmoid_value = 0000111011100111;        // sigmoid_in = 2.609375
                //     0010101000: sigmoid_value = 0000111011101011;        // sigmoid_in = 2.625
                //     0010101001: sigmoid_value = 0000111011101111;        // sigmoid_in = 2.640625
                //     0010101010: sigmoid_value = 0000111011110011;        // sigmoid_in = 2.65625
                //     0010101011: sigmoid_value = 0000111011110111;        // sigmoid_in = 2.671875
                //     0010101100: sigmoid_value = 0000111011111011;        // sigmoid_in = 2.6875
                //     0010101101: sigmoid_value = 0000111011111110;        // sigmoid_in = 2.703125
                //     0010101110: sigmoid_value = 0000111100000010;        // sigmoid_in = 2.71875
                //     0010101111: sigmoid_value = 0000111100000110;        // sigmoid_in = 2.734375
                //     0010110000: sigmoid_value = 0000111100001001;        // sigmoid_in = 2.75
                //     0010110001: sigmoid_value = 0000111100001101;        // sigmoid_in = 2.765625
                //     0010110010: sigmoid_value = 0000111100010001;        // sigmoid_in = 2.78125
                //     0010110011: sigmoid_value = 0000111100010100;        // sigmoid_in = 2.796875
                //     0010110100: sigmoid_value = 0000111100010111;        // sigmoid_in = 2.8125
                //     0010110101: sigmoid_value = 0000111100011011;        // sigmoid_in = 2.828125
                //     0010110110: sigmoid_value = 0000111100011110;        // sigmoid_in = 2.84375
                //     0010110111: sigmoid_value = 0000111100100010;        // sigmoid_in = 2.859375
                //     0010111000: sigmoid_value = 0000111100100101;        // sigmoid_in = 2.875
                //     0010111001: sigmoid_value = 0000111100101000;        // sigmoid_in = 2.890625
                //     0010111010: sigmoid_value = 0000111100101011;        // sigmoid_in = 2.90625
                //     0010111011: sigmoid_value = 0000111100101110;        // sigmoid_in = 2.921875
                //     0010111100: sigmoid_value = 0000111100110001;        // sigmoid_in = 2.9375
                //     0010111101: sigmoid_value = 0000111100110100;        // sigmoid_in = 2.953125
                //     0010111110: sigmoid_value = 0000111100110111;        // sigmoid_in = 2.96875
                //     0010111111: sigmoid_value = 0000111100111010;        // sigmoid_in = 2.984375
                //     0011000000: sigmoid_value = 0000111100111101;        // sigmoid_in = 3.0
                //     0011000001: sigmoid_value = 0000111101000000;        // sigmoid_in = 3.015625
                //     0011000010: sigmoid_value = 0000111101000011;        // sigmoid_in = 3.03125
                //     0011000011: sigmoid_value = 0000111101000110;        // sigmoid_in = 3.046875
                //     0011000100: sigmoid_value = 0000111101001000;        // sigmoid_in = 3.0625
                //     0011000101: sigmoid_value = 0000111101001011;        // sigmoid_in = 3.078125
                //     0011000110: sigmoid_value = 0000111101001110;        // sigmoid_in = 3.09375
                //     0011000111: sigmoid_value = 0000111101010001;        // sigmoid_in = 3.109375
                //     0011001000: sigmoid_value = 0000111101010011;        // sigmoid_in = 3.125
                //     0011001001: sigmoid_value = 0000111101010110;        // sigmoid_in = 3.140625
                //     0011001010: sigmoid_value = 0000111101011000;        // sigmoid_in = 3.15625
                //     0011001011: sigmoid_value = 0000111101011011;        // sigmoid_in = 3.171875
                //     0011001100: sigmoid_value = 0000111101011101;        // sigmoid_in = 3.1875
                //     0011001101: sigmoid_value = 0000111101100000;        // sigmoid_in = 3.203125
                //     0011001110: sigmoid_value = 0000111101100010;        // sigmoid_in = 3.21875
                //     0011001111: sigmoid_value = 0000111101100100;        // sigmoid_in = 3.234375
                //     0011010000: sigmoid_value = 0000111101100111;        // sigmoid_in = 3.25
                //     0011010001: sigmoid_value = 0000111101101001;        // sigmoid_in = 3.265625
                //     0011010010: sigmoid_value = 0000111101101011;        // sigmoid_in = 3.28125
                //     0011010011: sigmoid_value = 0000111101101101;        // sigmoid_in = 3.296875
                //     0011010100: sigmoid_value = 0000111101110000;        // sigmoid_in = 3.3125
                //     0011010101: sigmoid_value = 0000111101110010;        // sigmoid_in = 3.328125
                //     0011010110: sigmoid_value = 0000111101110100;        // sigmoid_in = 3.34375
                //     0011010111: sigmoid_value = 0000111101110110;        // sigmoid_in = 3.359375
                //     0011011000: sigmoid_value = 0000111101111000;        // sigmoid_in = 3.375
                //     0011011001: sigmoid_value = 0000111101111010;        // sigmoid_in = 3.390625
                //     0011011010: sigmoid_value = 0000111101111100;        // sigmoid_in = 3.40625
                //     0011011011: sigmoid_value = 0000111101111110;        // sigmoid_in = 3.421875
                //     0011011100: sigmoid_value = 0000111110000000;        // sigmoid_in = 3.4375
                //     0011011101: sigmoid_value = 0000111110000010;        // sigmoid_in = 3.453125
                //     0011011110: sigmoid_value = 0000111110000100;        // sigmoid_in = 3.46875
                //     0011011111: sigmoid_value = 0000111110000110;        // sigmoid_in = 3.484375
                //     0011100000: sigmoid_value = 0000111110000111;        // sigmoid_in = 3.5
                //     0011100001: sigmoid_value = 0000111110001001;        // sigmoid_in = 3.515625
                //     0011100010: sigmoid_value = 0000111110001011;        // sigmoid_in = 3.53125
                //     0011100011: sigmoid_value = 0000111110001101;        // sigmoid_in = 3.546875
                //     0011100100: sigmoid_value = 0000111110001111;        // sigmoid_in = 3.5625
                //     0011100101: sigmoid_value = 0000111110010000;        // sigmoid_in = 3.578125
                //     0011100110: sigmoid_value = 0000111110010010;        // sigmoid_in = 3.59375
                //     0011100111: sigmoid_value = 0000111110010100;        // sigmoid_in = 3.609375
                //     0011101000: sigmoid_value = 0000111110010101;        // sigmoid_in = 3.625
                //     0011101001: sigmoid_value = 0000111110010111;        // sigmoid_in = 3.640625
                //     0011101010: sigmoid_value = 0000111110011000;        // sigmoid_in = 3.65625
                //     0011101011: sigmoid_value = 0000111110011010;        // sigmoid_in = 3.671875
                //     0011101100: sigmoid_value = 0000111110011011;        // sigmoid_in = 3.6875
                //     0011101101: sigmoid_value = 0000111110011101;        // sigmoid_in = 3.703125
                //     0011101110: sigmoid_value = 0000111110011110;        // sigmoid_in = 3.71875
                //     0011101111: sigmoid_value = 0000111110100000;        // sigmoid_in = 3.734375
                //     0011110000: sigmoid_value = 0000111110100001;        // sigmoid_in = 3.75
                //     0011110001: sigmoid_value = 0000111110100011;        // sigmoid_in = 3.765625
                //     0011110010: sigmoid_value = 0000111110100100;        // sigmoid_in = 3.78125
                //     0011110011: sigmoid_value = 0000111110100110;        // sigmoid_in = 3.796875
                //     0011110100: sigmoid_value = 0000111110100111;        // sigmoid_in = 3.8125
                //     0011110101: sigmoid_value = 0000111110101000;        // sigmoid_in = 3.828125
                //     0011110110: sigmoid_value = 0000111110101010;        // sigmoid_in = 3.84375
                //     0011110111: sigmoid_value = 0000111110101011;        // sigmoid_in = 3.859375
                //     0011111000: sigmoid_value = 0000111110101100;        // sigmoid_in = 3.875
                //     0011111001: sigmoid_value = 0000111110101101;        // sigmoid_in = 3.890625
                //     0011111010: sigmoid_value = 0000111110101111;        // sigmoid_in = 3.90625
                //     0011111011: sigmoid_value = 0000111110110000;        // sigmoid_in = 3.921875
                //     0011111100: sigmoid_value = 0000111110110001;        // sigmoid_in = 3.9375
                //     0011111101: sigmoid_value = 0000111110110010;        // sigmoid_in = 3.953125
                //     0011111110: sigmoid_value = 0000111110110100;        // sigmoid_in = 3.96875
                //     0011111111: sigmoid_value = 0000111110110101;        // sigmoid_in = 3.984375
                //     0100000000: sigmoid_value = 0000111110110110;        // sigmoid_in = 4.0
                // }
                // 本部分为原码表示-End

                // 本部分为补码表示-Start
                
                    1100000000: sigmoid_value = 0000000001001001;        // sigmoid_in = -4.0
                    1100000001: sigmoid_value = 0000000001001010;        // sigmoid_in = -3.984375
                    1100000010: sigmoid_value = 0000000001001011;        // sigmoid_in = -3.96875
                    1100000011: sigmoid_value = 0000000001001101;        // sigmoid_in = -3.953125
                    1100000100: sigmoid_value = 0000000001001110;        // sigmoid_in = -3.9375
                    1100000101: sigmoid_value = 0000000001001111;        // sigmoid_in = -3.921875
                    1100000110: sigmoid_value = 0000000001010000;        // sigmoid_in = -3.90625
                    1100000111: sigmoid_value = 0000000001010010;        // sigmoid_in = -3.890625
                    1100001000: sigmoid_value = 0000000001010011;        // sigmoid_in = -3.875
                    1100001001: sigmoid_value = 0000000001010100;        // sigmoid_in = -3.859375
                    1100001010: sigmoid_value = 0000000001010101;        // sigmoid_in = -3.84375
                    1100001011: sigmoid_value = 0000000001010111;        // sigmoid_in = -3.828125
                    1100001100: sigmoid_value = 0000000001011000;        // sigmoid_in = -3.8125
                    1100001101: sigmoid_value = 0000000001011001;        // sigmoid_in = -3.796875
                    1100001110: sigmoid_value = 0000000001011011;        // sigmoid_in = -3.78125
                    1100001111: sigmoid_value = 0000000001011100;        // sigmoid_in = -3.765625
                    1100010000: sigmoid_value = 0000000001011110;        // sigmoid_in = -3.75
                    1100010001: sigmoid_value = 0000000001011111;        // sigmoid_in = -3.734375
                    1100010010: sigmoid_value = 0000000001100001;        // sigmoid_in = -3.71875
                    1100010011: sigmoid_value = 0000000001100010;        // sigmoid_in = -3.703125
                    1100010100: sigmoid_value = 0000000001100100;        // sigmoid_in = -3.6875
                    1100010101: sigmoid_value = 0000000001100101;        // sigmoid_in = -3.671875
                    1100010110: sigmoid_value = 0000000001100111;        // sigmoid_in = -3.65625
                    1100010111: sigmoid_value = 0000000001101000;        // sigmoid_in = -3.640625
                    1100011000: sigmoid_value = 0000000001101010;        // sigmoid_in = -3.625
                    1100011001: sigmoid_value = 0000000001101011;        // sigmoid_in = -3.609375
                    1100011010: sigmoid_value = 0000000001101101;        // sigmoid_in = -3.59375
                    1100011011: sigmoid_value = 0000000001101111;        // sigmoid_in = -3.578125
                    1100011100: sigmoid_value = 0000000001110000;        // sigmoid_in = -3.5625
                    1100011101: sigmoid_value = 0000000001110010;        // sigmoid_in = -3.546875
                    1100011110: sigmoid_value = 0000000001110100;        // sigmoid_in = -3.53125
                    1100011111: sigmoid_value = 0000000001110110;        // sigmoid_in = -3.515625
                    1100100000: sigmoid_value = 0000000001111000;        // sigmoid_in = -3.5
                    1100100001: sigmoid_value = 0000000001111001;        // sigmoid_in = -3.484375
                    1100100010: sigmoid_value = 0000000001111011;        // sigmoid_in = -3.46875
                    1100100011: sigmoid_value = 0000000001111101;        // sigmoid_in = -3.453125
                    1100100100: sigmoid_value = 0000000001111111;        // sigmoid_in = -3.4375
                    1100100101: sigmoid_value = 0000000010000001;        // sigmoid_in = -3.421875
                    1100100110: sigmoid_value = 0000000010000011;        // sigmoid_in = -3.40625
                    1100100111: sigmoid_value = 0000000010000101;        // sigmoid_in = -3.390625
                    1100101000: sigmoid_value = 0000000010000111;        // sigmoid_in = -3.375
                    1100101001: sigmoid_value = 0000000010001001;        // sigmoid_in = -3.359375
                    1100101010: sigmoid_value = 0000000010001011;        // sigmoid_in = -3.34375
                    1100101011: sigmoid_value = 0000000010001101;        // sigmoid_in = -3.328125
                    1100101100: sigmoid_value = 0000000010001111;        // sigmoid_in = -3.3125
                    1100101101: sigmoid_value = 0000000010010010;        // sigmoid_in = -3.296875
                    1100101110: sigmoid_value = 0000000010010100;        // sigmoid_in = -3.28125
                    1100101111: sigmoid_value = 0000000010010110;        // sigmoid_in = -3.265625
                    1100110000: sigmoid_value = 0000000010011000;        // sigmoid_in = -3.25
                    1100110001: sigmoid_value = 0000000010011011;        // sigmoid_in = -3.234375
                    1100110010: sigmoid_value = 0000000010011101;        // sigmoid_in = -3.21875
                    1100110011: sigmoid_value = 0000000010011111;        // sigmoid_in = -3.203125
                    1100110100: sigmoid_value = 0000000010100010;        // sigmoid_in = -3.1875
                    1100110101: sigmoid_value = 0000000010100100;        // sigmoid_in = -3.171875
                    1100110110: sigmoid_value = 0000000010100111;        // sigmoid_in = -3.15625
                    1100110111: sigmoid_value = 0000000010101001;        // sigmoid_in = -3.140625
                    1100111000: sigmoid_value = 0000000010101100;        // sigmoid_in = -3.125
                    1100111001: sigmoid_value = 0000000010101110;        // sigmoid_in = -3.109375
                    1100111010: sigmoid_value = 0000000010110001;        // sigmoid_in = -3.09375
                    1100111011: sigmoid_value = 0000000010110100;        // sigmoid_in = -3.078125
                    1100111100: sigmoid_value = 0000000010110111;        // sigmoid_in = -3.0625
                    1100111101: sigmoid_value = 0000000010111001;        // sigmoid_in = -3.046875
                    1100111110: sigmoid_value = 0000000010111100;        // sigmoid_in = -3.03125
                    1100111111: sigmoid_value = 0000000010111111;        // sigmoid_in = -3.015625
                    1101000000: sigmoid_value = 0000000011000010;        // sigmoid_in = -3.0
                    1101000001: sigmoid_value = 0000000011000101;        // sigmoid_in = -2.984375
                    1101000010: sigmoid_value = 0000000011001000;        // sigmoid_in = -2.96875
                    1101000011: sigmoid_value = 0000000011001011;        // sigmoid_in = -2.953125
                    1101000100: sigmoid_value = 0000000011001110;        // sigmoid_in = -2.9375
                    1101000101: sigmoid_value = 0000000011010001;        // sigmoid_in = -2.921875
                    1101000110: sigmoid_value = 0000000011010100;        // sigmoid_in = -2.90625
                    1101000111: sigmoid_value = 0000000011010111;        // sigmoid_in = -2.890625
                    1101001000: sigmoid_value = 0000000011011010;        // sigmoid_in = -2.875
                    1101001001: sigmoid_value = 0000000011011101;        // sigmoid_in = -2.859375
                    1101001010: sigmoid_value = 0000000011100001;        // sigmoid_in = -2.84375
                    1101001011: sigmoid_value = 0000000011100100;        // sigmoid_in = -2.828125
                    1101001100: sigmoid_value = 0000000011101000;        // sigmoid_in = -2.8125
                    1101001101: sigmoid_value = 0000000011101011;        // sigmoid_in = -2.796875
                    1101001110: sigmoid_value = 0000000011101110;        // sigmoid_in = -2.78125
                    1101001111: sigmoid_value = 0000000011110010;        // sigmoid_in = -2.765625
                    1101010000: sigmoid_value = 0000000011110110;        // sigmoid_in = -2.75
                    1101010001: sigmoid_value = 0000000011111001;        // sigmoid_in = -2.734375
                    1101010010: sigmoid_value = 0000000011111101;        // sigmoid_in = -2.71875
                    1101010011: sigmoid_value = 0000000100000001;        // sigmoid_in = -2.703125
                    1101010100: sigmoid_value = 0000000100000100;        // sigmoid_in = -2.6875
                    1101010101: sigmoid_value = 0000000100001000;        // sigmoid_in = -2.671875
                    1101010110: sigmoid_value = 0000000100001100;        // sigmoid_in = -2.65625
                    1101010111: sigmoid_value = 0000000100010000;        // sigmoid_in = -2.640625
                    1101011000: sigmoid_value = 0000000100010100;        // sigmoid_in = -2.625
                    1101011001: sigmoid_value = 0000000100011000;        // sigmoid_in = -2.609375
                    1101011010: sigmoid_value = 0000000100011100;        // sigmoid_in = -2.59375
                    1101011011: sigmoid_value = 0000000100100001;        // sigmoid_in = -2.578125
                    1101011100: sigmoid_value = 0000000100100101;        // sigmoid_in = -2.5625
                    1101011101: sigmoid_value = 0000000100101001;        // sigmoid_in = -2.546875
                    1101011110: sigmoid_value = 0000000100101101;        // sigmoid_in = -2.53125
                    1101011111: sigmoid_value = 0000000100110010;        // sigmoid_in = -2.515625
                    1101100000: sigmoid_value = 0000000100110110;        // sigmoid_in = -2.5
                    1101100001: sigmoid_value = 0000000100111011;        // sigmoid_in = -2.484375
                    1101100010: sigmoid_value = 0000000100111111;        // sigmoid_in = -2.46875
                    1101100011: sigmoid_value = 0000000101000100;        // sigmoid_in = -2.453125
                    1101100100: sigmoid_value = 0000000101001001;        // sigmoid_in = -2.4375
                    1101100101: sigmoid_value = 0000000101001101;        // sigmoid_in = -2.421875
                    1101100110: sigmoid_value = 0000000101010010;        // sigmoid_in = -2.40625
                    1101100111: sigmoid_value = 0000000101010111;        // sigmoid_in = -2.390625
                    1101101000: sigmoid_value = 0000000101011100;        // sigmoid_in = -2.375
                    1101101001: sigmoid_value = 0000000101100001;        // sigmoid_in = -2.359375
                    1101101010: sigmoid_value = 0000000101100110;        // sigmoid_in = -2.34375
                    1101101011: sigmoid_value = 0000000101101011;        // sigmoid_in = -2.328125
                    1101101100: sigmoid_value = 0000000101110001;        // sigmoid_in = -2.3125
                    1101101101: sigmoid_value = 0000000101110110;        // sigmoid_in = -2.296875
                    1101101110: sigmoid_value = 0000000101111011;        // sigmoid_in = -2.28125
                    1101101111: sigmoid_value = 0000000110000001;        // sigmoid_in = -2.265625
                    1101110000: sigmoid_value = 0000000110000110;        // sigmoid_in = -2.25
                    1101110001: sigmoid_value = 0000000110001100;        // sigmoid_in = -2.234375
                    1101110010: sigmoid_value = 0000000110010001;        // sigmoid_in = -2.21875
                    1101110011: sigmoid_value = 0000000110010111;        // sigmoid_in = -2.203125
                    1101110100: sigmoid_value = 0000000110011101;        // sigmoid_in = -2.1875
                    1101110101: sigmoid_value = 0000000110100011;        // sigmoid_in = -2.171875
                    1101110110: sigmoid_value = 0000000110101000;        // sigmoid_in = -2.15625
                    1101110111: sigmoid_value = 0000000110101110;        // sigmoid_in = -2.140625
                    1101111000: sigmoid_value = 0000000110110101;        // sigmoid_in = -2.125
                    1101111001: sigmoid_value = 0000000110111011;        // sigmoid_in = -2.109375
                    1101111010: sigmoid_value = 0000000111000001;        // sigmoid_in = -2.09375
                    1101111011: sigmoid_value = 0000000111000111;        // sigmoid_in = -2.078125
                    1101111100: sigmoid_value = 0000000111001110;        // sigmoid_in = -2.0625
                    1101111101: sigmoid_value = 0000000111010100;        // sigmoid_in = -2.046875
                    1101111110: sigmoid_value = 0000000111011010;        // sigmoid_in = -2.03125
                    1101111111: sigmoid_value = 0000000111100001;        // sigmoid_in = -2.015625
                    1110000000: sigmoid_value = 0000000111101000;        // sigmoid_in = -2.0
                    1110000001: sigmoid_value = 0000000111101111;        // sigmoid_in = -1.984375
                    1110000010: sigmoid_value = 0000000111110101;        // sigmoid_in = -1.96875
                    1110000011: sigmoid_value = 0000000111111100;        // sigmoid_in = -1.953125
                    1110000100: sigmoid_value = 0000001000000011;        // sigmoid_in = -1.9375
                    1110000101: sigmoid_value = 0000001000001010;        // sigmoid_in = -1.921875
                    1110000110: sigmoid_value = 0000001000010010;        // sigmoid_in = -1.90625
                    1110000111: sigmoid_value = 0000001000011001;        // sigmoid_in = -1.890625
                    1110001000: sigmoid_value = 0000001000100000;        // sigmoid_in = -1.875
                    1110001001: sigmoid_value = 0000001000101000;        // sigmoid_in = -1.859375
                    1110001010: sigmoid_value = 0000001000101111;        // sigmoid_in = -1.84375
                    1110001011: sigmoid_value = 0000001000110111;        // sigmoid_in = -1.828125
                    1110001100: sigmoid_value = 0000001000111110;        // sigmoid_in = -1.8125
                    1110001101: sigmoid_value = 0000001001000110;        // sigmoid_in = -1.796875
                    1110001110: sigmoid_value = 0000001001001110;        // sigmoid_in = -1.78125
                    1110001111: sigmoid_value = 0000001001010110;        // sigmoid_in = -1.765625
                    1110010000: sigmoid_value = 0000001001011110;        // sigmoid_in = -1.75
                    1110010001: sigmoid_value = 0000001001100110;        // sigmoid_in = -1.734375
                    1110010010: sigmoid_value = 0000001001101110;        // sigmoid_in = -1.71875
                    1110010011: sigmoid_value = 0000001001110111;        // sigmoid_in = -1.703125
                    1110010100: sigmoid_value = 0000001001111111;        // sigmoid_in = -1.6875
                    1110010101: sigmoid_value = 0000001010000111;        // sigmoid_in = -1.671875
                    1110010110: sigmoid_value = 0000001010010000;        // sigmoid_in = -1.65625
                    1110010111: sigmoid_value = 0000001010011001;        // sigmoid_in = -1.640625
                    1110011000: sigmoid_value = 0000001010100001;        // sigmoid_in = -1.625
                    1110011001: sigmoid_value = 0000001010101010;        // sigmoid_in = -1.609375
                    1110011010: sigmoid_value = 0000001010110011;        // sigmoid_in = -1.59375
                    1110011011: sigmoid_value = 0000001010111100;        // sigmoid_in = -1.578125
                    1110011100: sigmoid_value = 0000001011000101;        // sigmoid_in = -1.5625
                    1110011101: sigmoid_value = 0000001011001111;        // sigmoid_in = -1.546875
                    1110011110: sigmoid_value = 0000001011011000;        // sigmoid_in = -1.53125
                    1110011111: sigmoid_value = 0000001011100001;        // sigmoid_in = -1.515625
                    1110100000: sigmoid_value = 0000001011101011;        // sigmoid_in = -1.5
                    1110100001: sigmoid_value = 0000001011110100;        // sigmoid_in = -1.484375
                    1110100010: sigmoid_value = 0000001011111110;        // sigmoid_in = -1.46875
                    1110100011: sigmoid_value = 0000001100001000;        // sigmoid_in = -1.453125
                    1110100100: sigmoid_value = 0000001100010010;        // sigmoid_in = -1.4375
                    1110100101: sigmoid_value = 0000001100011100;        // sigmoid_in = -1.421875
                    1110100110: sigmoid_value = 0000001100100110;        // sigmoid_in = -1.40625
                    1110100111: sigmoid_value = 0000001100110000;        // sigmoid_in = -1.390625
                    1110101000: sigmoid_value = 0000001100111010;        // sigmoid_in = -1.375
                    1110101001: sigmoid_value = 0000001101000100;        // sigmoid_in = -1.359375
                    1110101010: sigmoid_value = 0000001101001111;        // sigmoid_in = -1.34375
                    1110101011: sigmoid_value = 0000001101011001;        // sigmoid_in = -1.328125
                    1110101100: sigmoid_value = 0000001101100100;        // sigmoid_in = -1.3125
                    1110101101: sigmoid_value = 0000001101101111;        // sigmoid_in = -1.296875
                    1110101110: sigmoid_value = 0000001101111010;        // sigmoid_in = -1.28125
                    1110101111: sigmoid_value = 0000001110000101;        // sigmoid_in = -1.265625
                    1110110000: sigmoid_value = 0000001110010000;        // sigmoid_in = -1.25
                    1110110001: sigmoid_value = 0000001110011011;        // sigmoid_in = -1.234375
                    1110110010: sigmoid_value = 0000001110100110;        // sigmoid_in = -1.21875
                    1110110011: sigmoid_value = 0000001110110001;        // sigmoid_in = -1.203125
                    1110110100: sigmoid_value = 0000001110111101;        // sigmoid_in = -1.1875
                    1110110101: sigmoid_value = 0000001111001000;        // sigmoid_in = -1.171875
                    1110110110: sigmoid_value = 0000001111010100;        // sigmoid_in = -1.15625
                    1110110111: sigmoid_value = 0000001111100000;        // sigmoid_in = -1.140625
                    1110111000: sigmoid_value = 0000001111101011;        // sigmoid_in = -1.125
                    1110111001: sigmoid_value = 0000001111110111;        // sigmoid_in = -1.109375
                    1110111010: sigmoid_value = 0000010000000011;        // sigmoid_in = -1.09375
                    1110111011: sigmoid_value = 0000010000001111;        // sigmoid_in = -1.078125
                    1110111100: sigmoid_value = 0000010000011011;        // sigmoid_in = -1.0625
                    1110111101: sigmoid_value = 0000010000101000;        // sigmoid_in = -1.046875
                    1110111110: sigmoid_value = 0000010000110100;        // sigmoid_in = -1.03125
                    1110111111: sigmoid_value = 0000010001000001;        // sigmoid_in = -1.015625
                    1111000000: sigmoid_value = 0000010001001101;        // sigmoid_in = -1.0
                    1111000001: sigmoid_value = 0000010001011010;        // sigmoid_in = -0.984375
                    1111000010: sigmoid_value = 0000010001100110;        // sigmoid_in = -0.96875
                    1111000011: sigmoid_value = 0000010001110011;        // sigmoid_in = -0.953125
                    1111000100: sigmoid_value = 0000010010000000;        // sigmoid_in = -0.9375
                    1111000101: sigmoid_value = 0000010010001101;        // sigmoid_in = -0.921875
                    1111000110: sigmoid_value = 0000010010011010;        // sigmoid_in = -0.90625
                    1111000111: sigmoid_value = 0000010010100111;        // sigmoid_in = -0.890625
                    1111001000: sigmoid_value = 0000010010110101;        // sigmoid_in = -0.875
                    1111001001: sigmoid_value = 0000010011000010;        // sigmoid_in = -0.859375
                    1111001010: sigmoid_value = 0000010011001111;        // sigmoid_in = -0.84375
                    1111001011: sigmoid_value = 0000010011011101;        // sigmoid_in = -0.828125
                    1111001100: sigmoid_value = 0000010011101010;        // sigmoid_in = -0.8125
                    1111001101: sigmoid_value = 0000010011111000;        // sigmoid_in = -0.796875
                    1111001110: sigmoid_value = 0000010100000110;        // sigmoid_in = -0.78125
                    1111001111: sigmoid_value = 0000010100010100;        // sigmoid_in = -0.765625
                    1111010000: sigmoid_value = 0000010100100010;        // sigmoid_in = -0.75
                    1111010001: sigmoid_value = 0000010100110000;        // sigmoid_in = -0.734375
                    1111010010: sigmoid_value = 0000010100111110;        // sigmoid_in = -0.71875
                    1111010011: sigmoid_value = 0000010101001100;        // sigmoid_in = -0.703125
                    1111010100: sigmoid_value = 0000010101011010;        // sigmoid_in = -0.6875
                    1111010101: sigmoid_value = 0000010101101000;        // sigmoid_in = -0.671875
                    1111010110: sigmoid_value = 0000010101110111;        // sigmoid_in = -0.65625
                    1111010111: sigmoid_value = 0000010110000101;        // sigmoid_in = -0.640625
                    1111011000: sigmoid_value = 0000010110010100;        // sigmoid_in = -0.625
                    1111011001: sigmoid_value = 0000010110100010;        // sigmoid_in = -0.609375
                    1111011010: sigmoid_value = 0000010110110001;        // sigmoid_in = -0.59375
                    1111011011: sigmoid_value = 0000010110111111;        // sigmoid_in = -0.578125
                    1111011100: sigmoid_value = 0000010111001110;        // sigmoid_in = -0.5625
                    1111011101: sigmoid_value = 0000010111011101;        // sigmoid_in = -0.546875
                    1111011110: sigmoid_value = 0000010111101100;        // sigmoid_in = -0.53125
                    1111011111: sigmoid_value = 0000010111111011;        // sigmoid_in = -0.515625
                    1111100000: sigmoid_value = 0000011000001010;        // sigmoid_in = -0.5
                    1111100001: sigmoid_value = 0000011000011001;        // sigmoid_in = -0.484375
                    1111100010: sigmoid_value = 0000011000101000;        // sigmoid_in = -0.46875
                    1111100011: sigmoid_value = 0000011000110111;        // sigmoid_in = -0.453125
                    1111100100: sigmoid_value = 0000011001000111;        // sigmoid_in = -0.4375
                    1111100101: sigmoid_value = 0000011001010110;        // sigmoid_in = -0.421875
                    1111100110: sigmoid_value = 0000011001100101;        // sigmoid_in = -0.40625
                    1111100111: sigmoid_value = 0000011001110101;        // sigmoid_in = -0.390625
                    1111101000: sigmoid_value = 0000011010000100;        // sigmoid_in = -0.375
                    1111101001: sigmoid_value = 0000011010010011;        // sigmoid_in = -0.359375
                    1111101010: sigmoid_value = 0000011010100011;        // sigmoid_in = -0.34375
                    1111101011: sigmoid_value = 0000011010110010;        // sigmoid_in = -0.328125
                    1111101100: sigmoid_value = 0000011011000010;        // sigmoid_in = -0.3125
                    1111101101: sigmoid_value = 0000011011010010;        // sigmoid_in = -0.296875
                    1111101110: sigmoid_value = 0000011011100001;        // sigmoid_in = -0.28125
                    1111101111: sigmoid_value = 0000011011110001;        // sigmoid_in = -0.265625
                    1111110000: sigmoid_value = 0000011100000001;        // sigmoid_in = -0.25
                    1111110001: sigmoid_value = 0000011100010001;        // sigmoid_in = -0.234375
                    1111110010: sigmoid_value = 0000011100100000;        // sigmoid_in = -0.21875
                    1111110011: sigmoid_value = 0000011100110000;        // sigmoid_in = -0.203125
                    1111110100: sigmoid_value = 0000011101000000;        // sigmoid_in = -0.1875
                    1111110101: sigmoid_value = 0000011101010000;        // sigmoid_in = -0.171875
                    1111110110: sigmoid_value = 0000011101100000;        // sigmoid_in = -0.15625
                    1111110111: sigmoid_value = 0000011101110000;        // sigmoid_in = -0.140625
                    1111111000: sigmoid_value = 0000011110000000;        // sigmoid_in = -0.125
                    1111111001: sigmoid_value = 0000011110010000;        // sigmoid_in = -0.109375
                    1111111010: sigmoid_value = 0000011110100000;        // sigmoid_in = -0.09375
                    1111111011: sigmoid_value = 0000011110110000;        // sigmoid_in = -0.078125
                    1111111100: sigmoid_value = 0000011111000000;        // sigmoid_in = -0.0625
                    1111111101: sigmoid_value = 0000011111010000;        // sigmoid_in = -0.046875
                    1111111110: sigmoid_value = 0000011111100000;        // sigmoid_in = -0.03125
                    1111111111: sigmoid_value = 0000011111110000;        // sigmoid_in = -0.015625
                    0000000000: sigmoid_value = 0000100000000000;        // sigmoid_in = 0.0
                    0000000001: sigmoid_value = 0000100000001111;        // sigmoid_in = 0.015625
                    0000000010: sigmoid_value = 0000100000011111;        // sigmoid_in = 0.03125
                    0000000011: sigmoid_value = 0000100000101111;        // sigmoid_in = 0.046875
                    0000000100: sigmoid_value = 0000100000111111;        // sigmoid_in = 0.0625
                    0000000101: sigmoid_value = 0000100001001111;        // sigmoid_in = 0.078125
                    0000000110: sigmoid_value = 0000100001011111;        // sigmoid_in = 0.09375
                    0000000111: sigmoid_value = 0000100001101111;        // sigmoid_in = 0.109375
                    0000001000: sigmoid_value = 0000100001111111;        // sigmoid_in = 0.125
                    0000001001: sigmoid_value = 0000100010001111;        // sigmoid_in = 0.140625
                    0000001010: sigmoid_value = 0000100010011111;        // sigmoid_in = 0.15625
                    0000001011: sigmoid_value = 0000100010101111;        // sigmoid_in = 0.171875
                    0000001100: sigmoid_value = 0000100010111111;        // sigmoid_in = 0.1875
                    0000001101: sigmoid_value = 0000100011001111;        // sigmoid_in = 0.203125
                    0000001110: sigmoid_value = 0000100011011111;        // sigmoid_in = 0.21875
                    0000001111: sigmoid_value = 0000100011101110;        // sigmoid_in = 0.234375
                    0000010000: sigmoid_value = 0000100011111110;        // sigmoid_in = 0.25
                    0000010001: sigmoid_value = 0000100100001110;        // sigmoid_in = 0.265625
                    0000010010: sigmoid_value = 0000100100011110;        // sigmoid_in = 0.28125
                    0000010011: sigmoid_value = 0000100100101101;        // sigmoid_in = 0.296875
                    0000010100: sigmoid_value = 0000100100111101;        // sigmoid_in = 0.3125
                    0000010101: sigmoid_value = 0000100101001101;        // sigmoid_in = 0.328125
                    0000010110: sigmoid_value = 0000100101011100;        // sigmoid_in = 0.34375
                    0000010111: sigmoid_value = 0000100101101100;        // sigmoid_in = 0.359375
                    0000011000: sigmoid_value = 0000100101111011;        // sigmoid_in = 0.375
                    0000011001: sigmoid_value = 0000100110001010;        // sigmoid_in = 0.390625
                    0000011010: sigmoid_value = 0000100110011010;        // sigmoid_in = 0.40625
                    0000011011: sigmoid_value = 0000100110101001;        // sigmoid_in = 0.421875
                    0000011100: sigmoid_value = 0000100110111000;        // sigmoid_in = 0.4375
                    0000011101: sigmoid_value = 0000100111001000;        // sigmoid_in = 0.453125
                    0000011110: sigmoid_value = 0000100111010111;        // sigmoid_in = 0.46875
                    0000011111: sigmoid_value = 0000100111100110;        // sigmoid_in = 0.484375
                    0000100000: sigmoid_value = 0000100111110101;        // sigmoid_in = 0.5
                    0000100001: sigmoid_value = 0000101000000100;        // sigmoid_in = 0.515625
                    0000100010: sigmoid_value = 0000101000010011;        // sigmoid_in = 0.53125
                    0000100011: sigmoid_value = 0000101000100010;        // sigmoid_in = 0.546875
                    0000100100: sigmoid_value = 0000101000110001;        // sigmoid_in = 0.5625
                    0000100101: sigmoid_value = 0000101001000000;        // sigmoid_in = 0.578125
                    0000100110: sigmoid_value = 0000101001001110;        // sigmoid_in = 0.59375
                    0000100111: sigmoid_value = 0000101001011101;        // sigmoid_in = 0.609375
                    0000101000: sigmoid_value = 0000101001101011;        // sigmoid_in = 0.625
                    0000101001: sigmoid_value = 0000101001111010;        // sigmoid_in = 0.640625
                    0000101010: sigmoid_value = 0000101010001000;        // sigmoid_in = 0.65625
                    0000101011: sigmoid_value = 0000101010010111;        // sigmoid_in = 0.671875
                    0000101100: sigmoid_value = 0000101010100101;        // sigmoid_in = 0.6875
                    0000101101: sigmoid_value = 0000101010110011;        // sigmoid_in = 0.703125
                    0000101110: sigmoid_value = 0000101011000001;        // sigmoid_in = 0.71875
                    0000101111: sigmoid_value = 0000101011001111;        // sigmoid_in = 0.734375
                    0000110000: sigmoid_value = 0000101011011101;        // sigmoid_in = 0.75
                    0000110001: sigmoid_value = 0000101011101011;        // sigmoid_in = 0.765625
                    0000110010: sigmoid_value = 0000101011111001;        // sigmoid_in = 0.78125
                    0000110011: sigmoid_value = 0000101100000111;        // sigmoid_in = 0.796875
                    0000110100: sigmoid_value = 0000101100010101;        // sigmoid_in = 0.8125
                    0000110101: sigmoid_value = 0000101100100010;        // sigmoid_in = 0.828125
                    0000110110: sigmoid_value = 0000101100110000;        // sigmoid_in = 0.84375
                    0000110111: sigmoid_value = 0000101100111101;        // sigmoid_in = 0.859375
                    0000111000: sigmoid_value = 0000101101001010;        // sigmoid_in = 0.875
                    0000111001: sigmoid_value = 0000101101011000;        // sigmoid_in = 0.890625
                    0000111010: sigmoid_value = 0000101101100101;        // sigmoid_in = 0.90625
                    0000111011: sigmoid_value = 0000101101110010;        // sigmoid_in = 0.921875
                    0000111100: sigmoid_value = 0000101101111111;        // sigmoid_in = 0.9375
                    0000111101: sigmoid_value = 0000101110001100;        // sigmoid_in = 0.953125
                    0000111110: sigmoid_value = 0000101110011001;        // sigmoid_in = 0.96875
                    0000111111: sigmoid_value = 0000101110100101;        // sigmoid_in = 0.984375
                    0001000000: sigmoid_value = 0000101110110010;        // sigmoid_in = 1.0
                    0001000001: sigmoid_value = 0000101110111110;        // sigmoid_in = 1.015625
                    0001000010: sigmoid_value = 0000101111001011;        // sigmoid_in = 1.03125
                    0001000011: sigmoid_value = 0000101111010111;        // sigmoid_in = 1.046875
                    0001000100: sigmoid_value = 0000101111100100;        // sigmoid_in = 1.0625
                    0001000101: sigmoid_value = 0000101111110000;        // sigmoid_in = 1.078125
                    0001000110: sigmoid_value = 0000101111111100;        // sigmoid_in = 1.09375
                    0001000111: sigmoid_value = 0000110000001000;        // sigmoid_in = 1.109375
                    0001001000: sigmoid_value = 0000110000010100;        // sigmoid_in = 1.125
                    0001001001: sigmoid_value = 0000110000011111;        // sigmoid_in = 1.140625
                    0001001010: sigmoid_value = 0000110000101011;        // sigmoid_in = 1.15625
                    0001001011: sigmoid_value = 0000110000110111;        // sigmoid_in = 1.171875
                    0001001100: sigmoid_value = 0000110001000010;        // sigmoid_in = 1.1875
                    0001001101: sigmoid_value = 0000110001001110;        // sigmoid_in = 1.203125
                    0001001110: sigmoid_value = 0000110001011001;        // sigmoid_in = 1.21875
                    0001001111: sigmoid_value = 0000110001100100;        // sigmoid_in = 1.234375
                    0001010000: sigmoid_value = 0000110001101111;        // sigmoid_in = 1.25
                    0001010001: sigmoid_value = 0000110001111010;        // sigmoid_in = 1.265625
                    0001010010: sigmoid_value = 0000110010000101;        // sigmoid_in = 1.28125
                    0001010011: sigmoid_value = 0000110010010000;        // sigmoid_in = 1.296875
                    0001010100: sigmoid_value = 0000110010011011;        // sigmoid_in = 1.3125
                    0001010101: sigmoid_value = 0000110010100110;        // sigmoid_in = 1.328125
                    0001010110: sigmoid_value = 0000110010110000;        // sigmoid_in = 1.34375
                    0001010111: sigmoid_value = 0000110010111011;        // sigmoid_in = 1.359375
                    0001011000: sigmoid_value = 0000110011000101;        // sigmoid_in = 1.375
                    0001011001: sigmoid_value = 0000110011001111;        // sigmoid_in = 1.390625
                    0001011010: sigmoid_value = 0000110011011001;        // sigmoid_in = 1.40625
                    0001011011: sigmoid_value = 0000110011100011;        // sigmoid_in = 1.421875
                    0001011100: sigmoid_value = 0000110011101101;        // sigmoid_in = 1.4375
                    0001011101: sigmoid_value = 0000110011110111;        // sigmoid_in = 1.453125
                    0001011110: sigmoid_value = 0000110100000001;        // sigmoid_in = 1.46875
                    0001011111: sigmoid_value = 0000110100001011;        // sigmoid_in = 1.484375
                    0001100000: sigmoid_value = 0000110100010100;        // sigmoid_in = 1.5
                    0001100001: sigmoid_value = 0000110100011110;        // sigmoid_in = 1.515625
                    0001100010: sigmoid_value = 0000110100100111;        // sigmoid_in = 1.53125
                    0001100011: sigmoid_value = 0000110100110000;        // sigmoid_in = 1.546875
                    0001100100: sigmoid_value = 0000110100111010;        // sigmoid_in = 1.5625
                    0001100101: sigmoid_value = 0000110101000011;        // sigmoid_in = 1.578125
                    0001100110: sigmoid_value = 0000110101001100;        // sigmoid_in = 1.59375
                    0001100111: sigmoid_value = 0000110101010101;        // sigmoid_in = 1.609375
                    0001101000: sigmoid_value = 0000110101011110;        // sigmoid_in = 1.625
                    0001101001: sigmoid_value = 0000110101100110;        // sigmoid_in = 1.640625
                    0001101010: sigmoid_value = 0000110101101111;        // sigmoid_in = 1.65625
                    0001101011: sigmoid_value = 0000110101111000;        // sigmoid_in = 1.671875
                    0001101100: sigmoid_value = 0000110110000000;        // sigmoid_in = 1.6875
                    0001101101: sigmoid_value = 0000110110001000;        // sigmoid_in = 1.703125
                    0001101110: sigmoid_value = 0000110110010001;        // sigmoid_in = 1.71875
                    0001101111: sigmoid_value = 0000110110011001;        // sigmoid_in = 1.734375
                    0001110000: sigmoid_value = 0000110110100001;        // sigmoid_in = 1.75
                    0001110001: sigmoid_value = 0000110110101001;        // sigmoid_in = 1.765625
                    0001110010: sigmoid_value = 0000110110110001;        // sigmoid_in = 1.78125
                    0001110011: sigmoid_value = 0000110110111001;        // sigmoid_in = 1.796875
                    0001110100: sigmoid_value = 0000110111000001;        // sigmoid_in = 1.8125
                    0001110101: sigmoid_value = 0000110111001000;        // sigmoid_in = 1.828125
                    0001110110: sigmoid_value = 0000110111010000;        // sigmoid_in = 1.84375
                    0001110111: sigmoid_value = 0000110111010111;        // sigmoid_in = 1.859375
                    0001111000: sigmoid_value = 0000110111011111;        // sigmoid_in = 1.875
                    0001111001: sigmoid_value = 0000110111100110;        // sigmoid_in = 1.890625
                    0001111010: sigmoid_value = 0000110111101101;        // sigmoid_in = 1.90625
                    0001111011: sigmoid_value = 0000110111110101;        // sigmoid_in = 1.921875
                    0001111100: sigmoid_value = 0000110111111100;        // sigmoid_in = 1.9375
                    0001111101: sigmoid_value = 0000111000000011;        // sigmoid_in = 1.953125
                    0001111110: sigmoid_value = 0000111000001010;        // sigmoid_in = 1.96875
                    0001111111: sigmoid_value = 0000111000010000;        // sigmoid_in = 1.984375
                    0010000000: sigmoid_value = 0000111000010111;        // sigmoid_in = 2.0
                    0010000001: sigmoid_value = 0000111000011110;        // sigmoid_in = 2.015625
                    0010000010: sigmoid_value = 0000111000100101;        // sigmoid_in = 2.03125
                    0010000011: sigmoid_value = 0000111000101011;        // sigmoid_in = 2.046875
                    0010000100: sigmoid_value = 0000111000110001;        // sigmoid_in = 2.0625
                    0010000101: sigmoid_value = 0000111000111000;        // sigmoid_in = 2.078125
                    0010000110: sigmoid_value = 0000111000111110;        // sigmoid_in = 2.09375
                    0010000111: sigmoid_value = 0000111001000100;        // sigmoid_in = 2.109375
                    0010001000: sigmoid_value = 0000111001001010;        // sigmoid_in = 2.125
                    0010001001: sigmoid_value = 0000111001010001;        // sigmoid_in = 2.140625
                    0010001010: sigmoid_value = 0000111001010111;        // sigmoid_in = 2.15625
                    0010001011: sigmoid_value = 0000111001011100;        // sigmoid_in = 2.171875
                    0010001100: sigmoid_value = 0000111001100010;        // sigmoid_in = 2.1875
                    0010001101: sigmoid_value = 0000111001101000;        // sigmoid_in = 2.203125
                    0010001110: sigmoid_value = 0000111001101110;        // sigmoid_in = 2.21875
                    0010001111: sigmoid_value = 0000111001110011;        // sigmoid_in = 2.234375
                    0010010000: sigmoid_value = 0000111001111001;        // sigmoid_in = 2.25
                    0010010001: sigmoid_value = 0000111001111110;        // sigmoid_in = 2.265625
                    0010010010: sigmoid_value = 0000111010000100;        // sigmoid_in = 2.28125
                    0010010011: sigmoid_value = 0000111010001001;        // sigmoid_in = 2.296875
                    0010010100: sigmoid_value = 0000111010001110;        // sigmoid_in = 2.3125
                    0010010101: sigmoid_value = 0000111010010100;        // sigmoid_in = 2.328125
                    0010010110: sigmoid_value = 0000111010011001;        // sigmoid_in = 2.34375
                    0010010111: sigmoid_value = 0000111010011110;        // sigmoid_in = 2.359375
                    0010011000: sigmoid_value = 0000111010100011;        // sigmoid_in = 2.375
                    0010011001: sigmoid_value = 0000111010101000;        // sigmoid_in = 2.390625
                    0010011010: sigmoid_value = 0000111010101101;        // sigmoid_in = 2.40625
                    0010011011: sigmoid_value = 0000111010110010;        // sigmoid_in = 2.421875
                    0010011100: sigmoid_value = 0000111010110110;        // sigmoid_in = 2.4375
                    0010011101: sigmoid_value = 0000111010111011;        // sigmoid_in = 2.453125
                    0010011110: sigmoid_value = 0000111011000000;        // sigmoid_in = 2.46875
                    0010011111: sigmoid_value = 0000111011000100;        // sigmoid_in = 2.484375
                    0010100000: sigmoid_value = 0000111011001001;        // sigmoid_in = 2.5
                    0010100001: sigmoid_value = 0000111011001101;        // sigmoid_in = 2.515625
                    0010100010: sigmoid_value = 0000111011010010;        // sigmoid_in = 2.53125
                    0010100011: sigmoid_value = 0000111011010110;        // sigmoid_in = 2.546875
                    0010100100: sigmoid_value = 0000111011011010;        // sigmoid_in = 2.5625
                    0010100101: sigmoid_value = 0000111011011110;        // sigmoid_in = 2.578125
                    0010100110: sigmoid_value = 0000111011100011;        // sigmoid_in = 2.59375
                    0010100111: sigmoid_value = 0000111011100111;        // sigmoid_in = 2.609375
                    0010101000: sigmoid_value = 0000111011101011;        // sigmoid_in = 2.625
                    0010101001: sigmoid_value = 0000111011101111;        // sigmoid_in = 2.640625
                    0010101010: sigmoid_value = 0000111011110011;        // sigmoid_in = 2.65625
                    0010101011: sigmoid_value = 0000111011110111;        // sigmoid_in = 2.671875
                    0010101100: sigmoid_value = 0000111011111011;        // sigmoid_in = 2.6875
                    0010101101: sigmoid_value = 0000111011111110;        // sigmoid_in = 2.703125
                    0010101110: sigmoid_value = 0000111100000010;        // sigmoid_in = 2.71875
                    0010101111: sigmoid_value = 0000111100000110;        // sigmoid_in = 2.734375
                    0010110000: sigmoid_value = 0000111100001001;        // sigmoid_in = 2.75
                    0010110001: sigmoid_value = 0000111100001101;        // sigmoid_in = 2.765625
                    0010110010: sigmoid_value = 0000111100010001;        // sigmoid_in = 2.78125
                    0010110011: sigmoid_value = 0000111100010100;        // sigmoid_in = 2.796875
                    0010110100: sigmoid_value = 0000111100010111;        // sigmoid_in = 2.8125
                    0010110101: sigmoid_value = 0000111100011011;        // sigmoid_in = 2.828125
                    0010110110: sigmoid_value = 0000111100011110;        // sigmoid_in = 2.84375
                    0010110111: sigmoid_value = 0000111100100010;        // sigmoid_in = 2.859375
                    0010111000: sigmoid_value = 0000111100100101;        // sigmoid_in = 2.875
                    0010111001: sigmoid_value = 0000111100101000;        // sigmoid_in = 2.890625
                    0010111010: sigmoid_value = 0000111100101011;        // sigmoid_in = 2.90625
                    0010111011: sigmoid_value = 0000111100101110;        // sigmoid_in = 2.921875
                    0010111100: sigmoid_value = 0000111100110001;        // sigmoid_in = 2.9375
                    0010111101: sigmoid_value = 0000111100110100;        // sigmoid_in = 2.953125
                    0010111110: sigmoid_value = 0000111100110111;        // sigmoid_in = 2.96875
                    0010111111: sigmoid_value = 0000111100111010;        // sigmoid_in = 2.984375
                    0011000000: sigmoid_value = 0000111100111101;        // sigmoid_in = 3.0
                    0011000001: sigmoid_value = 0000111101000000;        // sigmoid_in = 3.015625
                    0011000010: sigmoid_value = 0000111101000011;        // sigmoid_in = 3.03125
                    0011000011: sigmoid_value = 0000111101000110;        // sigmoid_in = 3.046875
                    0011000100: sigmoid_value = 0000111101001000;        // sigmoid_in = 3.0625
                    0011000101: sigmoid_value = 0000111101001011;        // sigmoid_in = 3.078125
                    0011000110: sigmoid_value = 0000111101001110;        // sigmoid_in = 3.09375
                    0011000111: sigmoid_value = 0000111101010001;        // sigmoid_in = 3.109375
                    0011001000: sigmoid_value = 0000111101010011;        // sigmoid_in = 3.125
                    0011001001: sigmoid_value = 0000111101010110;        // sigmoid_in = 3.140625
                    0011001010: sigmoid_value = 0000111101011000;        // sigmoid_in = 3.15625
                    0011001011: sigmoid_value = 0000111101011011;        // sigmoid_in = 3.171875
                    0011001100: sigmoid_value = 0000111101011101;        // sigmoid_in = 3.1875
                    0011001101: sigmoid_value = 0000111101100000;        // sigmoid_in = 3.203125
                    0011001110: sigmoid_value = 0000111101100010;        // sigmoid_in = 3.21875
                    0011001111: sigmoid_value = 0000111101100100;        // sigmoid_in = 3.234375
                    0011010000: sigmoid_value = 0000111101100111;        // sigmoid_in = 3.25
                    0011010001: sigmoid_value = 0000111101101001;        // sigmoid_in = 3.265625
                    0011010010: sigmoid_value = 0000111101101011;        // sigmoid_in = 3.28125
                    0011010011: sigmoid_value = 0000111101101101;        // sigmoid_in = 3.296875
                    0011010100: sigmoid_value = 0000111101110000;        // sigmoid_in = 3.3125
                    0011010101: sigmoid_value = 0000111101110010;        // sigmoid_in = 3.328125
                    0011010110: sigmoid_value = 0000111101110100;        // sigmoid_in = 3.34375
                    0011010111: sigmoid_value = 0000111101110110;        // sigmoid_in = 3.359375
                    0011011000: sigmoid_value = 0000111101111000;        // sigmoid_in = 3.375
                    0011011001: sigmoid_value = 0000111101111010;        // sigmoid_in = 3.390625
                    0011011010: sigmoid_value = 0000111101111100;        // sigmoid_in = 3.40625
                    0011011011: sigmoid_value = 0000111101111110;        // sigmoid_in = 3.421875
                    0011011100: sigmoid_value = 0000111110000000;        // sigmoid_in = 3.4375
                    0011011101: sigmoid_value = 0000111110000010;        // sigmoid_in = 3.453125
                    0011011110: sigmoid_value = 0000111110000100;        // sigmoid_in = 3.46875
                    0011011111: sigmoid_value = 0000111110000110;        // sigmoid_in = 3.484375
                    0011100000: sigmoid_value = 0000111110000111;        // sigmoid_in = 3.5
                    0011100001: sigmoid_value = 0000111110001001;        // sigmoid_in = 3.515625
                    0011100010: sigmoid_value = 0000111110001011;        // sigmoid_in = 3.53125
                    0011100011: sigmoid_value = 0000111110001101;        // sigmoid_in = 3.546875
                    0011100100: sigmoid_value = 0000111110001111;        // sigmoid_in = 3.5625
                    0011100101: sigmoid_value = 0000111110010000;        // sigmoid_in = 3.578125
                    0011100110: sigmoid_value = 0000111110010010;        // sigmoid_in = 3.59375
                    0011100111: sigmoid_value = 0000111110010100;        // sigmoid_in = 3.609375
                    0011101000: sigmoid_value = 0000111110010101;        // sigmoid_in = 3.625
                    0011101001: sigmoid_value = 0000111110010111;        // sigmoid_in = 3.640625
                    0011101010: sigmoid_value = 0000111110011000;        // sigmoid_in = 3.65625
                    0011101011: sigmoid_value = 0000111110011010;        // sigmoid_in = 3.671875
                    0011101100: sigmoid_value = 0000111110011011;        // sigmoid_in = 3.6875
                    0011101101: sigmoid_value = 0000111110011101;        // sigmoid_in = 3.703125
                    0011101110: sigmoid_value = 0000111110011110;        // sigmoid_in = 3.71875
                    0011101111: sigmoid_value = 0000111110100000;        // sigmoid_in = 3.734375
                    0011110000: sigmoid_value = 0000111110100001;        // sigmoid_in = 3.75
                    0011110001: sigmoid_value = 0000111110100011;        // sigmoid_in = 3.765625
                    0011110010: sigmoid_value = 0000111110100100;        // sigmoid_in = 3.78125
                    0011110011: sigmoid_value = 0000111110100110;        // sigmoid_in = 3.796875
                    0011110100: sigmoid_value = 0000111110100111;        // sigmoid_in = 3.8125
                    0011110101: sigmoid_value = 0000111110101000;        // sigmoid_in = 3.828125
                    0011110110: sigmoid_value = 0000111110101010;        // sigmoid_in = 3.84375
                    0011110111: sigmoid_value = 0000111110101011;        // sigmoid_in = 3.859375
                    0011111000: sigmoid_value = 0000111110101100;        // sigmoid_in = 3.875
                    0011111001: sigmoid_value = 0000111110101101;        // sigmoid_in = 3.890625
                    0011111010: sigmoid_value = 0000111110101111;        // sigmoid_in = 3.90625
                    0011111011: sigmoid_value = 0000111110110000;        // sigmoid_in = 3.921875
                    0011111100: sigmoid_value = 0000111110110001;        // sigmoid_in = 3.9375
                    0011111101: sigmoid_value = 0000111110110010;        // sigmoid_in = 3.953125
                    0011111110: sigmoid_value = 0000111110110100;        // sigmoid_in = 3.96875
                    0011111111: sigmoid_value = 0000111110110101;        // sigmoid_in = 3.984375
                    0100000000: sigmoid_value = 0000111110110110;        // sigmoid_in = 4.0             
                // 本部分为补码表示-End
			endcase
		end
	end
	
endmodule
