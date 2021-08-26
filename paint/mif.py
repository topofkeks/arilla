#!/usr/bin/env python
from argparse import ArgumentParser, Namespace
from typing import List, Optional, Tuple
from re import compile, Pattern, Match

def format_hex(number: int) -> str:
    return '{:08x}'.format(number)

parser = ArgumentParser(description='Generator mif fajlova iz objdump ispisa.')
parser.add_argument('s_file', type=str, help='datoteka sa objdump ispisom')
args: Namespace = parser.parse_args()

line_regex: Pattern[str] = compile(r'^\s*([0-9a-f]+):\s*([0-9a-f]+)\s*(.*)$')
gp_regex: Pattern[str] = compile(r'.*-([0-9a-f]+)\s*\(gp\)\s*#\s*([0-9a-f]+).*')
memory: List[Tuple[int, str]] = []
prev_addr: int = -1
start_addr: int = -1
gp: int = -1

with open(args.s_file, 'r', encoding='utf-8') as s_file:
    for line in s_file.readlines():
        match: Optional[Match] = line_regex.match(line)
        if not match:
            continue
        addr_str, contents_str, instruction = match.groups()
        addr: int = int(addr_str, 16)
        assert prev_addr == -1 or addr - prev_addr == 4, f'Unaligned instruction detected!\n\tAddress:\t{addr_str}\n\tContents:\t{contents_str}\n\tInstruction:\t{instruction}'
        if start_addr == -1:
            start_addr = addr
        prev_addr = addr
        contents: int = int(contents_str, 16)
        memory.append((contents, instruction))
        gp_match: Optional[Match] = gp_regex.match(instruction)
        if gp_match:
            offset1_str, offset2_str = gp_match.groups()
            new_gp: int = int(offset1_str, 10) + int(offset2_str, 16)
            assert gp == -1 or new_gp == gp, 'GP value differs throughout compiler output!'
            gp = new_gp

assert gp != -1, 'Failed to parse GP location from compiler output!'

gp -= start_addr
print(f'-- gp = 0x{format_hex(gp)}')
print(f'DEPTH = {len(memory)};')
print('WIDTH = 32;')
print('ADDRESS_RADIX = HEX;')
print('DATA_RADIX = HEX;')
print('CONTENT')
print('BEGIN')
curr_word: int = 0
for (word, instruction) in memory:
    print(f'{format_hex(curr_word)} : {format_hex(word)}; -- {instruction}')
    curr_word += 1
print('END;')
