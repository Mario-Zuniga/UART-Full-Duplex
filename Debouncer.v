`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Mario Eugenio Zúñiga Carrillo
//////////////////////////////////////////////////////////////////////////////////

module Debouncer(
    input Clock,
    input Reset,
    input Switch,
    output reg One_Shot,
	 output reg Reset_Control
	 //output [3:0] Q
    );
	 
	 parameter [2:0] Ini  = 'b000;
	 parameter [2:0] Shot = 'b001;
	 parameter [2:0] Off1 = 'b011;
	 parameter [2:0] Sw_1 = 'b010;
	 parameter [2:0] Off2 = 'b110;
	 
	 wire Delay_End;
	 
	 reg [2:0] Status;
	 
	 always @ (posedge Reset, posedge Clock)
		
		begin
			if (Reset)
				Status <= Ini;
			else
			
				case (Status)
					Ini: if (Switch)
						Status <= Shot;
					else
						Status <= Ini; 
						
					Shot: Status <= Off1;
					
					Off1: if (Delay_End)
						Status <= Sw_1;
					else
						Status <= Off1;
						
					Sw_1: if (~Switch)
						Status <= Off2;
					else
						Status <= Sw_1;
						
					Off2: if (Delay_End)
						Status <= Ini;
					else
						Status <= Off2;
						
					default: Status <= Ini;
				endcase
				
		end
		
	always @ (Status)
		begin
			case (Status)
				Ini:  begin One_Shot = 'b0; Reset_Control = 'b0; end
				Shot: begin One_Shot = 'b1; Reset_Control = 'b0; end
				Off1: begin One_Shot = 'b0; Reset_Control = 'b1; end
				Sw_1: begin One_Shot = 'b0; Reset_Control = 'b0; end
				Off2: begin One_Shot = 'b0; Reset_Control = 'b1; end
				default: begin One_Shot = 'b0;  Reset_Control = 'b0; end
			endcase
		end
		
	Contador_Comparador CC(.clk(Clock), .rst(Reset), .enable(Switch), .iguales(Delay_End));
	
	//Contado_Decadas CC2 (.Clock(Clock), .Enable(One_Shot), .Reset(Reset), .Q(Q));
	
	

endmodule
