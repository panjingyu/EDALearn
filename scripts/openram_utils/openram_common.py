#!/usr/bin/env python3

import os


def parse_mems_config_file(file_path):
    config_list = []
    with open(file_path, 'r') as f:
        for line in f:
            if line.startswith('name'):
                line_sp = line.rstrip('\n').rstrip(' ').split(' ')
                assert len(line_sp) % 2 == 0
                line_config = {}
                for i in range(len(line_sp) // 2):
                    line_config[line_sp[2*i]] = line_sp[2*i+1]
                config_list.append(line_config)
    return config_list

def get_sram_name(config):
    depth = int(config['depth'])
    width = int(config['width'])
    ports = config['ports']
    if ports.endswith('rw'):
        config_name = f'freepdk45_sram_1rw0r_{depth}x{width}'
    elif ports.endswith('write,read'):
        config_name = f'freepdk45_sram_1w1r_{depth}x{width}'
    else:
        raise ValueError(f'Unknown ports: {ports}')
    if 'mask_gran' in config:
        config_name += f'_{config["mask_gran"]}'
    return config_name

def find_mems_config_file(chipyard_config_dir):
    mems_configs = [x for x in os.listdir(chipyard_config_dir) if x.endswith('top.mems.conf')]
    assert len(mems_configs) == 1, f'Found {len(mems_configs)} mems config files: {mems_configs}, need double check'
    return os.path.join(chipyard_config_dir, mems_configs[0])
