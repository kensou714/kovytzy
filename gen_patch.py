#!/usr/bin/env python
# -*- coding:utf-8 -*-
# (c) 2016  XingXing(HappyASR#gmail.com)

TOKEN_PATCH = 'XXPATCH'
import os
import re
import sys


# return (org,file,line,str)
def process_asm(filename):
    resp = []
    print(f'processing {filename}')
    with open(filename, 'r', encoding='utf-8') as asm_file:
        dat = asm_file.read()
    dat = re.sub('//[ \t]*' + TOKEN_PATCH, '//$$PATCH', dat)
    dat = dat.split(TOKEN_PATCH)
    resp.append((0, filename, 0, dat[0]))
    linecount = dat[0].count('\n')
    for chunk in dat[1:]:
        chunk = chunk.strip(' ').strip('\t')
        org_str = chunk.split('(')[1].strip()
        org_str = re.compile(r'[), ]').split(org_str)[0]
        if org_str[:2] == '0x':
            org_val = int(org_str, 16) & 0x0FFFFFFF
        else:
            org_val = int(org_str) & 0x0FFFFFFF
        resp.append((org_val, filename, linecount, '\t' + TOKEN_PATCH + chunk))
        linecount += chunk.count('\n')
    return resp


def gen_patch(addr_code, outfile, inpdir):
    print(f"outfile={outfile}")
    basepathlen = len(outfile) - len('src/patch.S')
    patch_all = []
    for asm_file in inpdir:
        patch_all.extend(process_asm(asm_file))

    patch_all.sort()
    with open(outfile, 'w+', encoding='utf-8') as out_file:
        out_file.write('''
#include "xxpacth_include.h"
.section .patch,"ax"

XXEXPORT_START(dumpy)

''')
        for entry in patch_all:
            out_file.write('.file "%s"\n' % entry[1][basepathlen:].replace('\\', '\\\\'))
            out_file.write('.line %d\n' % entry[2])
            out_file.write(entry[3] + '\n')

        out_file.write('.file __FILE__\n')
        out_file.write('.line __LINE__\n')
        out_file.write('XXEXPORT_END(dumpy)\n')
        out_file.write('.org %s\n' % addr_code)
        out_file.write('XXEXPORT_START(ccode)\n')


if __name__ == '__main__':
    gen_patch(sys.argv[1], sys.argv[2], sys.argv[3:])
