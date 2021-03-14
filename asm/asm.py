#!/usr/bin/env python
from argparse import ArgumentParser
from typing import Dict, List, Optional, Tuple, Union
import re

parser = ArgumentParser(description='Asembler za arhitekturu procesora iz projektnog zadatka 47 sa Osnova računarske tehnike 2 za godinu 2021.')
parser.add_argument('asm_file', type=str, help='datoteka sa izvornim asemblerskim kodom')
parser.add_argument('--binary', help='ispis instrukcija u binarnim ciframa', action='store_true')
parser.add_argument('--iv', help='generisanje sadržaja IV tabele na osnovu labela intrX', action='store_true')
parser.add_argument('--pretty', help='štampa novi red na kraju instrukcije', action='store_true')
parser.add_argument('--v3hex', help='štampa u v3.0 hex words addressed formatu, za Logisim', action='store_true')
args = parser.parse_args()

# (     0         1               2               3         4          5         6         7     )
# (Instruction, Indir1, Flags(R, #, +, -), Base1(0b, 0x), Number, Base2(b, h), Indir2, Post(+, -))
line_regex = re.compile(r'^\s*(?:([a-zA-z][a-zA-Z0-9]+)\s*:)?\s*(HALT|RTS|RTI|ROT?RC?|PUSH|POP|BLEQ|BGREU|BNNG|BGRT|JLEQ|JMP|JSR|LD|ST|ADD|INC|OR|STRFIND)\s*(?:(?:(\()?([R#+-]|#-)?(0[bx])?([0-9a-f]+)?(h)?(\))?([+-])?)|([a-zA-z][a-zA-Z0-9]+))\s*(?:;|$)', re.IGNORECASE)
instructions: List[Tuple[Optional[str], Optional[str], Union[str, int, None]]] = []
opcodes: Dict[str, int] = {
    # Bezadresne
    'HALT': 0,
    'RTS': 1,
    'RTI': 2,
    'ROR': 3,
    'ROTR': 3,
    'RORC': 4,
    'ROTRC': 4,
    'PUSH': 5,
    'POP': 6,
    # Uslovni skokovi
    'BLEQ': 16,
    'BGREU': 17, 
    'BNNG': 18,
    'BGRT': 19,
    'JLEQ': 20,
    # Bezuslovni skokovi
    'JMP': 32,
    'JSR': 33,
    # Adresne
    'LD': 48,
    'ST': 49,
    'ADD': 50,
    'INC': 51,
    'OR': 52,
    'STRFIND': 53
}


labels : Dict[str, int] = {}

lengths : Dict[Union[str, None], int] = {
    None : 0,
    # Adresiranja
    'immed' : 4,
    'memdir' : 4,
    'memind' : 4,
    'regind' : 2,
    'postincr' : 2,
    'postdec' : 2,
    'regdir' : 2,
    # Instrukcije 
    'HALT' : 1,
    'RTS' : 1,
    'RTI' : 1,
    'ROR' : 1,
    'RORC' : 1,
    'PUSH' : 1,
    'POP' : 1,
    'BLEQ' : 2,
    'BGREU' : 2,
    'BNNG' : 2,
    'BGRT' : 2,
    'JLEQ' : 3,
    'JMP' : 3,
    'JSR' : 3,
}

adrcodes = ['immed', 'memdir', 'memind', 'regind', 'postincr', 'postdec', 'regdir']

