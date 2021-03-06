`include "ISA.v"

module TB();
    reg clk = 0;
	reg rst = 0;
	reg start = 0;
	reg [`NUM_CELLS - 1:0] input_data = {
        {`NUM_ROW'b11110, `NUM_ROW'b01001, `NUM_ROW'b00111, `NUM_ROW'b01000, `NUM_ROW'b10111},
        {`NUM_ROW'b10011, `NUM_ROW'b11101, `NUM_ROW'b00010, `NUM_ROW'b10101, `NUM_ROW'b11100},
        {`NUM_ROW'b10101, `NUM_ROW'b00000, `NUM_ROW'b00000, `NUM_ROW'b10101, `NUM_ROW'b01111},
        {`NUM_ROW'b01101, `NUM_ROW'b01010, `NUM_ROW'b00000, `NUM_ROW'b11000, `NUM_ROW'b00001},
        {`NUM_ROW'b11011, `NUM_ROW'b01000, `NUM_ROW'b00111, `NUM_ROW'b00110, `NUM_ROW'b11001},
        {`NUM_ROW'b10100, `NUM_ROW'b11110, `NUM_ROW'b00101, `NUM_ROW'b10101, `NUM_ROW'b00011},
        {`NUM_ROW'b10101, `NUM_ROW'b01011, `NUM_ROW'b00000, `NUM_ROW'b10001, `NUM_ROW'b10010},
        {`NUM_ROW'b01001, `NUM_ROW'b10101, `NUM_ROW'b10000, `NUM_ROW'b00011, `NUM_ROW'b11100},
        {`NUM_ROW'b11010, `NUM_ROW'b00010, `NUM_ROW'b00101, `NUM_ROW'b10010, `NUM_ROW'b10100},
        {`NUM_ROW'b01000, `NUM_ROW'b01001, `NUM_ROW'b11001, `NUM_ROW'b00000, `NUM_ROW'b10010},
        {`NUM_ROW'b11100, `NUM_ROW'b01010, `NUM_ROW'b11110, `NUM_ROW'b11011, `NUM_ROW'b00111},
        {`NUM_ROW'b11000, `NUM_ROW'b01011, `NUM_ROW'b00101, `NUM_ROW'b11101, `NUM_ROW'b00011},
        {`NUM_ROW'b10010, `NUM_ROW'b10100, `NUM_ROW'b00001, `NUM_ROW'b01110, `NUM_ROW'b10110},
        {`NUM_ROW'b11110, `NUM_ROW'b01001, `NUM_ROW'b00000, `NUM_ROW'b10010, `NUM_ROW'b01100},
        {`NUM_ROW'b00111, `NUM_ROW'b11111, `NUM_ROW'b01001, `NUM_ROW'b10010, `NUM_ROW'b01111},
        {`NUM_ROW'b11011, `NUM_ROW'b11000, `NUM_ROW'b01000, `NUM_ROW'b00000, `NUM_ROW'b11101},
        {`NUM_ROW'b01000, `NUM_ROW'b10110, `NUM_ROW'b01100, `NUM_ROW'b01100, `NUM_ROW'b10010},
        {`NUM_ROW'b00101, `NUM_ROW'b11001, `NUM_ROW'b10001, `NUM_ROW'b10101, `NUM_ROW'b11111},
        {`NUM_ROW'b01111, `NUM_ROW'b01101, `NUM_ROW'b10110, `NUM_ROW'b00101, `NUM_ROW'b01110},
        {`NUM_ROW'b11101, `NUM_ROW'b11001, `NUM_ROW'b10000, `NUM_ROW'b11110, `NUM_ROW'b01001},
        {`NUM_ROW'b01100, `NUM_ROW'b01110, `NUM_ROW'b10000, `NUM_ROW'b00101, `NUM_ROW'b11000},
        {`NUM_ROW'b11001, `NUM_ROW'b00110, `NUM_ROW'b10001, `NUM_ROW'b00111, `NUM_ROW'b00011},
        {`NUM_ROW'b11010, `NUM_ROW'b01011, `NUM_ROW'b11101, `NUM_ROW'b01111, `NUM_ROW'b00101},
        {`NUM_ROW'b00011, `NUM_ROW'b01000, `NUM_ROW'b11101, `NUM_ROW'b11001, `NUM_ROW'b10111},
        {`NUM_ROW'b00101, `NUM_ROW'b11001, `NUM_ROW'b01010, `NUM_ROW'b10010, `NUM_ROW'b00100},
        {`NUM_ROW'b01111, `NUM_ROW'b10110, `NUM_ROW'b10010, `NUM_ROW'b00001, `NUM_ROW'b00001},
        {`NUM_ROW'b11000, `NUM_ROW'b11001, `NUM_ROW'b01010, `NUM_ROW'b00101, `NUM_ROW'b11000},
        {`NUM_ROW'b10011, `NUM_ROW'b10110, `NUM_ROW'b10111, `NUM_ROW'b11100, `NUM_ROW'b00100},
        {`NUM_ROW'b11011, `NUM_ROW'b10010, `NUM_ROW'b01101, `NUM_ROW'b00110, `NUM_ROW'b00111},
        {`NUM_ROW'b10111, `NUM_ROW'b00110, `NUM_ROW'b00001, `NUM_ROW'b10000, `NUM_ROW'b10001},
        {`NUM_ROW'b10010, `NUM_ROW'b00111, `NUM_ROW'b01000, `NUM_ROW'b10000, `NUM_ROW'b10110},
        {`NUM_ROW'b01001, `NUM_ROW'b00011, `NUM_ROW'b10010, `NUM_ROW'b10011, `NUM_ROW'b01101},
        {`NUM_ROW'b11001, `NUM_ROW'b11111, `NUM_ROW'b11010, `NUM_ROW'b11110, `NUM_ROW'b11111},
        {`NUM_ROW'b10100, `NUM_ROW'b11000, `NUM_ROW'b01001, `NUM_ROW'b11010, `NUM_ROW'b00100},
        {`NUM_ROW'b00101, `NUM_ROW'b01101, `NUM_ROW'b01100, `NUM_ROW'b01010, `NUM_ROW'b10001},
        {`NUM_ROW'b11011, `NUM_ROW'b00111, `NUM_ROW'b01010, `NUM_ROW'b01100, `NUM_ROW'b01001},
        {`NUM_ROW'b10101, `NUM_ROW'b01110, `NUM_ROW'b11111, `NUM_ROW'b01111, `NUM_ROW'b01111},
        {`NUM_ROW'b11111, `NUM_ROW'b00101, `NUM_ROW'b11110, `NUM_ROW'b01000, `NUM_ROW'b01110},
        {`NUM_ROW'b01100, `NUM_ROW'b00000, `NUM_ROW'b11101, `NUM_ROW'b00011, `NUM_ROW'b10101},
        {`NUM_ROW'b00001, `NUM_ROW'b10011, `NUM_ROW'b00110, `NUM_ROW'b11100, `NUM_ROW'b00111},
        {`NUM_ROW'b00010, `NUM_ROW'b11000, `NUM_ROW'b10010, `NUM_ROW'b11101, `NUM_ROW'b00001},
        {`NUM_ROW'b11011, `NUM_ROW'b00000, `NUM_ROW'b10110, `NUM_ROW'b11110, `NUM_ROW'b01011},
        {`NUM_ROW'b11111, `NUM_ROW'b11010, `NUM_ROW'b11110, `NUM_ROW'b11111, `NUM_ROW'b10111},
        {`NUM_ROW'b11000, `NUM_ROW'b00001, `NUM_ROW'b00011, `NUM_ROW'b01100, `NUM_ROW'b10011},
        {`NUM_ROW'b10101, `NUM_ROW'b11111, `NUM_ROW'b10010, `NUM_ROW'b01101, `NUM_ROW'b00100},
        {`NUM_ROW'b11001, `NUM_ROW'b01000, `NUM_ROW'b11111, `NUM_ROW'b11110, `NUM_ROW'b00110},
        {`NUM_ROW'b10011, `NUM_ROW'b11000, `NUM_ROW'b10101, `NUM_ROW'b10011, `NUM_ROW'b11011},
        {`NUM_ROW'b00111, `NUM_ROW'b00110, `NUM_ROW'b10001, `NUM_ROW'b11001, `NUM_ROW'b00111},
        {`NUM_ROW'b01010, `NUM_ROW'b10101, `NUM_ROW'b00001, `NUM_ROW'b00011, `NUM_ROW'b10100},
        {`NUM_ROW'b11001, `NUM_ROW'b10000, `NUM_ROW'b01011, `NUM_ROW'b01001, `NUM_ROW'b01011},
        {`NUM_ROW'b11110, `NUM_ROW'b11011, `NUM_ROW'b10010, `NUM_ROW'b01010, `NUM_ROW'b11001},
        {`NUM_ROW'b11011, `NUM_ROW'b01100, `NUM_ROW'b01000, `NUM_ROW'b11101, `NUM_ROW'b01001},
        {`NUM_ROW'b01101, `NUM_ROW'b11111, `NUM_ROW'b01111, `NUM_ROW'b00111, `NUM_ROW'b00101},
        {`NUM_ROW'b11011, `NUM_ROW'b00110, `NUM_ROW'b01110, `NUM_ROW'b00111, `NUM_ROW'b11110},
        {`NUM_ROW'b10011, `NUM_ROW'b00010, `NUM_ROW'b11000, `NUM_ROW'b10110, `NUM_ROW'b10111},
        {`NUM_ROW'b01011, `NUM_ROW'b11001, `NUM_ROW'b01111, `NUM_ROW'b00010, `NUM_ROW'b00001},
        {`NUM_ROW'b10101, `NUM_ROW'b11100, `NUM_ROW'b10111, `NUM_ROW'b01100, `NUM_ROW'b11111},
        {`NUM_ROW'b00011, `NUM_ROW'b01110, `NUM_ROW'b00110, `NUM_ROW'b00111, `NUM_ROW'b00011},
        {`NUM_ROW'b01010, `NUM_ROW'b11100, `NUM_ROW'b01101, `NUM_ROW'b10010, `NUM_ROW'b11101},
        {`NUM_ROW'b00000, `NUM_ROW'b11111, `NUM_ROW'b00110, `NUM_ROW'b11011, `NUM_ROW'b00000},
        {`NUM_ROW'b00101, `NUM_ROW'b01110, `NUM_ROW'b01001, `NUM_ROW'b11010, `NUM_ROW'b01111},
        {`NUM_ROW'b10110, `NUM_ROW'b11000, `NUM_ROW'b01001, `NUM_ROW'b10010, `NUM_ROW'b01110},
        {`NUM_ROW'b10000, `NUM_ROW'b11101, `NUM_ROW'b01010, `NUM_ROW'b01010, `NUM_ROW'b10011},
        {`NUM_ROW'b10100, `NUM_ROW'b00010, `NUM_ROW'b00000, `NUM_ROW'b10101, `NUM_ROW'b00011}
    };

	wire done;
	wire [`NUM_CELLS - 1:0] output_data;

    always #(20) clk = ~clk;

    Encoder enc(
        .clk(clk),
        .rst(rst),
        .start(start),
		.data_in(input_data),

		.done(done),
		.data_out(output_data)
    );

    integer i;
    initial begin
        rst = 1;
        #50 ;
        rst = 0;
        #50
        start = 1;
        #50
        start = 0;
        #50

        i = 0;
        while (done != 1) begin
            #10000 i = i + 1;
            $display("--- %d ---\n", i);
        end

        #50
        $stop;
    end
endmodule // TB
