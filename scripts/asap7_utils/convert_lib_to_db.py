#!/usr/bin/env python

import os


PDK_DIR = 'libraries/ASAP7'
sc = 'asap7sc6t_26'

sc_dir = os.path.join(PDK_DIR,  sc)
sc_lib_dir = os.path.join(sc_dir, 'LIB/CCS')


lib_files = sorted(f for f in os.listdir(sc_lib_dir) if f.endswith('.lib'))
for lib_f in lib_files:
    db_f = lib_f[:-3] + 'db'
    lc_cmd = ''
    if os.path.isfile(os.path.join(sc_lib_dir, db_f)):
        continue
    lc_cmd += f'read_lib {lib_f};'
    lc_cmd += f'write_lib {lib_f[:-4]} -format db'
    lc_cmd += f' -output {db_f};'
    os.system(f'cd {sc_lib_dir}; lc_shell -no_motd -no_log -batch -x "{lc_cmd}" & >/dev/null')