with open(args.asm_file, 'r', encoding='utf-8') as asm_file:
    for line in asm_file:
        if line.strip() == '':
            # Prazna linija
            continue
        line_match = line_regex.match(line)
        if line_match is None:
            print('Sintaksna greška: ', line)
            exit(1)
        label, instruction, indir1, flags, base1, number, base2, indir2, post, destination = line_match.groups()
        instruction = instruction.upper()
        indir = False
        reg = flags == 'R' or flags == 'r'
        immed = type(flags) is str and flags.startswith('#')
        branch = instruction.startswith('B')
        jump = instruction.startswith('J')
        if destination is not None and destination.endswith('\n'): destination = destination[:-1] # Uklanjanje \n
        # Validacija
        if label is not None and label in labels:
            print('Opet se definiše labela: ',label)
            exit(1)
        if destination is not None and not jump:
            print('Samo instrukcije apsolutnog skoka mogu imati labelu kao operand.')
            exit(1)
        if type(flags) is str and flags.endswith('-') and not (branch or immed):
            print('Samo instrukcije grananja i neposredno adresiranje mogu da imaju znak operanda:', line)
            exit(1)
        if (indir1 is not None) != (indir2 is not None):
            print('Nedostaje zagrada kod indirektnog adresiranja: ', line)
        if indir1 is not None and indir2 is not None:
            indir = True
        if base1 is not None and base2 is not None:
            print('Zadate su osnove i kao prefiks i kao sufiks:', line)
            exit(1)
        # Nova labela
        if label is not None:
            instructions.append((None, label, None))
        # Određivanje operanda
        operand = None
        if destination is not None:
            operand = destination
        elif number is not None:
            if opcodes[instruction] < 8:
                print(label, instruction, indir1, flags, base1, number, base2, indir2, post, destination)
                print('Bezadresne instrukcije ne primaju operande:', line)
                exit(1)
            base = 10
            if base1 == '0x' or base1 == '0X' or base2 == 'h' or base2 == 'H':
                base = 16
            elif base1 == '0b' or base1 == '0B' or base2 == 'b' or base2 == 'B':
                base = 2
            operand = int(number, base)
            if type(flags) is str and flags.endswith('-'):
                operand = -operand
            if (reg and operand > 15) or (branch and (operand < -128 or operand > 127)) or operand > 65535:
                print('Operand van dozvoljenih granica:', line)
                exit(1)
        # Određivanje načina adresiranja
        adr = None
        if operand is not None and not branch and not jump:
            if immed:
                if indir:
                    print('Neposredno adresiranje ne može da bude indirektno:', line)
                    exit(1)
                adr = 'immed'
            elif reg:
                if indir:
                    if post == '+':
                        adr = 'postincr'
                    elif post == '-':
                        adr = 'postdec'
                    else:
                        adr = 'regind'
                else:
                    if post is None:
                        adr = 'regdir'
                    else:
                        print('Postinkrement i dekrement su podržani samo kod registarskog indirektnog adresiranja:', line)
            elif post is not None:
                print('Postinkrement i dekrement su podržani samo kod registarskog indirektnog adresiranja:', line)
                exit(1)
            elif indir:
                adr = 'memind'
            else:
                adr = 'memdir'
        # Slanje na formatiranje
        instructions.append((instruction, adr, operand))

# Faza određivanja labela
tpos = 0x1000
for instruction, adr, operand in instructions:
    if instruction is None and adr is not None:
        labels[adr] = tpos
    else:
        tpos += lengths.get(instruction, 0) + lengths.get(adr, 0)

# Faza postavljanja adresa labela
for i, (instruction, adr, operand) in enumerate(instructions):
    #print(instruction, adr, operand, i)
    if isinstance(operand, str):
        if operand not in labels:
            print('Nedefinisana labela: ', operand)
            exit(1)
        instructions[i] = (instruction, adr, labels[operand])

# Štampanje
if args.v3hex:
    print('v3.0 hex words addressed')
elif args.iv:
    print('IV tabela:')

# Ispis sadržaja IV tabele
if args.iv:
    iv_format = []
    for i in range(4):
        key = f'intr{i}'
        if key in labels:
            formatted_addr = '{:016b}'.format(labels[key])
            iv_format.append(formatted_addr[0:8])
            iv_format.append(formatted_addr[8:])
        else:
            iv_format.append('00000000')
            iv_format.append('00000000')
    if args.v3hex:
        print('0000: ', end='')
    if args.binary:
        print(' '.join(iv_format))
    else:
        print(' '.join([hex(int(num, 2)).split('x')[1].upper() for num in iv_format]))

if args.v3hex:
    print('1000: ', end='')
elif args.iv:
    print('================================================')
for instruction, adr, operand in instructions:
    # print(instruction, adr, operand)
    if instruction is None:
        continue
    opcode = opcodes[instruction]
    instruction_format = ['{:08b}'.format(opcode)]
    if instruction.startswith('J'):
        # Instrukcije skoka
        formatted_addr = '{:016b}'.format(operand)
        instruction_format.append(formatted_addr[0:8])
        instruction_format.append(formatted_addr[8:])
    elif instruction.startswith('B'):
        # Instrukcije grananja
        operand_format = '{:08b}'.format(operand)
        if type(operand) is int and operand < 0:
            operand_format = bin(operand & 0xFF)[-8:]
        instruction_format.append(operand_format)
    elif opcode >= 48:
        # Adresne instrukcije
        adrcode = adrcodes.index(str(adr))
        reg = 0
        nonreg = adr == 'immed' or adr == 'memdir' or adr == 'memind'
        if not nonreg and operand is not None:
            reg = operand
        instruction_format.append('{:08b}'.format((adrcode << 4) + int(reg)))
        if nonreg:
            operand_format = '{:016b}'.format(operand)
            if type(operand) is int and operand < 0:
                operand_format = bin(operand & 0xFFFF)[-16:]
            instruction_format.append(operand_format[0:8])
            instruction_format.append(operand_format[8:])
    if args.binary:
        print(' '.join(instruction_format), end=' ')
    else:
        print(' '.join([hex(int(num, 2)).split('x')[1].upper() for num in instruction_format]), end=' ')
    if args.pretty:
        print()
if not args.pretty:
    print()
