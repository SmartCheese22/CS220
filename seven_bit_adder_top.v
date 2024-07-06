`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:34:39 01/31/2024
// Design Name:   seven_bit_adder
// Module Name:   /users/btech/manyankg22/Desktop/CS220_Labs/Lab2_2/seven_bit_adder/seven_bit_adder_top1.v
// Project Name:  seven_bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: seven_bit_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module seven_bit_adder_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg [3:0] Y;

	// Outputs
	wire [6:0] sum;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	seven_bit_adder uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.Y(Y), 
		.sum(sum), 
		.carry(carry)
	);

	always @(PB1 or PB2 or PB3 or PB4) begin
	$display("time=%d: %b %b %b %b sum=%b, carry = %b\n", $time, PB2,PB1 ,PB4,PB3, sum, carry);
	end
	initial begin
	PB1=1; Y=4'b0000;
	#5
	PB2=1; Y=4'b0010; 
	#5
	PB3=1; Y=4'b0000;
	#5
	PB4=1; Y=4'b0000; 
	#5

	
	$finish;
	end
      
endmodule
