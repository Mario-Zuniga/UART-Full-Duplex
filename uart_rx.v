`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: TODO EL GRUPO
// 
//
//////////////////////////////////////////////////////////////////////////////////
module uart_rx(
    input rx,
    input clk_2br,
    input reset,
    output reg enable
    );


parameter espera		= 'b00000;//0
parameter inicio		= 'b00001;//1
parameter inicio_m	= 'b00010;
parameter b0			= 'b00011;
parameter b0_m			= 'b00100;
parameter b1			= 'b00101;
parameter b1_m			= 'b00110;
parameter b2			= 'b00111;
parameter b2_m			= 'b01000;
parameter b3			= 'b01001;
parameter b3_m			= 'b01010;
parameter b4			= 'b01011;
parameter b4_m			= 'b01100;
parameter b5			= 'b01101;
parameter b5_m			= 'b01110;
parameter b6			= 'b01111;
parameter b6_m			= 'b10000;
parameter b7			= 'b10001;
parameter b7_m			= 'b10010;
parameter paridad		= 'b10111;
parameter paridad_m	= 'b10100;
parameter stop			= 'b10101;
parameter stop_m		= 'b10110;

reg [4:0]estado;


always @(posedge reset, posedge clk_2br)
	begin
		if (reset) 
			estado<= espera;
		else 
		case (estado)
				espera: if (~rx)  // Inicio con la cero en rx
								estado <= inicio;
				inicio: 		estado <= inicio_m;
				inicio_m: 	estado <=b0;
				b0:			estado <=b0_m;			
				b0_m:			estado <=b1;
				b1:			estado <=b1_m;
				b1_m:			estado <=b2;
				b2	:			estado <=b2_m;
				b2_m:			estado <=b3;
				b3:			estado <=b3_m;
				b3_m:			estado <=b4;
				b4	:			estado <=b4_m;
				b4_m:			estado <=b5;
				b5		:		estado <=b5_m;
				b5_m	:		estado <=b6;
				b6: 			estado <=b6_m;
				b6_m:			estado <=b7;
				b7	:			estado <=b7_m;
				b7_m:			estado <=paridad;
				paridad:		estado <=paridad_m;
				paridad_m:	estado <=stop;
				stop:			estado <=stop_m;
				stop_m:		estado <=espera;
				default:		estado <= espera;
			endcase
	end



always @(estado)
	begin
				case(estado)
				espera: 	enable = 0;
				inicio:	enable = 0;
				inicio_m:enable = 1;
				b0:		enable = 0;	
				b0_m:		enable = 1;
				b1:		enable = 0;
				b1_m:		enable = 1;
				b2	:		enable = 0;
				b2_m:		enable = 1;
				b3:		enable = 0;
				b3_m:		enable = 1;
				b4	:		enable = 0;
				b4_m:		enable = 1;
				b5		:	enable = 0;
				b5_m	:	enable = 1;
				b6: 		enable = 0;
				b6_m:		enable = 1;
				b7	:		enable = 0;
				b7_m:		enable = 1;
				paridad:	enable = 0;
				paridad_m:enable = 0;
				stop:		enable = 0;
				stop_m:	enable = 0;
				default: enable = 0;
			endcase


end


endmodule
