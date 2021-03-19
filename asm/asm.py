#!/usr/bin/env python
from argparse import ArgumentParser, Namespace
from typing import Dict, List, Literal, Tuple, Union
import re

Unresolved = Union[str, int]
Addressing = Literal['immed', 'memdir', 'memind', 'regind', 'regdir']
Operand = Tuple[Addressing, int]
OperandUnresolved = Tuple[Addressing, Unresolved]
Instruction = Tuple[int, int]

parser: ArgumentParser = ArgumentParser(description='Asembler za AR3B72C procesor.')
parser.add_argument('asm_file', type=str, help='datoteka sa izvornim asemblerskim kodom')
parser.add_argument('--binary', help='ispis instrukcija u binarnim ciframa', action='store_true')
# parser.add_argument('--pretty', help='štampa novi red na kraju instrukcije', action='store_true')
# parser.add_argument('--v3hex', help='štampa u v3.0 hex words addressed formatu, za Logisim', action='store_true')
args: Namespace = parser.parse_args()

instructions: Dict[int, List[Tuple[str, List[OperandUnresolved], int]]] = {}
iv_table: List[str] = ['fault', 'mouse', 'trap']
iv_table_address: int = 0
data: Dict[int, List[int]] = {
    iv_table_address: []
}
instruction_defs: Dict[str, Instruction] = {
    # WIP
    'HALT': (0, 0),
    'RTS': (1, 0),
    'RTI': (2, 0),
    'TRPE': (2, 0),
    'TRPD': (2, 0),
    'BZ': (3, 1),
    'B': (4, 1),
    'BSR': (5, 1),
    'JREG': (6, 1),
    'PUSH': (8, 1),
    'POP': (9, 1),
    'ADD': (10, 2),
    'SUB': (11, 2),
    'CMP': (12, 2),
    'OR': (13, 2),
    'AND': (14, 2),
    'LDR': (15, 2),
    # Zahtevaju dve reči
    'LD': (32, 2), # Može da se konvertuje u LDR
    'ST': (33, 2),
    'JZ': (34, 1),
    'JMP': (35, 1),
    'JSR': (35, 1)
}
labels: Dict[str, int] = {}
adrcodes: List[Addressing] = ['immed', 'memdir', 'memind', 'regind', 'regdir']

pc: int = 0
org: int = 0

def is_two_words(instruction: str) -> bool:
    return (instruction_defs[instruction][0] & 0b100000) != 0

def is_memdir(instruction: str) -> bool:
    return instruction.startswith('J') or instruction.startswith('B')

def is_load_store(instruction: str):
    return instruction == 'LD' or instruction == 'ST'

def parse_number(number: str) -> Unresolved:
    try:
        value: int = 0
        if number.endswith('h'):
            value = int(number[0:-1], 16)
        elif number.endswith('b'):
            value = int(number[0:-1], 2)
        elif number.endswith('o'):
            value = int(number[0:-1], 8)
        else:
            value = int(number, 10)
        assert -2**15 <= value < 2**15, f'Vrednost adrese/podatka van dozvoljenog opsega: {number}'
        return value
    except ValueError:
        # Labela
        return number

def resolve_label(label: Unresolved) -> int:
    global labels
    if isinstance(label, int):
        return label
    assert label in labels, f'Labela mora biti definisana: {label}'
    return labels[label]

def parse_and_resolve_number(number: str) -> int:
    return resolve_label(parse_number(number))

def parse_operand(operand: str) -> OperandUnresolved:
    operand = operand.strip()
    if operand.startswith('#'):
        return ('immed', parse_number(operand[1:]))
    indir: bool = False
    if operand.startswith('(') and operand.endswith(')'):
        operand = operand[1:-1]
        indir = True
    if operand.startswith('R') or operand.startswith('r'):
        try:
            regnum: int = int(operand[1:])
            assert 0 <= regnum < 32, f'Broj registra van dozvoljenog opsega: {operand}'
            return (indir and 'regind' or 'regdir', regnum)
        except ValueError:
            # Ovo nije bio registar nego labela koja počinje sa R
            pass
    return (indir and 'memind' or 'memdir', parse_number(operand))

def handle_macro(operand: str, args: str) -> None:
    global org, pc, data, labels
    if operand == 'ORG':
        pc = parse_and_resolve_number(args)
        assert 0 <= pc < 2**18, f'PC ne može da bude veći od veličine adrese, data vrednost {args}'
        org = pc
    elif operand == 'DATA':
        size, data_bytes = [parse_and_resolve_number(arg) for arg in args.split(',', 1)]
        byte_split = data_bytes.to_bytes(size * 2, 'big', signed=True)
        if org not in data:
            data[org] = []
        for i in range(size):
            data[org].append(byte_split[i * 2] << 8 + byte_split[i * 2 + 1])
    elif operand == 'LABEL':
        label, contents = args.split(',', 1)
        label: str = label.strip()
        label_contents: int = parse_and_resolve_number(contents.strip())
        assert label not in labels, f'Opet se definiše labela: {label}'
        assert 0 <= label_contents < 2**18, f'Sadržaj labele ne može da bude veći od veličine adrese, data vrednost {contents}'
        labels[label] = label_contents
    else:
        print('Ne postoji makro:', operand)
        exit(1)

def format_binary(num: int, width: int) -> str:
    fmt: str = '{:0' + str(width) + 'b}'
    return fmt.format(num)

def format_hex(num: int, width: int) -> str:
    fmt: str = '{:0' + str(width) + 'x}'
    return fmt.format(num).upper()

