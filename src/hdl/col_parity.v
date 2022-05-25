`include "ISA.v"

module ColParity(
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

    wire [`NUM_COLUMN - 1:0] col1, col2;
    genvar jj;
    generate
        for (jj = 0; jj < `NUM_COLUMN; jj = jj + 1) begin
            wire [2:0] ii_wire = (i + 1) % `NUM_ROW;
            wire [2:0] jj_wire = jj;
            wire [5:0] kk_wire = (k - 1) % `NUM_PAGE;

            MUX3Dto1 cell1_mux(
                .mat(data_in),
                .i(ii_wire),
                .j(jj_wire),
                .k(kk_wire),

                .out(col1[jj])
            );

            wire [2:0] ii_wire2 = (i - 1) % `NUM_ROW;
            MUX3Dto1 cell2_mux(
                .mat(data_in),
                .i(ii_wire2),
                .j(jj_wire),
                .k(k),

                .out(col2[jj])
            );
        end
    endgenerate

    wire [`LEN_ADDRESS - 1:0] address_in = k * `NUM_ROW * `NUM_COLUMN + j * `NUM_ROW + i;
    Memory memory(
        .clk(clk),
        .rst(rst),
        .mem_write(write),
        .address_in(address_in),
        .data_in(^{current_cell, col1, col2}),

        .data_out(data_out)
    );

endmodule
