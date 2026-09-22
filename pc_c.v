module PC_COUNTER (
    input [31:0]pc_in,
    output reg [31:0]pc_out,
    input clk

);

initial begin
    pc_out <= 32'h00000000;
end

always @(posedge clk) begin
    pc_out <= pc_in;
end
    
endmodule