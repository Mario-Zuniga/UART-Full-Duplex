`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Tx(
	 input Send,
    input Clock_2br,
    input Reset,
	 input [7:0] Sw,
	 output reg Tx
    );
	 
	 wire W_Par;
	 
	 assign W_Par = (Sw[7] ^ Sw[6] ^ Sw[5] ^ Sw[4] ^ Sw[3] ^ Sw[2] ^ Sw[1] ^ Sw[0]);
	 
	 parameter Espera		= 0;
	 parameter Inicio		= 1;
  	 parameter B0			= 2;
	 parameter B1			= 3;
	 parameter B2			= 4;
	 parameter B3			= 5;
	 parameter B4			= 6;
	 parameter B5			= 7;
	 parameter B6			= 8;
	 parameter B7			= 9;
	 parameter Paridad	= 10;
	 parameter Stop		= 11;

	 reg [4:0] Estado;
	 
	 reg [7:0] Switch;
	 
	 reg [27:0] CuentaCada20ns;
	 
	 reg Iguales;

			always @ (posedge Reset or posedge Clock_2br) 
				begin
				  if (Reset) CuentaCada20ns <= 0;  
				  else if (Iguales) CuentaCada20ns <= 0;
				  else CuentaCada20ns <= CuentaCada20ns +1;	
				end

			always @(CuentaCada20ns)
				begin
					if (CuentaCada20ns == 'd5208) 
						Iguales = 1; 
					else Iguales = 0;
			end
	 
	 always @(posedge Reset, posedge Clock_2br)
	 begin
		if (Reset)
		begin
			Estado <= Espera;
			Switch <= 0;
		end
		
		else 
		case (Estado)
				Espera: if (Send)  
						  begin
								Switch <= Sw;
								Estado <= Inicio;
						  end
						  
				Inicio: if (Iguales)		Estado <= B0;
				B0: if (Iguales)			Estado <= B1;			
				B1: if (Iguales)			Estado <= B2;
				B2: if (Iguales)			Estado <= B3;
				B3: if (Iguales)			Estado <= B4;
				B4: if (Iguales)			Estado <= B5;
				B5: if (Iguales)		   Estado <= B6;
				B6: if (Iguales)			Estado <= B7;
				B7: if (Iguales)			Estado <= Paridad;
				Paridad: if (Iguales)	Estado <= Stop;
				Stop: if (Iguales)		Estado <= Espera;
				default: 					Estado <= Espera;
			endcase
	end



	 always @ (Estado or W_Par or Switch)
	 begin
				case(Estado)
				Espera: 	Tx <= 1;
				Inicio:	Tx <= 0;
				B0:		Tx <= Switch[0];	
				B1:		Tx <= Switch[1];
				B2:		Tx <= Switch[2];
				B3:		Tx <= Switch[3];
				B4:		Tx <= Switch[4];
				B5:	   Tx <= Switch[5];
				B6: 		Tx <= Switch[6];
				B7:		Tx <= Switch[7];
				Paridad:	Tx <= W_Par;
				Stop:		Tx <= 1;
				default: Tx <= 1;
			endcase


	 end
	 
	 

endmodule
