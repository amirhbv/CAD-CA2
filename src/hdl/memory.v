
`include "ISA.v"

module Memory(
	input clk,
	input rst,

	input mem_write,
	input [`LEN_ADDRESS - 1:0] address_in,
	input data_in,

	output [`NUM_CELLS - 1:0] data_out
);
	reg [`LEN_DATA - 1:0] data;

	assign data_out = data;

	always@(negedge clk) begin
		if(mem_write) begin
			data[address_in] <= data_in;
		end
	end

endmodule
