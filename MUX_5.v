module MUX_5 (
    input sel,
    input [4:0] in0,
    input [4:0] in1,
    output reg [4:0] out
);

always @(*) begin
    case (sel)
        1'b0: out = in0;
        1'b1: out = in1;
        default: out = 5'bx;
    endcase
end

endmodule