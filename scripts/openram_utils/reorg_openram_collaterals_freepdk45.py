#!/usr/bin/env python3

import os

def fetch_collaterals(macro_dir):
    macros = sorted(os.listdir(macro_dir))
    collaterals = {}
    for mac in macros:
        items = os.listdir(os.path.join(macro_dir, mac))
        dbs = [c for c in items if c.endswith('.db')]
        libs = [d[:-2] + 'lib' for d in dbs]
        for lib in libs:
            lib_path = os.path.join(macro_dir, mac, lib)
            assert os.path.isfile(lib_path), f'{lib_path} does not exist!'
        lef = mac + '.lef'
        lef_path = os.path.join(macro_dir, mac, lef)
        assert os.path.isfile(lef_path), f'{lef_path} does not exist!'
        collaterals[mac] = {'db': dbs, 'lib': libs, 'lef': lef}
    return collaterals

def link_dbs_and_libs(collaterals, db_dir, lib_dir,
                      corners=['FF_1p25V_0C', 'TT_1p1V_25C', 'SS_0p95V_125C']):
    macs = sorted(collaterals.keys())
    db_list_corners = {c: [] for c in corners}
    lib_list_corners = {c: [] for c in corners}
    for mac in macs:
        col = collaterals[mac]
        def _link_db_lib_helper(col_db_lib, ln_dir, list_corners):
            for x in col_db_lib:
                x_path = os.path.join('../macros/', mac, x)
                os.system(f'cd {ln_dir} && ln -sf {x_path}')
                matched_corner = [c for c in corners if c in x]
                if len(matched_corner) == 0:
                    # print(f'Cannot find corner for {x}')
                    continue
                elif len(matched_corner) > 1:
                    raise ValueError(f'Found multiple corners for {x}: {matched_corner}')
                list_corners[matched_corner[0]].append(x)
        _link_db_lib_helper(col['db'], db_dir, db_list_corners)
        _link_db_lib_helper(col['lib'], lib_dir, lib_list_corners)
    return db_list_corners, lib_list_corners

def link_lefs(collaterals, lef_dir):
    macs = sorted(collaterals.keys())
    lef_list = []
    for mac in macs:
        col = collaterals[mac]
        lef = col['lef']
        lef_path = os.path.join('../macros/', mac, lef)
        os.system(f'cd {lef_dir} && ln -sf {lef_path}')
        lef_list.append(lef)
    return lef_list

def main():
    freepdk_openram_dir = 'libraries/FreePDK45/OpenRAM'
    macro_dir = os.path.join(freepdk_openram_dir, 'macros')
    db_dir = os.path.join(freepdk_openram_dir, 'db')
    lib_dir = os.path.join(freepdk_openram_dir, 'lib')
    lef_dir = os.path.join(freepdk_openram_dir, 'lef')

    collaterals = fetch_collaterals(macro_dir)
    db_list_corners, lib_list_corners = link_dbs_and_libs(collaterals, db_dir, lib_dir)
    lef_list = link_lefs(collaterals, lef_dir)

    corners = sorted(db_list_corners.keys())
    for c in corners:
        print(f'Corner {c} dbs:')
        print(' \\\n'.join(db_list_corners[c]) + ' \\\n')
        print(f'Corner {c} libs:')
        print(' \\\n'.join(lib_list_corners[c]) + ' \\\n')

    print('LEFs:')
    for lef in lef_list:
        print('    $OPENRAM_MACRO_LEF_DIR/' + lef + ' \\')

if __name__ == '__main__':
    main()