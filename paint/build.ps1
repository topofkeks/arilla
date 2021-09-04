wsl /home/lazar/riscv/bin/riscv32-unknown-linux-gnu-gcc -g -Wall -Wextra -march=rv32i -mabi=ilp32 -mstrict-align -nostdlib -ffreestanding -o paint.o gpu.c io.c main.c mouse.c peripheral.c font.c
wsl /home/lazar/riscv/bin/riscv32-unknown-linux-gnu-objdump paint.o -D -s > paint.s
..\tools\SRAMMifgen\SRAMMifgen.exe paint.s paint.mif -bootstrap
