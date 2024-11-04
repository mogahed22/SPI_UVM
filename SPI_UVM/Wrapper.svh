module Wrapper(WRAPPER_interface.DUT WRAPPER_if);
logic SS_n , MOSI , clk, rst_n;
logic MISO;
wire [9:0] rx_data ;
wire  rx_valid , tx_valid;
wire [7:0] tx_data;
SPI slave( MOSI,MISO,SS_n,clk,rst_n,rx_data,tx_data,rx_valid,tx_valid);
RAM ram(rx_data,clk,rst_n,rx_valid,tx_data,tx_valid);
endmodule