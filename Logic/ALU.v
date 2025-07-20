module alu (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] op,
    output reg  [7:0] result,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow 
);
parameter ALU_ADD = 3'b000;
parameter ALU_SUB = 3'b001;
parameter ALU_AND = 3'b010;
parameter ALU_OR = 3'b011;
parameter ALU_XOR = 3'b100;
parameter ALU_NOT = 3'b101;
parameter ALU_SHL = 3'b110;
parameter ALU_SHR = 3'b111;

always @(*) begin
    carry = 0;
    overflow = 0;
    result = 8'b0;
    case (op)
        ALU_ADD: begin
            {carry, result} = a + b;
            overflow = (~a[7] & ~b[7] & result[7]) | (a[7] & b[7] & ~result[7]);
        end
        ALU_SUB: begin
            {carry, result} = a - b;
            // carry = (x < y); // carry = borrow
            overflow = (~a[7] & ~b[7] & result[7]) | (a[7] & b[7] & ~result[7]);
        end
        ALU_AND: result = a & b;
        ALU_OR: result = a | b;
        ALU_XOR: result = a ^ b;
        ALU_NOT: result = ~a;
        ALU_SHL: begin
            result = a << 1;
            carry = a[7]; // carry out from MSB
        end
        ALU_SHR: begin
            result = a >> 1;
            carry = a[0]; // carry out from LSB
        end
        default: result = 8'b0;
    endcase

    zero = (result == 8'b0);
    negative = result[7];
end

endmodule
