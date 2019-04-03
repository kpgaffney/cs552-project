module EX_MEM_reg(clk, rst, CtrlIn, PCAdd2In, WriteRegSelIn, ReadData2In, ALUOutIn, MSBIn, ZeroIn, PCImmAddIn, errIn, CtrlOut, PCAdd2Out, WriteRegSelOut, ReadData2Out, ALUOutOut, MSBOut, ZeroOut, PCImmAddOut, errOut);

	input clk, rst;
	input [15:0] CtrlIn;
	input [15:0] PCAdd2In;
	input [15:0] ReadData2In;
	input [15:0] ALUOutIn;
	input [15:0] PCImmAddIn;
	input MSBIn;
	input ZeroIn;
	input [2:0] WriteRegSelIn;
	input errIn;

	output [15:0] CtrlOut;
	output [15:0] PCAdd2Out;
	output [15:0] ReadData2Out;
	output [15:0] ALUOutOut;
	output [15:0] PCImmAddOut;
	output MSBOut;
	output ZeroOut;
	output [2:0] WriteRegSelOut;
	output errOut;

	wire Ctrl_err, PCAdd2_err, ReadData2_err, ALUOut_err, PCImmAdd_err, aux_err;
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

	register ReadData2_reg(
		.clk(clk),
		.rst(rst),
		.err(ReadData2_err),
		.writeData(ReadData2In),
		.readData(ReadData2Out),
		.writeEn(1'b1));

	register ALUOut_reg(
		.clk(clk),
		.rst(rst),
		.err(ALUOut_err),
		.writeData(ALUOutIn),
		.readData(ALUOutOut),
		.writeEn(1'b1));

	register PCImmAdd_reg(
		.clk(clk),
		.rst(rst),
		.err(PCImmAdd_err),
		.writeData(PCImmAddIn),
		.readData(PCImmAddOut),
		.writeEn(1'b1));

	register aux_reg(
		.clk(clk),
		.rst(rst),
		.err(aux_err),
		.writeData({10'b0, MSBIn, ZeroIn, WriteRegSelIn, errIn}),
		.readData(aux_reg_out),
		.writeEn(1'b1));

	assign MSBOut = aux_reg_out[5];

	assign ZeroOut = aux_reg_out[4];

	assign WriteRegSelOut = aux_reg_out[3:1];

	assign errOut = (Ctrl_err | PCAdd2_err | ReadData2_err | ALUOut_err | PCImmAdd_err | aux_err | aux_reg_out[0]) & ~rst;

endmodule