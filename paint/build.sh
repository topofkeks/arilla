#!/bin/sh
set -e
$RISCV/bin/riscv32-unknown-linux-gnu-gcc -g -Wall -Wextra -march=rv32i -mabi=ilp32 -mstrict-align -nostdlib -ffreestanding -o paint.o colors.c gpu.c icons.c io.c main.c mouse.c peripheral.c
$RISCV/bin/riscv32-unknown-linux-gnu-objdump paint.o -D -s > paint.s
#python mif.py paint.s > paint.mif
