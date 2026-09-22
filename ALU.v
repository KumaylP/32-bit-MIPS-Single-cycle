module ALU(input [31:0] reg_A,input [31:0] reg_B,input [2:0]sel,output reg [31:0] out,output reg zero);

parameter ADD = 3'b010;
parameter SUB = 3'b110;
parameter AND = 3'b000;
parameter OR  = 3'b001;
parameter SLT = 3'b111; 



always @(*)begin
case (sel)
    ADD: out = reg_A + reg_B;
    SUB: out = reg_A - reg_B;
    AND: out = reg_A & reg_B;
    OR: out = reg_A | reg_B;
    SLT: out = (reg_A < reg_B) ? 1'b1 : 1'b0;

    default: out = 32'bz;
endcase; 

if(out == 0) begin
    zero = 1'b1;
end
else begin
    zero = 1'b0;
end

end

endmodule;