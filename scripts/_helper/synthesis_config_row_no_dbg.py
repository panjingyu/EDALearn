#!/usr/bin/env python3

import argparse
import os
import time
from datetime import datetime

import pandas as pd


assert 'designs' in os.listdir()
BASE_DIR = os.getcwd()
os.environ['BASE_DIR'] = BASE_DIR
now = datetime.now().strftime('%m%d%H%M')

def parse_args():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('--design', '-d', type=str, default=None,
                            help='Name of the design to be synthesized.')
    arg_parser.add_argument('--force-override', '-f', action='store_true', help='Force override existing results.')
    arg_parser.add_argument('--tech', '-t', type=str, default='FreePDK45',
                            help='Name of the tech node.')
    arg_parser.add_argument('--version-idx', '-i', type=int,
                            help='Version index to run in the config file.')
    args = arg_parser.parse_args()
    return args

def run_synthesis(design, library, preceding_cmd, script_opts, syn_version):
    script_cmd = f'./scripts/synthesis.py -d {design} -t {library} --syn-version {syn_version}'
    if script_opts['force-override']:
        script_cmd += ' -f'
    os.system(preceding_cmd + ';' + script_cmd)

def main(args):
    config_path = './config/synthesis.csv'
    config_pd = pd.read_csv(config_path, index_col='version')
    v_idx = args.version_idx
    env_seqs = []
    for col in config_pd.columns:
        env_seqs.append(f'export {col}={config_pd.iloc[v_idx][col]}')
    env_cmd = ';'.join(env_seqs)
    script_opts = {
        'force-override': args.force_override,
    }
    syn_version = config_pd.index[v_idx]
    if args.design is not None:
        run_synthesis(args.design, args.tech, env_cmd, script_opts, syn_version)
        return

    # run all designs not in dbg_designs by default
    log_name = 'run_synthesis_{}_{}.{}.running.log'.format(args.tech, syn_version, now)
    log_file = open(log_name, 'w')
    skipped_designs = os.listdir('./dbg_designs')
    designs = sorted(os.listdir('./designs'))
    n_designs = len(designs)
    for idx, d in enumerate(designs):
        if d.endswith('_FreePDK45') and args.tech != 'FreePDK45':
            continue
        if os.path.isdir('/'.join(['./designs', d])):
            log_file.write(
                '[{:02d}/{:02d}] {}: Start...'.format(idx+1, n_designs, d))
            log_file.flush()
            if d in skipped_designs:
                log_file.write('Found in ./dbg_designs, skipped.\n')
                continue

            timer = time.time()
            run_synthesis(d, args.tech, env_cmd, script_opts, syn_version)
            dur = time.time() - timer

            log_file.write('Finished in {:.2f} hrs.\n'.format(dur / 3600))
            log_file.flush()

    log_file.close()
    new_log_name = log_name.split('.')
    new_log_name.remove('running')
    new_log_name = '.'.join(new_log_name)
    os.system(f'mv {log_name} log/{new_log_name}')


if __name__ == '__main__':
    args = parse_args()
    main(args)
