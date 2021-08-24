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
memory: List[Tuple[int, str]] = []
prev_addr: int = -1
START_ADDR: int = 0x10094
assert START_ADDR % 4 == 0, 'Starting address is not aligned!'
LEADING_WORDS = START_ADDR // 4

with open(args.s_file, 'r', encoding='utf-8') as s_file:
    for line in s_file.readlines():
        match: Optional[Match] = line_regex.match(line)
        if not match:
            continue
        addr_str, contents_str, instruction = match.groups()
        addr: int = int(addr_str, 16)
        assert prev_addr == -1 or addr - prev_addr == 4, f'Unaligned instruction detected!\n\tAddress:\t{addr_str}\n\tContents:\t{contents_str}\n\tInstruction:\t{instruction}'
        prev_addr = addr
        contents: int = int(contents_str, 16)
        memory.append((contents, instruction))

print(f'DEPTH = {LEADING_WORDS + len(memory)};')
print('WIDTH = 32;')
print('ADDRESS_RADIX = HEX;')
print('DATA_RADIX = HEX;')
print('CONTENT')
print('BEGIN')
if LEADING_WORDS > 0:
    print(f'[0..{format_hex(LEADING_WORDS-1)}] : 0;')
curr_word: int = LEADING_WORDS
for (word, instruction) in memory:
    print(f'{format_hex(curr_word)} : {format_hex(word)}; -- {instruction}')
    curr_word += 1
print('END;')
