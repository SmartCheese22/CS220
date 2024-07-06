`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:55 01/31/2024 
// Design Name: 
// Module Name:    comparator 
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
module compare_bit(a,b,l1,g1,e1,l2,g2,e2);

input a;
input b;
input l1;
input g1;
input e1;

output l2;
wire l2;
output g2;
wire g2;
output e2;
wire e2;

assign g2=(g1|((e1 & ~b & a)));
assign l2=(l1|((e1 & b & ~a)));
assign e2=(e1 & ((a & b )|(~a & ~b)));

endmodule
	
module comparator(PB1,PB2,PB3,PB4,y,l3,g3,e3);

input PB1;
input PB2;
input PB3;
input PB4;
input [3:0]y;
reg [7:0]a;
reg [7:0]b;
output l3;
output g3;
output e3;
wire l3;
wire g3;
wire e3;
wire [6:0]l;

wire [6:0]g;

wire [6:0]e;


always @(posedge PB1) begin
	a[3:0] <= y[3:0];
end
always @(posedge PB2) begin
	a[7:4] <= y[3:0];
end
always @(posedge PB3) begin
	b[3:0] <=y[3:0];
end
always @(posedge PB4) begin
	b[7:4] <= y[3:0];
end


compare_bit CB0 (a[7],b[7],1'b0,1'b0,1'b1,l[6],g[6],e[6]);
compare_bit CB1 (a[6],b[6],l[6],g[6],e[6],l[5],g[5],e[5]);
compare_bit CB2 (a[5],b[5],l[5],g[5],e[5],l[4],g[4],e[4]);
compare_bit CB3 (a[4],b[4],l[4],g[4],e[4],l[3],g[3],e[3]);
compare_bit CB4 (a[3],b[3],l[3],g[3],e[3],l[2],g[2],e[2]);
compare_bit CB5 (a[2],b[2],l[2],g[2],e[2],l[1],g[1],e[1]);
compare_bit CB6 (a[1],b[1],l[1],g[1],e[1],l[0],g[0],e[0]);
compare_bit CB7 (a[0],b[0],l[0],g[0],e[0],l3,g3,e3);



endmodule
