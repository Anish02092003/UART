module tb_UART_Loopback;
    reg clk = 0, rst = 1;
    reg [7:0] data_in = 8'hA5;
    reg start = 0;
    wire tx_wire;
    wire [7:0] data_out;
    wire data_valid;

    UART_TX tx_inst(.clk(clk), .rst(rst), .data_in(data_in), .start(start), .tx(tx_wire), .busy());
    UART_RX rx_inst(.clk(clk), .rst(rst), .rx(tx_wire), .data_out(data_out), .data_valid(data_valid));

    always #5 clk = ~clk;

    initial begin
        #20 rst = 0;
        #40 start = 1;
        #10 start = 0;
        #50000;
        if (data_valid) $display("Received Byte: %h", data_out);
        $stop;
    end
endmodule
