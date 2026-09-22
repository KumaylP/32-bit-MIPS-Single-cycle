`include "control.v"
`include "file_reg.v"
`include "sign_extend.v"
`include "ALU.v"
`include "data_mem.v"
`include "instruction_mem.v"
`include "pc_c.v"
`include "mux.v"
`include "MUX_5.v"



module single_cycle_cpu (
    input clk,
    input reset
);
wire [31:0] pc_current;
wire [31:0] pc_next, pc_plus4, instruction, read_data1, read_data2, sign_imm, alu_result, mem_read_data;
wire [4:0] write_reg;
wire [2:0] alu_control;
wire RegDst, ALUSrc, MemtoReg,jump, RegWrite, MemWrite, Branch;
wire zero;
wire [31:0] alu_input2;
wire [31:0] pc_next_final,mem_read_data_final;



PC_COUNTER pc_counter (
    .pc_in(pc_next_final),
    .pc_out(pc_current),
    .clk(clk)
);


assign pc_plus4 = pc_current + 32'd4;

instr_mem instr_mem (
    .a(pc_current),
    .rd(instruction)
);



control control_unit (
    .opcode(instruction[31:26]),
    .funct(instruction[5:0]),
    .ALU_cntrl(alu_control),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .jump(jump)
);

file_reg reg_file (
    .clk(clk),
    .wre(RegWrite),
    .awr(write_reg),
    .a1(instruction[25:21]),
    .a2(instruction[20:16]),
    .wr(mem_read_data_final),
    .rd1(read_data1),
    .rd2(read_data2)
);

sign_extend sign_extend_inst (
    .in(instruction[15:0]),
    .out(sign_imm)
);

// some pc branching logic
wire [31:0] branch_target = pc_plus4 + (sign_imm << 2);
wire [31:0] jump_target = {pc_plus4[31:28], instruction[25:0], 2'b00};
MUX_5 mux_wr(
    .sel(RegDst),
    .in0(instruction[20:16]),
    .in1(instruction[15:11]),
    .out(write_reg)
);

//jump

MUX mux_alu_src(
    .sel(ALUSrc),
    .in0(read_data2),
    .in1(sign_imm),
    .out(alu_input2)
);


ALU alu_unit (
    .reg_A(read_data1),
    .reg_B(alu_input2),
    .sel(alu_control),
    .out(alu_result),
    .zero(zero)
);


data_mem data_memory (
    .clk(clk),
    .a(alu_result),
    .wr(read_data2),
    .wre(MemWrite),
    .rd(mem_read_data)
);

MUX result_mux(
    .sel(MemtoReg),
    .in0(alu_result),
    .in1(mem_read_data),
    .out(mem_read_data_final)
);
MUX branch_mux(
    .sel(Branch & zero),
    .in0(pc_plus4),
    .in1(branch_target),
    .out(pc_next)
);

MUX jump_mux(
    .sel(jump),
    .in0(pc_next),
    .in1(jump_target),
    .out(pc_next_final)
);


endmodule;