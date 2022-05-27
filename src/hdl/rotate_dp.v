`include "ISA.v"

module RotateDP(
    input clk,
    input rst,
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
    Counter #(.WORD_LENGTH(7)) k_counter(
        .clk(clk),
        .rst(rst),
        .en(j_overflow),
        .max(7'd`NUM_PAGE),

        .overflow(done),
        .out(k)
    );

    wire current_cell;
    wire [5:0] lookup_table[`NUM_ROW - 1:0][`NUM_COLUMN - 1:0];
    assign lookup_table[0][0] = 0;
    assign lookup_table[0][1] = 36;
    assign lookup_table[0][2] = 3;
    assign lookup_table[0][3] = 41;
    assign lookup_table[0][4] = 18;

    assign lookup_table[1][0] = 1;
    assign lookup_table[1][1] = 44;
    assign lookup_table[1][2] = 10;
    assign lookup_table[1][3] = 45;
    assign lookup_table[1][4] = 2;

    assign lookup_table[2][0] = 62;
    assign lookup_table[2][1] = 6;
    assign lookup_table[2][2] = 43;
    assign lookup_table[2][3] = 15;
    assign lookup_table[2][4] = 61;

    assign lookup_table[3][0] = 28;
    assign lookup_table[3][1] = 55;
    assign lookup_table[3][2] = 25;
    assign lookup_table[3][3] = 21;
    assign lookup_table[3][4] = 56;

    assign lookup_table[4][0] = 27;
    assign lookup_table[4][1] = 20;
    assign lookup_table[4][2] = 39;
    assign lookup_table[4][3] = 8;
    assign lookup_table[4][4] = 14;

    wire [5:0] kk = (k - lookup_table[i][j]) % `NUM_PAGE;

    MUX3Dto1 cell_mux(
        .mat(data_in),
        .i(i),
        .j(j),
        .k(kk),

        .out(current_cell)
    );

    wire [`LEN_ADDRESS - 1:0] address_in = k * `NUM_ROW * `NUM_COLUMN + j * `NUM_ROW + i;
    Memory memory(
        .clk(clk),
        .rst(rst),
        .mem_write(write),
        .address_in(address_in),
        .data_in(current_cell),

        .data_out(data_out)
    );

endmodule
