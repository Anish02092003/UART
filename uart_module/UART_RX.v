module UART_RX (
    input clk,
    input rst,
    input rx,
    output reg [7:0] data_out,
    output reg data_valid
);
    reg [3:0] bit_cnt;
    reg [7:0] rx_shift;
    reg [15:0] baud_cnt;
    reg receiving;
    parameter BAUD_DIV = 10416;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_cnt <= 0;
            data_valid <= 0;
            baud_cnt <= 0;
            receiving <= 0;
        end else begin
            data_valid <= 0;
            if (!receiving && !rx) begin
                receiving <= 1;
                baud_cnt <= BAUD_DIV / 2;
                bit_cnt <= 0;
            end else if (receiving) begin
                if (baud_cnt == BAUD_DIV) begin
                    baud_cnt <= 0;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt < 8)
                        rx_shift <= {rx, rx_shift[7:1]};
                    else if (bit_cnt == 8) begin
                        data_out <= rx_shift;
                        data_valid <= 1;
                        receiving <= 0;
                    end
                end else baud_cnt <= baud_cnt + 1;
            end
        end
    end
endmodule
