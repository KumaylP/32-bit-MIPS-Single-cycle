module control (
    input [5:0]opcode,
    input [5:0]funct,
    output reg [2:0]ALU_cntrl,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemWrite,
    output reg Branch,
    output reg jump
    

);
reg [1:0]ALUOp;


always @(*) begin
    case (opcode)
        6'b000000: begin // R-type
            RegDst = 1;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b10;
            jump = 0; // ALU operation determined by funct field
        end
        6'b100011: begin // lw
            RegDst = 0;
            ALUSrc = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
            jump = 0; // add for address calculation
        end
        6'b101011: begin // sw
            RegDst = 'bx; // don't care
            ALUSrc = 1;
            MemtoReg = 'bx; // don't care
            RegWrite = 0;
            MemWrite = 1;
            Branch = 0;
            ALUOp = 2'b00; 
            jump = 0;// add for address calculation
        end
        6'b000100: begin // beq
            RegDst = 'bx; // don't care
            ALUSrc = 0;
            MemtoReg = 'bx; // don't care
            RegWrite = 0;
            MemWrite = 0;
            Branch = 1;
            ALUOp = 2'b01; // subtract for comparison
            jump = 0;
        end
        6'b001000: begin // addi
            RegDst = 0;
            ALUSrc = 1;
            MemtoReg = 0;
            RegWrite = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
            jump = 0; // add for immediate addition
        end
        6'b000010: begin // j
            RegDst = 'bx; // don't care
            ALUSrc = 'bx; // don't care
            MemtoReg = 'bx; // don't care
            RegWrite = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 'bx;
            jump = 1; // don't care
        end

        default: begin // default case for unrecognized opcodes
            RegDst = 'bx; // don't care
            ALUSrc = 'bx; // don't care
            MemtoReg = 'bx; // don't care
            RegWrite = 'bx; // don't care
            MemWrite = 'bx; // don't care
            Branch = 'bx; // don't care
            ALUOp = 'bx;
            jump = 'bx; // don't care
        end
    endcase

    ALU_cntrl = (ALUOp == 2'b00) ? 3'b010 : // add for lw/sw
                 (ALUOp == 2'b01) ? 3'b110 : // subtract for beq
                 3'bxxx; // undefined ALUOp


    if((ALUOp == 2'b11) || (ALUOp == 2'b10) ) 
    begin
        case(funct)
            6'b100000: ALU_cntrl = 3'b010; // add
            6'b100010: ALU_cntrl = 3'b110; // subtract
            6'b100100: ALU_cntrl = 3'b000; // and
            6'b100101: ALU_cntrl = 3'b001; // or
            6'b101010: ALU_cntrl = 3'b111; // set on less than
            default: ALU_cntrl = 3'bxxx; // undefined funct
        endcase
    end



end
    
endmodule