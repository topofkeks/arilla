#!/usr/bin/env python
from argparse import ArgumentParser, Namespace
from typing import List, Optional, Tuple

def format_hex(number: int) -> str:
    return '{:08x}'.format(number)

parser = ArgumentParser(description='Generator mif fajlova iz objdump ispisa.')
parser.add_argument('s_file', type=str, help='datoteka sa objdump ispisom')
args: Namespace = parser.parse_args()

with open(args.s_file, 'r', encoding='utf-8') as s_file:
    lines: List[str] = s_file.readlines()
    max_addr: int = int(lines[-1].strip().split(' ')[0], 16) + 16
    min_addr: int = int(lines[0].strip().split(' ')[0], 16)
    print(f'-- offset = 0x{format_hex(min_addr)}')
    print(f'DEPTH = {(max_addr - min_addr) // 4};')
    print('WIDTH = 32;')
    print('ADDRESS_RADIX = HEX;')
    print('DATA_RADIX = HEX;')
    print('CONTENT')
    print('BEGIN')
    for line in lines:
        spl: List[str] = line.strip().split(' ')
        addr: int = int(spl[0], 16)
        for i in range(4):
            contents: str = ''
            if spl[i + 1] == '':
                contents = '00000000'
            else:
                int(spl[i + 1], 16)
                contents = spl[i + 1]
            print(f'{format_hex((addr + i * 4 - min_addr) // 4)} : {"".join([contents[i:i+2] for i in range(0, len(contents), 2)][::-1])};')
    print('END;')
