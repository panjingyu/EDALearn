#!/usr/bin/env python3

import os


DESIGN_DIR = './designs'
assert os.path.isdir(DESIGN_DIR)

def inno_save_place_cts_netlist(inno_dir):
    base_dir = os.getcwd()
    os.chdir(inno_dir)

    inno_cmd_place = 'innovus -batch -no_gui -no_logv -no_cmd -log fix_save_netlist_place.log ' \
        '-execute "restoreDesign pnr_save/placement.enc.dat DigitalTop; saveNetlist pnr_out/DigitalTop_place.v; ' \
        'setExtractRCMode -engine preRoute -effortLevel low; extractRC; rcOut -spef pnr_out/RC_place.spef.gz;"'
    os.system(inno_cmd_place)
    
    inno_cmd_cts = 'innovus -batch -no_gui -no_logv -no_cmd -log fix_save_netlist_cts.log ' \
        '-execute "restoreDesign pnr_save/cts.enc.dat DigitalTop; saveNetlist pnr_out/DigitalTop_cts.v; ' \
        'setExtractRCMode -engine preRoute; extractRC; rcOut -spef pnr_out/RC_cts.spef.gz;"'
    os.system(inno_cmd_cts)

    os.chdir(base_dir)

def main():
    designs = sorted(os.listdir(DESIGN_DIR))
    for d in designs:
        imp_dir = os.path.join(DESIGN_DIR, d, 'FreePDK45/implementation')
        if not os.path.isdir(imp_dir):
            print('No implementation:', d)
            continue
        for imp in sorted(os.listdir(imp_dir)):
            pnr_out = os.path.join(imp_dir, imp, 'pnr_out')
            cts_netlist = os.path.join(pnr_out, 'DigitalTop_cts.v')
            if os.path.isfile(cts_netlist):
                print('Good:', d, imp)
                continue
            if not os.path.isfile(os.path.join(imp_dir, imp, '_Done_')):
                print('Not done:', d, imp)
                continue
            pnr_save = os.path.join(imp_dir, imp, 'pnr_save')
            cts_enc = os.path.join(pnr_save, 'cts.enc')
            if os.path.isfile(cts_enc):
                print('Fixing:', d, imp)
                # TODO: fix data
                inno_save_place_cts_netlist(os.path.join(imp_dir, imp))
            else:
                print('Strange case:', d, imp)

if __name__ == '__main__':
    main()