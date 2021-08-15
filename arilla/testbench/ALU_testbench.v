`timescale 20ns / 1ps

module al_tb();

reg in_a[31:0];
reg in_b[31:0];
reg op[4:0];

wire out_c[31:0];
wire aluout;

ALU dut (
	.A (in_a),
	.B (in_b),
	.op (op),
	.C (out_c),
	.zero (aluout)
);


initial begin
$monitor("A=%d, B=%d, op=%h, C=%d, zero=%b time=%3d\n",in_a, in_b, op, out_c, aluout, $time );
#1
in_a = 32'd10;
in_b = 32'd5;
op = 4'h1;
#2
op = 4'h2;
#3
op = 4'h3;
#4
op = 4'h4;
#5
op = 4'h5;
#6
op = 4'h6;
#7
op = 4'h7;
#8
op = 4'h8;
#9
op = 4'h9;
#10
op = 4'ha;
#11
op = 4'hb;
#12
op = 4'hc;
#13
op = 4'hd;
#14
op = 4'he;
#15
op = 4'hf;

end

endmodule 