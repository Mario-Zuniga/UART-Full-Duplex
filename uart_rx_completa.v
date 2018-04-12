`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ITES0
// Engineer: Cuauhtemoc Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////
module uart_rx_completa(
    input clk,
    input reset,
    input rx,
    output [7:0] q,
    output paridad, t0, clk_dividido_out
    );


wire clk_dividido_w, enable_w;
wire [7:0]q_w;

assign t0= 0;
assign clk_dividido_out= clk_dividido_w;
assign q = ~q_w;

shift_register_er u1 (.clk(clk_dividido_w),.reset(reset),.enable(enable_w),.d(rx),.q({paridad,q_w}) );
	 
uart_rx   			u2 ( .rx(rx),.clk_2br(clk_dividido_w),.reset(reset),.enable(enable_w) );	 


frecuency_divider u3 ( .clk(clk),.reset(reset),.clk_dividido(clk_dividido_w)   );
	 
	 
	 
	 
	 
endmodule
