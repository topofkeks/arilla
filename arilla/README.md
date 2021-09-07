# Arilla RISC-V Core
This is the Quartus project for the RISC-V CPU made for Arilla, and the top-level architecture connecting the CPU to peripherals using a bus.

## Bus architecture
The Arilla bus has the following lines:
- <code>DATA<sub>31..0</sub></code>: 32-bit wide data sent from the CPU to peripherals (during a write operation) or from peripherals to the CPU (during a read operation)
- <code>ADDR<sub>31..0</sub></code>: Address of the peripheral register or memory we are accessing.
    - `0x0XXXXXXX` addresses are reserved for the SRAM
    - `0x1XXXXXXX` addresses are reserved for the mouse controller
    - `0x2XXXXXXX` addresses are reserved for the GPU
- `RD`: Set to 1 when the CPU is performing a read operation
- `WR`: Set to 1 when the CPU is performing a write operation

## Documentation
- [RISC-V cheatsheet](https://metalcode.eu/2019-12-06-rv32i.html)
- [RISC-V specification](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf)
