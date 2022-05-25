`include "ISA.v"

module Permute(
    input clk,
    input rst,
    input start,
    input [`NUM_CELLS - 1:0] data_in,

    input count,
    input write,

    output done,
    output [`NUM_CELLS - 1:0] data_out
);
    wire [2:0] i;
    wire i_overflow;
    Counter #(.WORD_LENGTH(3)) i_counter(
        .clk(clk),
        .rst(rst),
        .en(count),
        .max(4'd`NUM_ROW),

        .overflow(i_overflow),
        .out(i)
    );

    wire [2:0] j;
    wire j_overflow;
    Counter #(.WORD_LENGTH(3)) j_counter(
        .clk(clk),
        .rst(rst),
        .en(i_overflow),
        .max(4'd`NUM_COLUMN),

        .overflow(j_overflow),
        .out(j)
    );

    wire [5:0] k;
    Counter #(.WORD_LENGTH(6)) k_counter(
        .clk(clk),
        .rst(rst),
        .en(j_overflow),
        .max(7'd`NUM_PAGE),

        .overflow(done),
        .out(k)
    );

    wire current_cell;
    MUX3Dto1 cell_mux(
        .mat(data_in),
        .i(i),
        .j(j),
        .k(k),

        .out(current_cell)
    );

    wire [2:0] ii = j;
    wire [2:0] jj = (2 * i + 3 * j) % `NUM_COLUMN;

    wire [`LEN_ADDRESS - 1:0] address_in = k * `NUM_ROW * `NUM_COLUMN + jj * `NUM_ROW + ii;
    Memory memory(
        .clk(clk),
        .rst(rst),
        .mem_write(write),
        .address_in(address_in),
        .data_in(current_cell),

        .data_out(data_out)
    );

endmodule
