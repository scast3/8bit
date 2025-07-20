`timescale 1ns / 1ps

parameter ALU_ADD = 3'b000
parameter ALU_SUB = 3'b001
parameter ALU_AND = 3'b010
parameter ALU_OR = 3'b011
parameter ALU_XOR = 3'b100
parameter ALU_NOT = 3'b100

module alu_tb;

    // Testbench signals
    reg  [7:0] a, b;
    reg  [1:0] sel;
    wire [7:0] result;
    wire       zero;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .sel(sel),
        .result(result),
        .zero(zero)
    );

    initial begin
        $display("Starting ALU Test...");

        // Test ADD
        a = 8'd10; b = 8'd5; sel = 2'b00;
        #10;
        $display("ADD: %d + %d = %d | zero = %b", a, b, result, zero);

        // Test SUB (non-zero)
        a = 8'd10; b = 8'd3; sel = 2'b01;
        #10;
        $display("SUB: %d - %d = %d | zero = %b", a, b, result, zero);

        // Test SUB (zero)
        a = 8'd7; b = 8'd7; sel = 2'b01;
        #10;
        $display("SUB: %d - %d = %d | zero = %b", a, b, result, zero);

        // Test AND
        a = 8'b10101010; b = 8'b11001100; sel = 2'b10;
        #10;
        $display("AND: %b & %b = %b | zero = %b", a, b, result, zero);

        // Test OR
        a = 8'b00001111; b = 8'b11110000; sel = 2'b11;
        #10;
        $display("OR: %b | %b = %b | zero = %b", a, b, result, zero);

        $display("ALU Test complete.");
        $finish;
    end

endmodule
