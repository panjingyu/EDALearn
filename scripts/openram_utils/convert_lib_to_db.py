#!/usr/bin/env python3

import os

macro_dir = 'OpenRAM/macros'

for m in os.listdir(macro_dir):
    m_dir = os.path.join(macro_dir, m)
    if os.path.isdir(m_dir) and m.startswith('freepdk45'):
        # check if .lib file exists
        lib_files = [f for f in os.listdir(m_dir) if f.endswith('.lib')]
        assert len(lib_files) > 0, f'No .lib file found in {m_dir}'
        lc_cmd = ''
        for lib_f in lib_files:
            db_f = lib_f[:-3] + 'db'
            if os.path.isfile(os.path.join(m_dir, db_f)):
                continue
            lc_cmd += f'read_lib {lib_f};'
            lc_cmd += f'write_lib {lib_f[:-4]}_lib -format db'
            lc_cmd += f' -output {db_f};'
        if lc_cmd:
            os.system(f'cd {m_dir}; lc_shell -no_motd -no_log -batch -x "{lc_cmd}"')
