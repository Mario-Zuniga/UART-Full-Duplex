`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO 
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Contador_Comparador(
	input	clk, rst,
	input enable,
	output reg iguales	
	);

// bloque contador
reg [25:0] CuentaCada20ns;

always @ (posedge rst or posedge clk) 
	begin
	  if (rst) CuentaCada20ns <= 0;  
	  else if (iguales) CuentaCada20ns <= 0;
			else if (enable) CuentaCada20ns <= CuentaCada20ns +1;
			else CuentaCada20ns <= CuentaCada20ns;
	end

// bloque comparador
always @(CuentaCada20ns)
	begin
		if (CuentaCada20ns ==500_000) 
			iguales = 'b1; 
		else iguales = 0;
end

endmodule
