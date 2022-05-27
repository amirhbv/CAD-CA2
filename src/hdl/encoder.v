`include "ISA.v"

module Encoder(
    input clk,
    input rst,
    input start,
    input [`NUM_CELLS - 1:0] data_in,

    output done,
    output [`NUM_CELLS - 1:0] data_out
);
    wire after_next_turn, temp_done;
    wire [`NUM_TURNS_BITS - 1:0] turn;
    wire col_parity_done, rotate_done, permute_done, revaluate_done;
    wire [`NUM_CELLS - 1:0] col_parity_output, rotate_output, permute_output, revaluate_output;
    wire [`NUM_CELLS - 1:0] add_rc_input, rotate_input, permute_input, revaluate_input;

    Counter #(.WORD_LENGTH(`NUM_TURNS_BITS)) step_counter(
        .clk(clk),
        .rst(rst),
		.en(revaluate_done),
        .max(5'd`NUM_TURNS),

        .overflow(temp_done),
		.out(turn)
    );
    Register #(.WORD_LENGTH(1)) done_register(
		.clk(clk),
        .rst(rst),
		.ld(temp_done),
		.in(temp_done),

		.out(done)
	);
    Register #(.WORD_LENGTH(1)) turn_register(
		.clk(clk),
        .rst(rst),
		.ld(1),
		.in(revaluate_done),

		.out(after_next_turn)
	);
    
    ColParity col_parity(
        .clk(clk),
        .rst(rst),
        .start(((~done) & (after_next_turn|start))),
        .data_in((turn > 0) ? data_out : data_in),

        .done(col_parity_done),
        .data_out(col_parity_output)
    );
    Register #(.WORD_LENGTH(`NUM_CELLS)) col_parity_output_reg(
		.clk(clk),
        .rst(rst),
		.ld(col_parity_done),
		.in(col_parity_output),

		.out(rotate_input)
	);

    Rotate rotate(
        .clk(clk),
        .rst(rst),
        .start(col_parity_done),
        .data_in(rotate_input),

        .done(rotate_done),
        .data_out(rotate_output)
    );
    Register #(.WORD_LENGTH(`NUM_CELLS)) rotate_output_reg(
		.clk(clk),
        .rst(rst),
		.ld(rotate_done),
		.in(rotate_output),

		.out(permute_input)
	);

    Permute permute(
        .clk(clk),
        .rst(rst),
        .start(rotate_done),
        .data_in(permute_input),

        .done(permute_done),
        .data_out(permute_output)
    );
    Register #(.WORD_LENGTH(`NUM_CELLS)) permute_output_reg(
		.clk(clk),
        .rst(rst),
		.ld(permute_done),
		.in(permute_output),

		.out(revaluate_input)
	);

    Revaluate revaluate(
        .clk(clk),
        .rst(rst),
        .start(permute_done),
        .data_in(revaluate_input),

        .done(revaluate_done),
        .data_out(revaluate_output)
    );
    Register #(.WORD_LENGTH(`NUM_CELLS)) revaluate_output_reg(
		.clk(clk),
        .rst(rst),
		.ld(revaluate_done),
		.in(revaluate_output),

		.out(add_rc_input)
	);

    AddRC add_rc(
        .data_in(add_rc_input),
        .turn(done ? 23 : turn-1),

        .data_out(data_out)
    );

endmodule
