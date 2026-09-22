module MUX (
    input sel,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out
);

always @(*) begin
    case (sel)
        1'b0: out = in0;
        1'b1: out = in1;
        default: out = 32'bx;
    endcase
end

endmodule