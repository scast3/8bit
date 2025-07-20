`timescale 1ns / 1ps

module alu_tb;

    // Testbench signals
    reg  [7:0] a, b;
    reg  [2:0] op;
    wire [7:0] result;
    wire zero;
    wire negative;
    wire carry;

    parameter ALU_ADD = 3'b000;
    parameter ALU_SUB = 3'b001;
    parameter ALU_AND = 3'b010;
    parameter ALU_OR = 3'b011;
    parameter ALU_XOR = 3'b100;
    parameter ALU_NOT = 3'b101;
    parameter ALU_SHL = 3'b110;
    parameter ALU_SHR = 3'b111;
    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero(zero),
        .negative(negative),
        .overflow(overflow),
        .carry(carry)
    );

    initial begin
        $display("Starting ALU Test...");

        // Test ADD
        a = 8'd10; b = 8'd5; op = 3'b000;
        #10;
        $display("ADD: %d + %d = %d | z=%b n=%b c=%b v=%b", a, b, result, zero, negative, carry, overflow);

        // Edge case: Unsigned carry
        a = 8'd255; b = 8'd1; op = 3'b000;
        #10;
        $display("ADD Overflow (carry): %d + %d = %d | z=%b n=%b c=%b v=%b", a, b, result, zero, negative, carry, overflow);

        // Edge case: Signed overflow
        a = 8'd127; b = 8'd1; op = 3'b000;
        #10;
        $display("ADD Overflow (signed): %d + %d = %d | z=%b n=%b c=%b v=%b", a, b, result, zero, negative, carry, overflow);

        // Test SUB
        a = 8'd15; b = 8'd10; op = 3'b001;
        #10;
        $display("SUB: %d - %d = %d | z=%b n=%b c=%b v=%b", a, b, result, zero, negative, carry, overflow);

        // Edge case: SUB with negative result
        a = 8'd10; b = 8'd15; op = 3'b001;
        #10;
        $display("SUB Negative: %d - %d = %d | z=%b n=%b c=%b v=%b", a, b, result, zero, negative, carry, overflow);

        // Test AND
        a = 8'b10101010; b = 8'b11001100; op = 3'b010;
        #10;
        $display("AND: %b & %b = %b", a, b, result);

        // Test OR
        a = 8'b10101010; b = 8'b01010101; op = 3'b011;
        #10;
        $display("OR: %b | %b = %b", a, b, result);

        // Test XOR
        a = 8'b11110000; b = 8'b00001111; op = 3'b100;
        #10;
        $display("XOR: %b ^ %b = %b", a, b, result);

        // Test NOT (y is ignored)
        a = 8'b00000000; b = 8'b11111111; op = 3'b101;
        #10;
        $display("NOT: ~%b = %b", a, result);

        a = 8'b11111111; op = 3'b101;
        #10;
        $display("NOT: ~%b = %b", a, result);

        // Test SHL
        a = 8'b00000001; op = 3'b110;
        #10;
        $display("SHL: %b << 1 = %b", a, result);

        a = 8'b10000000; op = 3'b110;
        #10;
        $display("SHL with carry: %b << 1 = %b", a, result);

        // Test SHR
        a = 8'b10000000; op = 3'b111;
        #10;
        $display("SHR: %b >> 1 = %b", a, result);

        a = 8'b00000001; op = 3'b111;
        #10;
        $display("SHR with LSB loss: %b >> 1 = %b", a, result);

        $display("ALU Test Completed.");
        $stop;
    end

endmodule
