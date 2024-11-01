#!/usr/bin/env python3

import argparse
import os

from openram_common import parse_mems_config_file
from openram_common import get_sram_name
from openram_common import find_mems_config_file

OPENRAM_CONFIG_DIR = 'OpenRAM/macros/configs'


def parse_args():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('--chipyard-config-dir', '-c', type=str, required=True,
                            help='Path to chipyard config directory')
    args = arg_parser.parse_args()
    return args

def gen_openram_freepdk45_sram_config(depth, width, n_rw_ports, n_r_ports, n_w_ports,
                                      mask_gran=None):
    # sanity check
    assert width <= 2048, f'OpenRAM SRAMs only support width <= 2048, got {depth}'
    assert depth >= 16, f'OpenRAM SRAMs only support depth >= 16, got {width}'
    config_text = [
        '# Auto-generated by generate_openram_srams.py',
        f'word_size = {width}',
        f'num_words = {depth}\n',
        f'write_size = {mask_gran}\n' if mask_gran else '',
        f'num_rw_ports = {n_rw_ports}',
        f'num_r_ports = {n_r_ports}',
        f'num_w_ports = {n_w_ports}\n',
    ]
    epilogue = r'''
tech_name = "freepdk45"
nominal_corner_only = False
use_specified_corners = [("FF", 1.25, 0), ("TT", 1.1, 25), ("SS", .95, 125), ("TT", 1., 25)]

route_supplies = False
check_lvsdrc = False
perimeter_pins = False

num_threads = 4

output_name = "sram_{0}rw{1}r{2}w_{3}_{4}_{5}".format(num_rw_ports,
                                                      num_r_ports,
                                                      num_w_ports,
                                                      word_size,
                                                      num_words,
                                                      tech_name)
output_path = "macro/{}".format(output_name)'''
    return '\n'.join(config_text) + epilogue

def make_openram_freepdk45_sram_config_file(config):
    depth = int(config['depth'])
    width = int(config['width'])
    mask_gran = None
    if 'mask_gran' in config:
        mask_gran = int(config['mask_gran'])
    ports = config['ports']
    if ports.endswith('rw'):
        num_rw_ports = 1
        num_r_ports, num_w_ports = 0, 0
    elif ports.endswith('write,read'):
        num_rw_ports = 0
        num_r_ports, num_w_ports = 1, 1
    else:
        raise ValueError(f'Unknown ports: {ports}')
    text = gen_openram_freepdk45_sram_config(
        depth, width, num_rw_ports, num_r_ports, num_w_ports, mask_gran=mask_gran)
    config_name = get_sram_name(config)
    config_file = os.path.join(OPENRAM_CONFIG_DIR, config_name) + '.py'
    if not os.path.isfile(config_file):
        with open(config_file, 'w') as f:
            f.write(text)
        print(f'Generated {config_file}')
    return config_name

if __name__ == '__main__':
    args = parse_args()
    mems_config_file = find_mems_config_file(args.chipyard_config_dir)
    print(f'Generating OpenRAM SRAMs based on {mems_config_file}')
    config_list = parse_mems_config_file(mems_config_file)
    sram_config_names = []
    for config in config_list:
        s_name = make_openram_freepdk45_sram_config_file(config)
        if not os.path.isfile(os.path.join(OPENRAM_CONFIG_DIR, f'../{s_name}.ok')):
            sram_config_names.append(s_name)
    if sram_config_names:
        os.system('cd OpenRAM/macros && make -j8 ' + ' '.join(sram_config_names))
    else:
        print('No new SRAMs to generate.')
