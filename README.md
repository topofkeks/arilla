# Arilla
Arilla - Computer Architecture project, spring 2021.

## Best practices
The following are best practices when developing components for Arilla - they allow easier simulation through ModelSim and make development more consistent:
- Single bit constant signals should not be named `0` and `1`, but `zero` and `one` instead.
    - `0` and `1` are reserved VHDL characters.
- Signals should not be named `IN` or `OUT`, but `I` and `O`.
    - Similarly to the above.
- Identifiers must begin with a letter and should end with a letter (ending with a digit is allowed but discouraged).
- When generating components, generate them in the `components` folder from the `components` project and make sure they are included in that project.
- Generate megafunctions using VHDL and only generate required files (`.vhd` and `.bsf`).
- Microcode memory initialization (`.mif`) files should be placed in the `mic` folder while `.vhd` asynchronous ROM files belong to folder of the project in which they are used.
