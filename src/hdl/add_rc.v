`include "ISA.v"

module AddRC(
    input [`NUM_CELLS - 1:0] data_in,
    input [`NUM_TURNS_BITS - 1:0] turn,

    output [`NUM_CELLS - 1:0] data_out
);
    wire [`NUM_PAGE - 1:0] lookup_table [0:`NUM_TURNS - 1];
    assign lookup_table[0]  = 64'h0000000000000001;
    assign lookup_table[1]  = 64'h0000000000008082;
    assign lookup_table[2]  = 64'h800000000000808A;
    assign lookup_table[3]  = 64'h8000000080008000;
    assign lookup_table[4]  = 64'h000000000000808B;
    assign lookup_table[5]  = 64'h0000000080000001;
    assign lookup_table[6]  = 64'h8000000080008081;
    assign lookup_table[7]  = 64'h8000000000008009;
    assign lookup_table[8]  = 64'h000000000000008A;
    assign lookup_table[9]  = 64'h0000000000000088;
    assign lookup_table[10] = 64'h0000000080008009;
    assign lookup_table[11] = 64'h000000008000000A;
    assign lookup_table[12] = 64'h000000008000808B;
    assign lookup_table[13] = 64'h800000000000008B;
    assign lookup_table[14] = 64'h8000000000008089;
    assign lookup_table[15] = 64'h8000000000008003;
    assign lookup_table[16] = 64'h8000000000008002;
    assign lookup_table[17] = 64'h8000000000000080;
    assign lookup_table[18] = 64'h000000000000800A;
    assign lookup_table[19] = 64'h800000008000000A;
    assign lookup_table[20] = 64'h8000000080008081;
    assign lookup_table[21] = 64'h8000000000008080;
    assign lookup_table[22] = 64'h0000000080000001;
    assign lookup_table[23] = 64'h8000000080008008;

    wire[`NUM_PAGE - 1:0] special_value = (lookup_table[turn]);

    genvar ii,jj,kk;
    generate
        for (kk = 0; kk < `NUM_PAGE; kk = kk + 1) begin
            for (jj = 0; jj < `NUM_COLUMN; jj = jj + 1) begin
                for (ii = 0; ii < `NUM_ROW; ii = ii + 1) begin
                    if ((ii==0)&(jj==0))
                        assign data_out[kk * `NUM_ROW * `NUM_COLUMN + jj * `NUM_ROW + ii] = data_in[kk * `NUM_ROW * `NUM_COLUMN + jj * `NUM_ROW + ii] ^ special_value[kk];
                    else
                        assign data_out[kk * `NUM_ROW * `NUM_COLUMN + jj * `NUM_ROW + ii] = data_in[kk * `NUM_ROW * `NUM_COLUMN + jj * `NUM_ROW + ii];
                end
            end
        end
    endgenerate

endmodule
