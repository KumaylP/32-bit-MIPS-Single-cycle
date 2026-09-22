`timescale 1ns/1ps

module single_cycle_cpu_tb;

    reg clk;
    reg reset;

    // Instantiate CPU
    single_cycle_cpu uut (
        .clk(clk),
        .reset(reset)
    );

    // --------------------------------
    // Clock generation
    // 10 ns period
    // --------------------------------

    always #5 clk = ~clk;


    // --------------------------------
    // Test
    // --------------------------------

    initial begin

        // Waveform
        $dumpfile("single_cycle_cpu.vcd");
        $dumpvars(0, single_cycle_cpu_tb);

        // Initial values
        clk   = 0;
        reset = 1;
        

        // Reset CPU
        #10;

        reset = 0;

        // Let CPU execute instructions
        #10000;

        // Display results
        $display("--------------------------------");
        $display("Simulation finished");
        $display("--------------------------------");

        $display("PC       = %h", uut.pc_current);
        $display("Instruction = %h", uut.instruction);

        $display("Register 8  ($t0) = %d",
                 uut.reg_file.regfile[8]);

        $display("Register 9  ($t1) = %d",
                 uut.reg_file.regfile[9]);

        $display("Register 10 ($t2) = %d",
                 uut.reg_file.regfile[10]);

        $display("Memory[1] = %d",
                 uut.data_memory.mem[1]);

        $display("--------------------------------");

        $finish;

    end

endmodule