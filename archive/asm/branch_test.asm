start:	li a0, 20	# 0 4 8 14 18 10 1c 20 0
	li a1, 30
	bne a0, a1, second
	j error
first:	bgeu a3, a0, fourth
second:	li a3, -20
	bge a0, a3, first
fourth:	add a4, a3, a0
	beq x0, a4, start
error:	fence 1,1
