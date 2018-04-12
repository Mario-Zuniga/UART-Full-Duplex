`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Uart_Tx(
	 input Clock,
	 input Reset,
	 input [7:0] Sw,
	 input Send,
	 output Tx
    );
	 
	 wire W_Pb;
	 
	 Debouncer Deb (.Clock(Clock), .Reset(Reset), .Switch(Send), .One_Shot(W_Pb), .Reset_Control());
	 
	 Tx T (.Send(W_Pb), .Clock_2br(Clock), .Reset(Reset), .Sw(Sw), .Tx(Tx));


endmodule