# Faza parsiranja instrukcija i ekspanzije makroa
with open(args.asm_file, 'r', encoding='utf-8') as asm_file:
    for line in asm_file:
        line: str = line.split(';', 1)[0].strip()
        if line == '':
            # Prazna linija
            continue
        line_split: List[str] = line.split(':', 1)
        if len(line_split) == 2:
            label = line_split[0].strip()
            line = line_split[1].strip()
            assert label not in labels, f'Opet se definiše labela: {label}'
            labels[label] = pc
        line_split: List[str] = line.strip().split(' ', 1)
        instruction = line_split[0].strip().upper()
        if instruction.startswith('.'):
            handle_macro(instruction[1:], line_split[1].strip())
            continue
        assert instruction in instruction_defs, f'Instrukcija ne postoji: {instruction}'
        operands_unresolved: List[OperandUnresolved] = []
        if len(line_split) == 2:
            for operand in line_split[1].split(','):
                operands_unresolved.append(parse_operand(operand))
        operand_count = instruction_defs[instruction][1]
        # Optimizacija
        if operand_count == 2 and operands_unresolved[0][0] == 'regdir' and operands_unresolved[1][0] == 'regdir':
            if instruction == 'LD':
                instruction = 'LDR'
            elif instruction == 'ST':
                instruction = 'LDR'
                operands_unresolved[0], operands_unresolved[1] = operands_unresolved[1], operands_unresolved[0]
        # Validacija
        assert len(operands_unresolved) == operand_count, f'Pogrešan broj operanada instrukcije: {line}'
        if is_memdir(instruction):
            assert operands_unresolved[0][0] == 'memdir', f'Instrukcije skoka i grananja moraju da koriste memorijsko direktno adresiranje: {line}'
        elif operand_count != 0:
            assert operands_unresolved[0][0] == 'regdir', f'Prvi operand mora biti registar: {line}'
            if not is_load_store(instruction) and operand_count == 2:
                assert operands_unresolved[0][0] == 'regdir', f'Drugi operand mora biti registar: {line}'
        if org not in instructions:
            instructions[org] = []
        if is_two_words(instruction):
            pc += 2
        else:
            pc += 1
        instructions[org].append((instruction, operands_unresolved, pc))

# Faza razrešavanja labela i generisanja podataka
for adr, instruction_list in instructions.items():
    if adr not in data:
        data[adr] = []
    for (instruction, operands_unresolved, curr_pc) in instruction_list:
        opcode: int = instruction_defs[instruction][0]
        # O - operacioni kod (6b)
        # R - registar (5b)
        # A - način adresiranja (3b)
        # M - adresa u memoriji kod instrukcija skoka
        # J - relativan pomeraj kod instrukcija grananja
        # X - ne koristi se
        if is_load_store(instruction):
            # OOOOOORR|RRRAAAMM MMMMMMMM|MMMMMMMM
            assert isinstance(operands_unresolved[0][1], int), 'Vrednost pri registarskom direktnom adresiranju je labela (ovo ne bi trebalo da se desi)'
            reg: int = operands_unresolved[0][1]
            adrname, op2_unresolved = operands_unresolved[1]
            adrcode: int = adrcodes.index(adrname)
            op2: int = resolve_label(op2_unresolved)
            data[adr].append(((((opcode << 5) + reg) << 3) + adrcode) << 2 + (op2 >> 16))
            data[adr].append(op2 % 2**16)
        elif is_two_words(instruction):
            # 000000XX|XXXXXXMM MMMMMMMM|MMMMMMMM
            op1: int = resolve_label(operands_unresolved[0][1])
            data[adr].append((opcode << 8) + (op1 >> 16))
            data[adr].append(op1 % 2**16)
        elif is_memdir(instruction):
            # OOOOOOJJ|JJJJJJJJ
            op1: int = resolve_label(operands_unresolved[0][1]) - curr_pc
            assert -2**9 <= op1 < 2**9, f'Operator {op1} instrukcije grananja je preveliki'
            byte1, byte2 = op1.to_bytes(2, 'big', signed=True)
            data[adr].append((((byte1 & 0b00000011) + (opcode << 2)) << 8) + byte2)
        else:
            # 000000RR|RRRRRRRR, 000000RR|RRRXXXXX ili OOOOOOXX|XXXXXXXX
            reg1: int = 0
            reg2: int = 0
            if len(operands_unresolved) > 0:
                assert isinstance(operands_unresolved[0][1], int), 'Vrednost pri registarskom direktnom adresiranju je labela (ovo ne bi trebalo da se desi)'
                reg1 = operands_unresolved[0][1]
            if len(operands_unresolved) == 2:
                assert isinstance(operands_unresolved[1][1], int), 'Vrednost pri registarskom direktnom adresiranju je labela (ovo ne bi trebalo da se desi)'
                reg2 = operands_unresolved[1][1]
            data[adr].append((((opcode << 5) + reg1) << 5) + reg2)

# Formiranje IV tabele
for label in iv_table:
    if label in labels:
        data[iv_table_address].append(labels[label])
    else:
        data[iv_table_address].append(0)

# Štampanje
for adr, contents in data.items():
    contents_line: str = ''
    if args.binary:
        contents_line = ' '.join([format_binary(x, 16) for x in contents])
    else:
        contents_line = ' '.join([format_hex(x, 4) for x in contents])
    print(f'{format_hex(adr, 5)}: {contents_line}')
