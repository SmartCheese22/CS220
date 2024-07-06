`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:19:59 01/31/2024
// Design Name:   comparator
// Module Name:   /users/btech/manyankg22/Desktop/CS220_Labs/Lab2_2/comparator/comparator_top.v
// Project Name:  comparator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module comparator_top;

	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg [3:0] y;

	
	wire l3;
	wire g3;
	wire e3;

	
	comparator uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.y(y), 
		.l3(l3), 
		.g3(g3), 
		.e3(e3)
	);

	always @(e3 or l3 or g3)
	 begin
		$display("time=%d: equal = %b, less = %b, greater = %b\n",$time,e3, l3, g3);   
	 end

		initial begin
			#20
			$finish;
		end
	 
	initial begin 
		PB1=1'b0;y[3:0]=4'b0000;PB1=1'b1;
		#2
		PB2=1'b0;y[3:0]=4'b1100;PB2=1'b1;
		#2
		PB3=1'b0;y[3:0]=4'b0000;PB3=1'b1;
		#2
		PB4=1'b0;y[3:0]=4'b0000;PB4=1'b1;
	end
      
endmodule
