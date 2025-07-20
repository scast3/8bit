parameter ALU_ADD = 3'b000
parameter ALU_SUB = 3'b001
parameter ALU_AND = 3'b010
parameter ALU_OR = 3'b011
parameter ALU_XOR = 3'b100
parameter ALU_NOT = 3'b100

module alu (
    input  wire [7:0] x,
    input  wire [7:0] y,
    input  wire [1:0] sel,    // Operation select
    output reg  [7:0] result, // Result
    output reg        zero    // Zero flag
);

always @(*) begin
    case (sel)
        2'b00: result = a + b;   // ADD
        2'b01: result = a - b;   // SUB
        2'b10: result = a & b;   // AND
        2'b11: result = a | b;   // OR
        default: result = 8'b0;
    endcase

    // Set zero flag
    zero = (result == 8'b0);
end

endmodule
