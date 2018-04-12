`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITES0
// Engineer: Cuauhtémoc Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////
module shift_register_er(
    input clk,
    input reset,
    input enable,
    input d,
    output reg [8:0] q
    );


always @(posedge reset, posedge clk)
	begin
		if (reset)
			q <= 0;
		else
			if (enable)
				q[8:0]<= {d,q[8:1]};
	end
	

endmodule
