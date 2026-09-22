`timescale 1ns/1ps

module control_tb;

    // Inputs
    reg [5:0] opcode;
    reg [5:0] funct;

    // Outputs
    wire [2:0] ALU_cntrl;
    wire RegDst;
    wire ALUSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemWrite;
    wire Branch;

    // Instantiate DUT
    control uut (
        .opcode(opcode),
        .funct(funct),
        .ALU_cntrl(ALU_cntrl),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .Branch(Branch)
    );

   initial begin

    $dumpfile("control.vcd");
    $dumpvars(0, control_tb);

    // R-type ADD
    opcode = 6'b000000;
    funct  = 6'b100000;
    #10;

    // R-type SUB
    opcode = 6'b000000;
    funct  = 6'b100010;
    #10;

    // LW
    opcode = 6'b100011;
    funct  = 6'b000000;
    #10;

    // SW
    opcode = 6'b101011;
    funct  = 6'b000000;
    #10;

    // BEQ
    opcode = 6'b000100;
    funct  = 6'b000000;
    #10;

    // ADDI
    opcode = 6'b001000;
    funct  = 6'b000000;
    #10;

    // J
    opcode = 6'b000010;
    funct  = 6'b000000;
    #10;

    $finish;
end

endmodule