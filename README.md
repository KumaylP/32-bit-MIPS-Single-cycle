# 32-bit-MIPS-Single-cycle

To run this use commands
iverilog -o cpu_sim main.v single_cycle_tb.v
vvp cpu_sim
gtkwave single_cycle_cpu.vcd
