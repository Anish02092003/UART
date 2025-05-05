# UART Communication Module (Verilog)

## Description
UART Transmitter and Receiver in Verilog with loopback test and baud rate handling.

## Files
- `UART_TX.v` — Transmitter module
- `UART_RX.v` — Receiver module
- `Top.v` — Combined loopback test
- `tb_UART_Loopback.v` — Testbench

## Simulation
Run `tb_UART_Loopback.v` in ModelSim/Vivado to observe UART transmission.

## Usage
This code can be synthesized on FPGA boards with 9600 baud FTDI UART.
