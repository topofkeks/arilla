	li sp, 0x1000
main:
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        li      a5,1
        sw      a5,-20(s0)
        li      a5,-32
        sw      a5,-24(s0)
        lw      a5,-20(s0)
        slli    a5,a5,2
        sw      a5,-28(s0)
        lw      a5,-24(s0)
        srai    a5,a5,1
        sw      a5,-32(s0)
        lw      a5,-24(s0)
        srli    a5,a5,1
        sw      a5,-36(s0)
 #APP
# 8 "/app/example.c" 1
        fence.i
# 0 "" 2
 #NO_APP
        nop
        lw      s0,44(sp)
        addi    sp,sp,48
        jr      ra