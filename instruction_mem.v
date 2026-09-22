module instr_mem (
    input clk,
    input [31:0] a,
    output [31:0] rd
);

reg [31:0] mem [0:1023];
initial begin
    $readmemh("mem.hex", mem);
            end
assign rd = mem[a>>2];
 

endmodule