#!/usr/bin/env python3

import os
import time
from datetime import datetime


designs_dir = './designs'

now = datetime.now().strftime('%m%d%H%M')
log_name = 'run_synthesis_all.{}.running.log'.format(now)
log_file = open(log_name, 'w')

designs = sorted(os.listdir(designs_dir))
skipped_designs = os.listdir('./dbg_designs')

n_designs = len(designs)
for idx, d in enumerate(designs):
    if os.path.isdir('/'.join([designs_dir, d])):
        log_file.write(
            '[{:02d}/{:02d}] {}: Start...'.format(idx+1, n_designs, d))
        log_file.flush()
        if d in skipped_designs:
            log_file.write('Found in ./dbg_designs, skipped.\n')
            continue

        timer = time.time()
        os.system('./scripts/synthesis.py -f -d {}'.format(d))
        dur = time.time() - timer

        log_file.write('Finished in {:.2f} hrs.\n'.format(dur / 3600))
        log_file.flush()

log_file.close()

new_log_name = log_name.split('.')
new_log_name.remove('running')
new_log_name = '.'.join(new_log_name)
os.system(f'mv {log_name} {new_log_name}')