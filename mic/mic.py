#!/usr/bin/env python
from argparse import ArgumentParser
from math import ceil, log2
from typing import List, Set, Tuple
import re

parser = ArgumentParser(description='Generator mikrokoda za projekat iz Osnova računarske tehnike.')
parser.add_argument('mic_file', type=str, help='datoteka sa izvornim mikrokodom')
parser.add_argument('--binary', help='ispis mikoinstrukcija u binarnim ciframa', action='store_true')
parser.add_argument('--csv', help='štampa u CSV formatu, za Excel', action='store_true')
parser.add_argument('--v3hex', help='štampa u v3.0 hex words addressed formatu, za Logisim', action='store_true')
args = parser.parse_args()

step_regex = re.compile(r'^\s*step\s*([0-9A-Fa-f]+)\s*=>\s*(.*)$')
case_regex = re.compile(r'^br\s*\(\s*case\s*\(')
if_regex = re.compile(r'^br\s*\(if\s*([^\s]+) then\s*step\s*([0-9A-Fa-f]+)\s*\)$')
uncond_regex = re.compile(r'^br\s*step\s*([0-9A-Fa-f]+)$')
signals = {}
cc = [None, 'uncnd']

lines: List[Tuple[Set[str], int, int]] = []

def split_before_bracket(line: str) -> List[str]:
    spl: List[str] = []
    while len(line) > 0:
        bracket_index = len(line) + 7
        if '(' in line:
            bracket_index = line.index('(')
        if ',' in line:
            index = line.index(',')
            if index > bracket_index:
                spl.append(line)
                break
            spl.append(line[:index])
            line = line[index+1:]
        else:
            spl.append(line)
            break
    return spl

with open(args.mic_file, 'r', encoding='utf-8') as mic_file:
    for line in mic_file:
        stripped_line = line.strip()
        if len(stripped_line) == 0 or stripped_line.startswith('!'):
            # Komentar ili prazna linija
            continue
        line_cc = 0
        line_ba = 0
        line_signals: Set[str] = set()
        step_match = step_regex.match(stripped_line)
        if step_match is None:
            print('Nedostaje broj koraka na liniji:', stripped_line)
            exit(1)
        step_number = int(step_match.group(1), 16)
        if step_number != len(lines):
            print('Koraci ne idu po redosledu na liniji:', stripped_line)
            exit(1)
        split_line = split_before_bracket(step_match.group(2))
        for i in range(0, len(split_line)-1):
            stripped_signal = split_line[i].strip()
            signals[stripped_signal] = True
            line_signals.add(stripped_signal)
        br = split_line[-1].strip()
        case_match = case_regex.match(br)
        if_match = if_regex.match(br)
        uncond_match = uncond_regex.match(br)
        if case_match is not None:
            # br (case(signal1, signal2, ...)) then (signal1, stepXX), (signal2, stepYY), ...
            if 'mul' in cc:
                line_cc = cc.index('mul')
            else:
                cc.append('mul')
                line_cc = len(cc)-1
        elif if_match is not None:
            # br (if cc then)
            signal = if_match.group(1)
            line_ba = int(if_match.group(2), 16)
            if signal in cc:
                line_cc = cc.index(signal)
            else:
                cc.append(signal)
                line_cc = len(cc)-1
        elif uncond_match is not None:
            # br stepXX
            line_cc = 1
            line_ba = int(uncond_match.group(1), 16)
        else:
            # Ovo je bio samo običan signal na kraju linije
            signals[br] = True
            line_signals.add(br)
        lines.append((line_signals, line_cc, line_ba))

cc_width = ceil(log2(len(cc)))
ba_width = ceil(log2(len(lines)))

def format_binary(num: int, width: int):
    fmt = '{:0' + str(width) + 'b}'
    return fmt.format(num)

if args.v3hex:
    print('v3.0 hex words addressed\n0000: ', end='')
elif args.csv:
    print('ba', 'cc', ','.join(signals.keys()), sep=',')
else:
    print('================== Instrukcija ======================')
    print('Širina instrukcije:', cc_width + ba_width + len(signals))
    print(f'Signali [0-{len(signals) - 1}]:')
    for i, signal in enumerate(signals.keys()):
        print(f'{i} - {signal}')
    print(f'CC [{len(signals)}-{len(signals)+cc_width - 1}]:')
    for index, code in enumerate(cc):
        if index > 0:
            print(f'- {index}: br{code}')
    print(f'BA [{cc_width + len(signals)}-{cc_width + ba_width + len(signals) - 1}]')
    print('=================== Mikrokod ========================')
for curr_signals, cc, ba in lines:
    line_bin = ''
    line_bin += format_binary(ba, ba_width)
    if args.csv:
        line_bin += ','
    line_bin += format_binary(cc, cc_width)
    for signal in reversed(list(signals.keys())):
        if args.csv:
            line_bin += ','
        if signal in curr_signals:
            line_bin += '1'
        else:
            line_bin += '0'
    if args.binary or args.csv:
        print(line_bin, end=' ')
    else:
        print(hex(int(line_bin, 2)).split('x')[1].upper(), end=' ')
    if not args.v3hex:
        print()
if args.v3hex:
    print()
