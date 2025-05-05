module Top (
    input clk,
    input rst,
    input rx,
    output tx,
    output [7:0] led
);
    wire [7:0] data_out;
    wire data_valid;

    UART_TX tx_inst(.clk(clk), .rst(rst), .data_in(data_out), .start(data_valid), .tx(tx), .busy());
    UART_RX rx_inst(.clk(clk), .rst(rst), .rx(rx), .data_out(data_out), .data_valid(data_valid));

    assign led = data_out;
endmodule
