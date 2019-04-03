module MEM_WB_reg(clk, rst, CtrlIn, PCAdd2In, WriteRegSelIn, ALUOutIn, DMemDataIn, errIn, CtrlOut, PCAdd2Out, WriteRegSelOut, ALUOutOut, DMemDataOut, errOut);

	input clk, rst;
	input [15:0] CtrlIn;
	input [15:0] PCAdd2In;
	input [15:0] ALUOutIn;
	input [15:0] DMemDataIn;
	input [2:0] WriteRegSelIn;
	input errIn;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [15:0] ALUOutOut;
	output [15:0] DMemDataOut;
	output [2:0] WriteRegSelOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ALUOut_err, DMemData_err, aux_err;
	wire [15:0] aux_reg_out;

	register Ctrl_reg(
		.clk(clk),
		.rst(rst),
		.err(Ctrl_err),
		.writeData(CtrlIn),
		.readData(CtrlOut),
		.writeEn(1'b1));

	register PCAdd2_reg(
		.clk(clk),
		.rst(rst),
		.err(PCAdd2_err),
		.writeData(PCAdd2In),
		.readData(PCAdd2Out),
		.writeEn(1'b1));

	register ALUOut_reg(
		.clk(clk),
		.rst(rst),
		.err(ALUOut_err),
		.writeData(ALUOutIn),
		.readData(ALUOutOut),
		.writeEn(1'b1));

	register DMemData_reg(
		.clk(clk),
		.rst(rst),
		.err(DMemData_err),
		.writeData(DMemDataIn),
		.readData(DMemDataOut),
		.writeEn(1'b1));

	register aux_reg(
		.clk(clk),
		.rst(rst),
		.err(aux_err),
		.writeData({12'b0, WriteRegSelIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(1'b1));

	assign WriteRegSelOut = aux_reg_out[3:1];

	assign errOut = (Ctrl_err | PCAdd2_err | ALUOut_err | DMemData_err | aux_err | aux_reg_out[0]) & ~rst;

endmodule