`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:26 01/31/2024 
// Design Name: 
// Module Name:    seven_bit_adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module full_adder(a, b, c, sum, cout
);
input a;
input b;
input c;
output sum;
wire sum;
output cout;
wire cout;
assign sum = a^b^c;
assign cout = (a & b) | (b & c) | (c & a);
endmodule

module seven_bit_adder(PB1,PB2,PB3,PB4,Y,sum,carry
    );
	input PB1,PB2,PB3,PB4;
	input [3:0] Y;
	
	output[6:0] sum;
	output carry;
	wire [6:0] sum;
	wire carry;
	wire d[5:0];
	reg [6:0] a;
	reg [6:0] b;
	always @(posedge PB1)begin
		a[3:0]<=Y;
	end
	always @(posedge PB2)begin
		a[6:4]<=Y[2:0];
	end
	always @(posedge PB3)begin
		b[3:0]<=Y;
	end
	always @(posedge PB4)begin
		b[6:4]<=Y[2:0];
	end
	full_adder FA0 (a[0], b[0], 1'b0, sum[0], d[0]);
	full_adder FA1 (a[1], b[1], d[0], sum[1], d[1]);
	full_adder FA2 (a[2], b[2], d[1], sum[2], d[2]);
	full_adder FA3 (a[3], b[3], d[2], sum[3], d[3]);
	full_adder FA4 (a[4], b[4], d[3], sum[4], d[4]);
	full_adder FA5 (a[5], b[5], d[4], sum[5], d[5]);
	full_adder FA6 (a[6], b[6], d[5], sum[6], carry);
	

endmodule
