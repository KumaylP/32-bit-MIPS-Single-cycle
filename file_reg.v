module file_reg (
    input clk,
    input [4:0] a1,
    input [4:0] a2,
    input [4:0] awr,
    input [31:0] wr,
    input wre,
    output [31:0] rd1,
    output [31:0] rd2
);

integer i ;

reg [31:0] regfile [0:31];
assign rd1 = regfile[a1];
assign rd2 = regfile[a2];

initial begin
    for (i = 0; i < 32; i = i + 1)
        regfile[i] = 32'd0;
end

always @(posedge clk) begin
    if (wre) begin
        regfile[awr] <= wr;
    end
end


endmodule
