#!/usr/bin/env python3

import argparse
import os

from openram_common import *


OPENRAM_MACRO_DIR = 'OpenRAM/macros'
OPENRAM_CONFIG_DIR = OPENRAM_MACRO_DIR + '/configs'


def parse_args():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('--chipyard-config-dir', '-c', type=str, required=True,
                            help='Path to chipyard config directory')
    args = arg_parser.parse_args()
    return args

def find_module_interface(module_name, verilog_file):
    """Given a module name and a verilog file, find the interface of the module.
    Return a list of lines of the interface.
    """
    is_found = False
    interface_lines = []
    with open(verilog_file, 'r') as f:
        for line in f:
            if line.startswith('module ' + module_name):
                is_found = True
            if is_found:
                interface_lines.append(line)
                if line.startswith(');'):
                    break
    return interface_lines

def parse_mems_signal(line):
    line = line.rstrip(',\n').split(' ')
    line = [x for x in line if x != ''] # remove empty string
    return line[-1]

def compose_sram_verilog(mems_head, openram_sram_name):
    has_mask = len(openram_sram_name.split('_')) == 5
    is_nominal_mask = False
    if has_mask:
        mask_gran = int(openram_sram_name.split('_')[-1])
        width = int(openram_sram_name.split('_')[-2].split('x')[-1])
        has_mask = mask_gran < width
        is_nominal_mask = mask_gran == width
    head = ''.join(mems_head)
    head += openram_sram_name + ' mem_0 ('
    if '1rw0r' in openram_sram_name:
        connected_signals = [
            '  .clk0(RW0_clk),',
            '  .addr0(RW0_addr),',
            '  .wmask0(RW0_wmask),' if has_mask else '  // no wmask',
            '  .din0(RW0_wdata),',
            '  .dout0(RW0_rdata),',
            '  .csb0(~RW0_en),',
            '  .web0(~(RW0_wmode & RW0_wmask))' if is_nominal_mask else '  .web0(~RW0_wmode)',
        ]
    elif '1w1r' in openram_sram_name:
        connected_signals = [
            '  // Port 0: W',
            '  .clk0(W0_clk),',
            '  .addr0(W0_addr),',
            '  .din0(W0_data),',
            '  .csb0(~(W0_en & W0_mask)),' if is_nominal_mask else '  .csb0(~W0_en),',
            '  .wmask0(W0_mask),' if has_mask else '  // no wmask',
            '  // Port 1: R',
            '  .clk1(R0_clk),',
            '  .addr1(R0_addr),',
            '  .dout1(R0_data),',
            '  .csb1(~R0_en)',
        ]
    else:
        raise ValueError(f'Unsupported openram_sram_name: {openram_sram_name}')
    # check if the number of connected signals is correct
    n_connected = len([x for x in connected_signals if not x.startswith('  //')])
    if n_connected == len(mems_head) - 3 and is_nominal_mask:
        pass
    elif n_connected != len(mems_head) - 2:
        print('Warning: the number of connected signals is not correct')
        print('  mems_head:', ''.join(mems_head))
        print('  connected_signals:', '\n'.join(connected_signals))
        raise ValueError(f'Unsupported openram_sram_name: {openram_sram_name}')
    tail = ');\nendmodule\n'
    return '\n'.join([head] + connected_signals + [tail])


def main(mems_config_file):
    mems_config = parse_mems_config_file(mems_config_file)
    mems_verilog_file = mems_config_file[:-4] + 'v'
    assert os.path.isfile(mems_verilog_file), f'{mems_verilog_file} does not exist. '
    gen_verilog_file = os.path.join(os.path.dirname(mems_verilog_file),
                                    'freepdk45_autogen_openram_sram.v')
    gen_fd = open(gen_verilog_file, 'w')
    cnt, skip_cnt = 0, 0
    for mems in mems_config:
        # check if mems generated
        mems_head = find_module_interface(mems['name'], mems_verilog_file)
        openram_sram_name = get_sram_name(mems)
        print(openram_sram_name)
        if not os.path.isfile(os.path.join(OPENRAM_MACRO_DIR, openram_sram_name + '.ok')):
            print(f'Skip {mems["name"]}: not generated')
            skip_cnt += 1
            continue
        print('Found', os.path.join(OPENRAM_MACRO_DIR, openram_sram_name + '.ok'))
        s = compose_sram_verilog(mems_head, openram_sram_name)
        gen_fd.write(s)
        cnt += 1
    gen_fd.close()
    print(f'Generated {cnt} SRAMs in {gen_verilog_file}.')
    if skip_cnt:
        print(f'Skipped {skip_cnt} SRAMs, using their original version.')
    else:
        print('No SRAM skipped.')


if __name__ == '__main__':
    args = parse_args()
    mems_config_file = find_mems_config_file(args.chipyard_config_dir)
    main(mems_config_file)
