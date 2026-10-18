`timescale 1ns/1ps

module alu4_tb;

reg[3:0] a,b;
reg[2:0] sel;
wire[3:0] y;
wire carry;

integer passed, failed;

alu4 dut (
.a(a),
.b(b),
.sel(sel),
.y(y),
.carry(carry)
);

task check;
input [2:0] operation;
input [3:0] expected;
input expected_carry;
begin
sel = operation;
#1;

if((y !== expected) || (carry !== expected_carry)) begin
$display("fail: sel=%b y=%b carry=%b", sel , y, carry);
failed = failed + 1;
end else begin
$display("pass: sel=%b y=%b carry=%b", sel, y, carry);
passed = passed + 1;
end 
end
endtask

initial begin
passed = 0;
failed = 0;
a = 4'd9;
b = 4'd3;
check(3'b000, 4'd12, 1'b0);
check(3'b001, 4'd6, 1'b0);
check(3'b010, 4'b0001, 1'b0);
check(3'b011, 4'b1011, 1'b0);
check(3'b100, 4'b1010, 1'b0);
check(3'b101, 4'b0110, 1'b0);
check(3'b110, 4'b0010, 1'b0);
check(3'b111, 4'b0100, 1'b0);
 $display("___________________________________");
$display("passed: %0d | failed: %0d", passed, failed);
 $display("___________________________________");
$finish;
end 
endmodule
