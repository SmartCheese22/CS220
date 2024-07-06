`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:11 04/10/2024
// Design Name: 
// Module Name:    MIPS_Processor 
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
`define FETCH 0
`define DECODE 1
`define REGFILE 2
`define EXECUTE 3
`define MEMORY 4
`define WRITE 5
`define FINAL 6
`define READ  2'b00
`define WRITE 2'b01
`define IDLE  2'b10

module state_change(clk, state, PC);
   	input clk;
   	input [7:0] PC;
	output reg [2:0] state;

	initial 
	   	state = `FETCH;
	
	always @ (posedge clk) begin
	   	if ((state == `WRITE) && (PC < 11)) begin
         		state <= `FETCH;
		end
		else if (state != `FINAL) begin
		   	state <= state + 1;
		end
	end
endmodule

module fetch(clk, state, PC, instr);
   	input clk;
	input [2:0] state;
	input [7:0] PC;
	output reg [31:0] instr;
	reg [31:0] stored_instruction [0:10];
	
	initial begin
		instr = 0;
		stored_instruction[0] = 32'b10001100000000010000000000000000;	
		stored_instruction[1] = 32'b10001100000000100000000000000001;	
		stored_instruction[2] = 32'b10001100000000110000000000000010;	
		stored_instruction[3] = 32'b00100100000001000000000000000000;
		stored_instruction[4] = 32'b00100100001001010000000000000000;
		stored_instruction[5] = 32'b00000000101000100011000000101010;
		stored_instruction[6] = 32'b00010000110000000000000000000101;
		stored_instruction[7] = 32'b00000000100001010010000000100001;
		stored_instruction[8] = 32'b00000000101000110010100000100001;
		stored_instruction[9] = 32'b00000000101000100011000000101010;
		stored_instruction[10] = 32'b00010100110000001111111111111101;
	end
	always @(posedge clk) begin
	   	if (state == `FETCH) begin
		   	instr <= stored_instruction[PC];
		end
	end
endmodule

module decode(clk, state, instr, opcode, rs, rt, rd, immediate, funct);
   	input clk;
	input [2:0] state;
	input [31:0] instr;
	output reg [5:0] opcode, funct;
	output reg [4:0] rs, rt, rd;
	output reg [15:0] immediate;
	
	always @ (posedge clk) begin
	   	if (state == `DECODE) begin
		   	opcode <= instr[31:26];
			rs <= instr[25:21];
			rt <= instr[20:16];
			rd <= instr[15:11];
			immediate <= instr[15:0];
			funct <= instr[5:0];
		end
	end
endmodule

module reg_file(clk, state, rs, rt, rd, result, isValid, rs_value, rt_value);
   	input clk;
	input [2:0] state;
	input [4:0] rs, rt, rd;
	input [7:0] result;
	input isValid;
	
	output reg [7:0] rs_value, rt_value;
	reg [7:0] register [0:31];
	
	initial begin
	   	register[0] = 0;
		register[1] = 0;
		register[2] = 0;
		register[3] = 0;
		register[4] = 0;
		register[5] = 0;
		register[6] = 0;
		register[7] = 0;
		register[8] = 0;
		register[9] = 0;
		register[10] = 0;
		register[11] = 0;
		register[12] = 0;
		register[13] = 0;
		register[14] = 0;
		register[15] = 0;
		register[16] = 0;
		register[17] = 0;
		register[18] = 0;
		register[19] = 0;
		register[20] = 0;
		register[21] = 0;
		register[22] = 0;
		register[23] = 0;
		register[24] = 0;
		register[25] = 0;
		register[26] = 0;
		register[27] = 0;
		register[28] = 0;
		register[29] = 0;
		register[30] = 0;
		register[31] = 0;
	end
	
	always @(posedge clk) begin
	   	if (state == `REGFILE) begin
		   	rs_value <= register[rs];
			rt_value <= register[rt];
		end
		else if ((state == `WRITE) && (rd != 0) && (isValid == 1)) begin
		   	register[rd] <= result;
		end
		else if (state == `FINAL) 
		   	rs_value <= register[4];
	end
endmodule

module execute(clk, state, opcode, rs_value, rt_value, immediate, funct, PC, result, isValid);
   	input clk;
	input [2:0] state;
	input [5:0] opcode, funct;
	input [7:0] rs_value, rt_value;
	input [15:0] immediate;
	
	output reg [7:0] result, PC;
	output reg isValid;
	initial begin
	   	isValid = 0;
		PC = 0;
	end
	
	always @ (posedge clk) begin
	   	if (state == `EXECUTE) begin
		   	if ((opcode == 6'b000000) && (funct == 6'b100001)) begin
			   	result <= rs_value + rt_value;
				PC <= PC + 1;
				isValid <= 1;
			end
			else if ((opcode ==  6'b000000) && (funct ==  6'b100011)) begin
			   	result <= (rs_value - rt_value);
				PC <= PC + 1;
				isValid <= 1;
			end
			else if ((opcode ==  6'b000000) && (funct ==  6'b101010)) begin
				if($signed(rs_value) < $signed(rt_value)) begin
				   	result <= 8'b00000001;
				end
				else begin
				   	result <= 8'b00000000;
				end
				isValid <= 1;
				PC <= PC + 1;
			end
			else if ((opcode == 6'b001001) || (opcode ==  6'b100011)) begin
			   	result <= rs_value + immediate[7:0];
				isValid <= 1;
				PC <= PC + 1;
			end
			else if (opcode ==  6'b000100) begin
				if (rs_value == rt_value) begin
				   	PC <= PC + immediate[7:0];
				end
				else begin
				   	PC <= PC + 1;
				end
				isValid <= 0;
			end
			else if (opcode ==  6'b000101) begin
				if (rs_value != rt_value) begin
				   	PC <= PC + immediate[7:0];
				end
				else begin
				   	PC <= PC + 1;
				end
				isValid <= 0;
			end
			else begin
			   	isValid <= 0;
				PC <= PC + 1;
			end
		end
	end
endmodule

module memory(clk, state, address, op, storev, loadv);
   	input clk;
	input [2:0] state;
	input [7:0] address, storev;
	input [1:0] op;
	
	output reg [7:0] loadv;
	reg [7:0] stored_Data [0:2];
	
	initial begin
	   	stored_Data[0] = 8'b11101100;	// a = -20
		stored_Data[1] = 8'b00001010;	// b = 10
		stored_Data[2] = 8'b00000010;	// c = 2
	end
	
	always @ (posedge clk) begin
	   	if (state == `MEMORY) begin
		   	if (op == `READ) begin
			   	loadv <= stored_Data[address];
			end
			else if (op == `WRITE) begin
			   	stored_Data[address] <= storev;
			end
		end
	end
endmodule

module MIPS_Processor(clk, led
	);
   	input clk;
	output reg[7:0] led;
	wire [7:0] PC, result, rs_value, rt_value, loadv;
	wire [2:0] state;
	wire [31:0] instr;
	wire [5:0] opcode, func;
	wire [4:0] rs, rt, rd;
	wire [15:0] immediate;
	wire isValid;

	state_change uut(clk, state, PC);
	fetch uut2(clk, state, PC, instr);
	decode uut3(clk, state, instr, opcode, rs, rt, rd, immediate, func);
	reg_file uut4(clk, state, rs, rt, (opcode == 6'b000000) ? rd : rt, (opcode == 6'b100011) ? loadv : result, (opcode == 6'b100011) ? 1'b1 : isValid, rs_value, rt_value);
	execute uut5(clk, state, opcode, rs_value, rt_value, immediate, func, PC, result, isValid);
	memory uut6(clk, state, result, (opcode == 6'b100011) ? `READ : `IDLE, rt_value, loadv);
	
	always @ (posedge clk) begin
	   	if (state == `FINAL) begin
		   	led <= rs_value;
		end
	end
endmodule