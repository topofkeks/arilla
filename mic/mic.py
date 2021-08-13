#!/usr/bin/env python
from argparse import ArgumentParser, Namespace
from math import ceil, log2
from typing import Dict, List, Set, Tuple, Union
import re

parser = ArgumentParser(description='Generator mikrokoda za projekat iz Arhitekture računara.')
parser.add_argument('mic_file', type=str, help='datoteka sa izvornim mikrokodom')
parser.add_argument('--binary', help='ispis mikoinstrukcija u binarnim ciframa', action='store_true')
parser.add_argument('--csv', help='štampa u CSV formatu, za Excel', action='store_true')
parser.add_argument('--v3hex', help='štampa u v3.0 hex words addressed formatu, za Logisim', action='store_true')
parser.add_argument('--mif', help='štampa u MIF (memory initialization file) formatu, za Quartus', action='store_true')
args: Namespace = parser.parse_args()

case_regex = re.compile(r'^br\s*\(\s*case\s*\(([^)]+)\)')
if_regex = re.compile(r'^br\s*\(if\s*([^\s]+) then\s*([0-9A-Za-z]+)\s*\)$')
uncond_regex = re.compile(r'^br\s*([0-9A-Za-z]+)$')
signals: Dict[str, bool] = {}
labels: Dict[str, int] = {
    'start': 0
}
case_labels: List[str] = []
cc: List[str] = ['', 'uncnd']

# Lines before and after branch address resolution
lines_unresolved: List[Tuple[Set[str], int, str]] = []
lines: List[Tuple[Set[str], int, int]] = []

def split_before_bracket(line: str) -> List[str]:
    spl: List[str] = []
    while len(line) > 0:
        bracket_index: int = len(line) + 7
        if '(' in line:
            bracket_index = line.index('(')
        if ',' in line:
            index: int = line.index(',')
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
        line: str = line.strip()
        if len(line) == 0 or line.startswith('!'):
            # Komentar ili prazna linija
            continue
        line_cc: int = 0
        line_ba_unresolved: str = ''
        line_signals: Set[str] = set()
        split_line: List[str] = line.split(':', 1)
        curr_line: int = len(lines_unresolved)
        if len(split_line) == 2:
            labels[split_line[0]] = curr_line
            line = split_line[1]
        split_line = split_before_bracket(line)
        for i in range(0, len(split_line)-1):
            stripped_signal: str = split_line[i].strip()
            signals[stripped_signal] = True
            line_signals.add(stripped_signal)
        br: str = split_line[-1].strip()
        case_match: Union[re.Match[str], None] = case_regex.match(br)
        if_match: Union[re.Match[str], None] = if_regex.match(br)
        uncond_match: Union[re.Match[str], None] = uncond_regex.match(br)
        if case_match is not None:
            # br (case(signal1, signal2, ...)) then (signal1, stepXX), (signal2, stepYY), ...
            if 'mul' in cc:
                line_cc = cc.index('mul')
            else:
                cc.append('mul')
                line_cc = len(cc)-1
            for label in case_match.group(1).split(','):
                case_labels.append(label.strip())
        elif if_match is not None:
            # br (if cc then)
            signal = if_match.group(1)
            line_ba_unresolved = if_match.group(2)
            if signal in cc:
                line_cc = cc.index(signal)
            else:
                cc.append(signal)
                line_cc = len(cc)-1
        elif uncond_match is not None:
            # br stepXX
            line_cc = 1
            line_ba_unresolved = uncond_match.group(1)
        else:
            # Ovo je bio samo običan signal na kraju linije
            signals[br] = True
            line_signals.add(br)
        lines_unresolved.append((line_signals, line_cc, line_ba_unresolved))

for index, (curr_signals, curr_cc, ba_unresolved) in enumerate(lines_unresolved):
    ba: int = 0
    if ba_unresolved in labels:
        ba = labels[ba_unresolved]
    elif ba_unresolved == 'this':
        ba = index
    elif ba_unresolved != '':
        print('Label', ba_unresolved, 'on line', index + 1, 'unresolved!')
        exit(1)
    lines.append((curr_signals, curr_cc, ba))

cc_width: int = ceil(log2(len(cc)))
ba_width: int = ceil(log2(len(lines)))
final_width = cc_width + ba_width + len(signals)

def format_binary(num: int, width: int) -> str:
    fmt = '{:0' + str(width) + 'b}'
    return fmt.format(num)

if args.v3hex:
    print('v3.0 hex words addressed\n0000: ', end='')
elif args.csv:
    print('ba', 'cc', ','.join(reversed(list(signals.keys()))), sep=',')
elif args.mif:
    print(f'DEPTH = {len(lines)};')
    print(f'WIDTH = {final_width};')
    print('ADDRESS_RADIX = HEX')
    if args.binary:
        print('DATA_RADIX = BIN')
    else:
        print('DATA_RADIX = HEX')
    print('CONTENT')
    print('BEGIN')
else:
    print('================== Instrukcija ======================')
    print('Širina instrukcije:', final_width)
    print(f'Signali [0-{len(signals) - 1}]:')
    for i, signal in enumerate(signals.keys()):
        print(f'{i} - {signal}')
    print(f'CC [{len(signals)}-{len(signals) + cc_width - 1}]:')
    for index, code in enumerate(cc):
        if index > 0:
            print(f'- {index}: br{code}')
    print(f'BA [{cc_width + len(signals)}-{final_width - 1}]')
    if len(case_labels) > 0:
        print('Case:')
        for label in case_labels:
            if label in labels:
                print(f'- {label}: {labels[label]}')
            else:
                print(f'- {label}: UNRESOLVED')
    print('=================== Mikrokod ========================')
for index, (curr_signals, curr_cc, ba) in enumerate(lines):
    line_bin: str = ''
    line_bin += format_binary(ba, ba_width)
    if args.csv:
        line_bin += ','
    line_bin += format_binary(curr_cc, cc_width)
    for signal in reversed(list(signals.keys())):
        if args.csv:
            line_bin += ','
        if signal in curr_signals:
            line_bin += '1'
        else:
            line_bin += '0'
    if args.mif:
        print(hex(index).split('x')[1], end=' : ')
    if args.binary or args.csv:
        print(line_bin, end=' ')
    else:
        print(hex(int(line_bin, 2)).split('x')[1].upper(), end=' ')
    if args.mif:
        print(';')
    elif not args.v3hex:
        print()
if args.v3hex:
    print()
elif args.mif:
    print('END;')
