`include "ISA.v"

module Datapath(
    input clk,
    input rst,

    input [`NUM_CELLS - 1:0] data_in,

	// inputs from controller
	input inc_step,

	// outputs to controller
    output done,

    output [`NUM_CELLS - 1:0] data_out
);
    wire [`LEN_COUNTER_DATA - 1:0] step_counter_result;
    Counter step_counter(
        .clk(clk),
        .rst(rst),
		.en(inc_step),

		.out(step_counter_result)
    );
    assign done = step_counter_result == `COUNT_STEPS;

    wire start_col_parity, count_col_parity, write_col_parity, done_col_parity;
    wire [`NUM_CELLS - 1:0] col_parity_output;
    ColParity col_parity(
        .clk(clk),
        .rst(rst),
        .data_in(data_in),

        .start(start_col_parity),
        .count(count_col_parity),
        .write(write_col_parity),

        .done(done_col_parity),
        .data_out(col_parity_output)
    );

    wire start_rotate, count_rotate, write_rotate, done_rotate;
    wire [`NUM_CELLS - 1:0] rotate_output;
    Rotate rotate(
        .clk(clk),
        .rst(rst),
        .data_in(col_parity_output),

        .start(start_rotate),
        .count(count_rotate),
        .write(write_rotate),

        .done(done_rotate),
        .data_out(rotate_output)
    );

    wire start_permute, count_permute, write_permute, done_permute;
    wire [`NUM_CELLS - 1:0] permute_output;
    // Permute permute(
    //     .clk(clk),
    //     .rst(rst),
    //     .data_in(rotate_output),

    //     .start(start_permute),
    //     .count(count_permute),
    //     .write(write_permute),

    //     .done(done_permute),
    //     .data_out(permute_output)
    // );

    wire start_revaluate, count_revaluate, write_revaluate, done_revaluate;
    wire [`NUM_CELLS - 1:0] revaluate_output;
    Revaluate revaluate(
        .clk(clk),
        .rst(rst),
        .data_in(permute_output),

        .start(start_revaluate),
        .count(count_revaluate),
        .write(write_revaluate),

        .done(done_revaluate),
        .data_out(revaluate_output)
    );

    wire start_add_rc, count_add_rc, write_add_rc, done_add_rc;
    wire [`NUM_CELLS - 1:0] add_rc_output;
    // AddRC add_rc(
    //     .clk(clk),
    //     .rst(rst),
    //     .data_in(revaluate_output),

    //     .start(start_add_rc),
    //     .count(count_add_rc),
    //     .write(write_add_rc),

    //     .done(done_add_rc),
    //     .data_out(data_out)
    // );

endmodule
