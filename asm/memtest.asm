start:	li sp, 0x2010
	li a0, 10
	li a1, 20
	li a3, 30
	li a2, -100
	sb a0, -4(sp)
	sh a1, -8(sp)
	sw a2, -12(sp)
	sw a3, -16(sp)
	lb a4, -4(sp)
	lh a5, -8(sp)
	lw a6, -12(sp)
	lw a7, -16(sp)
	bne a0, a4, error
	bne a1, a5, error
	bne a2, a6, error
	bne a3, a7, error
	j start
error: fence 1,1
