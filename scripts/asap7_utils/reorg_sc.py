#!/usr/bin/env python

import os


PDK_DIR = 'libraries/Skywater130'
sc = 'sky130_fd_sc_hd'

sc_dir = os.path.join(PDK_DIR, 'libraries', sc, 'latest')
sc_cell_dir = os.path.join(sc_dir, 'cells')
sc_lef_dir = os.path.join(sc_dir, 'lef')

os.makedirs(sc_lef_dir, exist_ok=True)
for cell in sorted(os.listdir(sc_cell_dir)):
    cell_dir = os.path.join(sc_cell_dir, cell)
    for lef in os.listdir(cell_dir):
        if not lef.endswith('.lef'):
            continue
        os.system(f'set -x; cd {sc_lef_dir}; ln -s ../cells/{cell}/{lef}')