#!/usr/bin/env python3

from argparse import ArgumentParser
import os
import subprocess
import argparse

def is_root():
    return os.geteuid() == 0


def intx(string):
    """
    Generic integer type, will interpret string as string literal.
    Does the right thing for 0x1F, 0b10101, 010.
    """
    try:
        return int(string, 0)
    except (ValueError, TypeError):
        raise argparse.ArgumentTypeError(
            "Invalid integer value: {}".format(string)
        )


def argument_parser():
    parser = ArgumentParser()

    parser.add_argument(
        '--tunnel', dest='port', type=intx, default=None,
        help='Configure reverse ssh tunnel to lasso server using port "PORT" [default=%(default)r]')
    parser.add_argument(
        '--gps', dest='gps', action='store_true', default=False,
        help='Setup GPS module to update system time [default=%(default)r]')
    
    return parser

def main(options=None):
    if options is None:
        options = argument_parser().parse_args()

    if not is_root():
        print('Please run lasso-setup as root user. i.e. "sudo lasso-setup"')
        exit(1)

    setup_dir = os.path.dirname(os.path.realpath(__file__)) + '/'

    if options.port:
        subprocess.call([setup_dir + 'tunnel-setup.sh', str(options.port)])
        print('Reverse ssh tunnel setup is complete.')
    if options.gps:
        subprocess.call(setup_dir + 'gps-setup.sh')
        print('GPS module setup is complete')

    if options.port or options.gps:
        print('Please reboot system')
    else:
        print('No setup was performed. Plese see "lasso-setup --help" for usage')

    
if __name__ == '__main__':
    main()