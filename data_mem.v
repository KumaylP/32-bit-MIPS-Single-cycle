module data_mem (
    input clk,
    input [31:0] a,
    input [31:0] wr,
    input wre,
    output [31:0] rd

);

reg [31:0] mem [0:1023];
assign rd = (wre)?32'h00000000:mem[a];

always @(posedge clk) begin
    if (wre) begin
        mem[a] <= wr;
    end
end


endmodule