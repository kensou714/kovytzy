#!/usr/bin/env python
# -*- coding:utf-8 -*-
# (c) 2016  XingXing(HappyASR#gmail.com)

import os
import re
import sys


def patch_file(crosstools, fileelf, filemap, fileori, fileout):
    print(f'processing {fileout}')
    map_list = []
    rom_base = None
    with open(filemap, 'r', encoding='utf-8') as map_file:
        for raw_line in map_file:
            line = raw_line.rstrip('\n')
            if not line:
                continue
            if line.startswith('.rom'):
                tokens = line.strip().split()
                if len(tokens) < 2:
                    raise ValueError(f'Unexpected .rom line: {line!r}')
                rom_base = int(tokens[1], 16)
                continue
            if '__patch_end_' in line or '__patch_start_' in line:
                if rom_base is None:
                    raise ValueError('rom_base is not set before patch markers')
                tokens = line.strip().split()
                if len(tokens) < 2:
                    raise ValueError(f'Unexpected patch line: {line!r}')
                map_list.append((int(tokens[0], 16) - rom_base, tokens[1]))
    map_list.sort()
    if not map_list:
        raise ValueError('No patch entries found in map file')
    with open(fileori, 'rb') as ori_file:
        dat_ori = ori_file.read()
    len_ori = len(dat_ori)
    os.system(f"{crosstools}objcopy.exe -Obinary -j.rom {fileelf} rom.bin")
    os.system(f"{crosstools}objcopy.exe -Obinary -j.ram {fileelf} ram.bin")
    with open('rom.bin', 'rb') as rom_file, open('ram.bin', 'rb') as ram_file:
        dat_pat = rom_file.read() + ram_file.read()
    os.remove('rom.bin')
    os.remove('ram.bin')
    for i in range(len(map_list) // 2):
        pat_start = map_list[2 * i][0]
        pat_end = map_list[2 * i + 1][0]
        if pat_end != pat_start:
            dat_ori = dat_ori[:pat_start] + dat_pat[pat_start:pat_end] + dat_ori[pat_end:]
    dat_ori = dat_ori[:map_list[-1][0]] + dat_pat[map_list[-1][0]:] + dat_ori[len(dat_pat):]
    len_now = len(dat_ori)
    dat_ori += b'\xFF' * (len_ori - len_now)
    with open(fileout, 'wb') as output_file:
        output_file.write(dat_ori)
    print('Saved OK.')


if __name__ == '__main__':
    if len(sys.argv) > 5:
        patch_file(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
    else:
        print(f"{sys.argv[0]} <CROSS-PREFIX> <ELF> <MAP> <ORI_BIN> <OUTPUT>")
        sys.exit(1)
