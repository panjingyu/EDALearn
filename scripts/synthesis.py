#!/usr/bin/env python3

import argparse
import os
import time


assert 'designs' in os.listdir()
BASE_DIR = os.getcwd()
os.environ['BASE_DIR'] = BASE_DIR

def parse_args():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('--design', '-d', type=str, help='Name of the design to be synthesized.')
    arg_parser.add_argument('--tech', '-t', type=str, default='FreePDK45', help='Name of the tech node.')
    arg_parser.add_argument('--force-override', '-f', action='store_true', help='Force override existing results.')
    arg_parser.add_argument('--syn-version', type=str, default='tmp', help='Synthesis result folder.')
    args = arg_parser.parse_args()
    return args

def synthesis(design, syn_version, library, override=False):
    design_dir = os.path.join('./designs', design)
    rtl_dir = os.path.join(design_dir, 'rtl')
    synthesis_dir = os.path.join(design_dir, library, 'synthesis')

    syn_version_dir = os.path.join(synthesis_dir, syn_version)
    if os.path.isdir(syn_version_dir):
        if not override:
            print('[Warning] ' + syn_version_dir + ' already exists! Skipped...')
            return
        os.system('rm -rf {}/'.format(syn_version_dir))
    os.makedirs(syn_version_dir)

    frontend_dir = os.path.join('scripts', library, 'frontend')
    scripts = sorted(os.listdir(frontend_dir))
    scripts = [os.path.join(BASE_DIR, frontend_dir, s) for s in scripts]

    cmd = 'dc_shell -no_home_init -output_log_file console.log '\
          '-x "set RTL_DIR {};'.format('../../../rtl')
    cmd += 'source -e -v ../../../config.tcl;'
    cmd += 'source -e -v {};'.format(os.path.join(BASE_DIR, 'scripts', library, 'tech.tcl'))
    for s in scripts:
        cmd += 'source -e -v {};'.format(s)
    cmd += '"'

    os.system('cd {} && cp ../../../config.tcl . && {} && touch _Done_'.format(syn_version_dir, cmd))


if __name__ == '__main__':
    start = time.time()
    args = parse_args()
    synthesis(args.design, args.syn_version, args.tech, override=args.force_override)
    end = time.time()
    print('Elapsed time: {:.1f} secs'.format(end - start))