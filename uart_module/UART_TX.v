module UART_TX (
    input clk,
    input rst,
    input [7:0] data_in,
    input start,
    output reg tx,
    output reg busy
);
    reg [3:0] bit_cnt;
    reg [15:0] baud_cnt;
    reg [9:0] tx_shift;
    parameter BAUD_DIV = 10416;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1;
            busy <= 0;
            bit_cnt <= 0;
            baud_cnt <= 0;
        end else begin
            if (start && !busy) begin
                tx_shift <= {1'b1, data_in, 1'b0};
                busy <= 1;
                bit_cnt <= 0;
                baud_cnt <= 0;
            end else if (busy) begin
                if (baud_cnt == BAUD_DIV) begin
                    tx <= tx_shift[0];
                    tx_shift <= tx_shift >> 1;
                    bit_cnt <= bit_cnt + 1;
                    baud_cnt <= 0;
                    if (bit_cnt == 9) busy <= 0;
                end else baud_cnt <= baud_cnt + 1;
            end
        end
    end
endmodule
