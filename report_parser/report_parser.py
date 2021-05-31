#!/usr/bin/python3

from os import read, write
import yaml
import re
import sys
import parse_dmidecode
import parse_operating_system
import parse_cpu
import parse_memory
import parse_storage
import parse_dm_multipath
import parse_lspci
import parse_ethtool

def test_dmidecode():
    test_dmi = parse_dmidecode.read_dmidecode(open('test.out'))
    yaml.dump(test_dmi, open('output.yaml', 'w'))

def test_read_operating_system():
    target_file = open('test.out')
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    target_output = open('output.yaml', 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)

def test_read_cpu_stats():
    target_file = open('test.out')
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    test_cpu_stats = parse_cpu.read_cpu_stats(target_file)
    target_output = open('output.yaml', 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)
    yaml.dump(test_cpu_stats, target_output)

def test_read_memory_stats():
    target_file = open('test.out')
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    test_cpu_stats = parse_cpu.read_cpu_stats(target_file)
    test_memory_stats = parse_memory.read_memory_stats(target_file)
    target_output = open('output.yaml', 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)
    yaml.dump(test_cpu_stats, target_output)
    yaml.dump(test_memory_stats, target_output)

def test_read_storage_stats():
    target_file = open('test.out')
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    test_cpu_stats = parse_cpu.read_cpu_stats(target_file)
    test_memory_stats = parse_memory.read_memory_stats(target_file)
    test_storage_stats = parse_storage.read_storage_stats(target_file)
    target_output = open('output.yaml', 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)
    yaml.dump(test_cpu_stats, target_output)
    yaml.dump(test_memory_stats, target_output)
    yaml.dump(test_storage_stats, target_output)

def test_read_dm_multipath():
    target_file = open('test.out')
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    test_cpu_stats = parse_cpu.read_cpu_stats(target_file)
    test_memory_stats = parse_memory.read_memory_stats(target_file)
    test_storage_stats = parse_storage.read_storage_stats(target_file)
    test_dm_multipath = parse_dm_multipath.parse_dm_multipath(target_file)
    target_output = open('output.yaml', 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)
    yaml.dump(test_cpu_stats, target_output)
    yaml.dump(test_memory_stats, target_output)
    yaml.dump(test_storage_stats, target_output)
    yaml.dump(test_dm_multipath, target_output)

def test_read_lspci():
    target_file = open('test.out')
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    test_cpu_stats = parse_cpu.read_cpu_stats(target_file)
    test_memory_stats = parse_memory.read_memory_stats(target_file)
    test_storage_stats = parse_storage.read_storage_stats(target_file)
    test_dm_multipath = parse_dm_multipath.parse_dm_multipath(target_file)
    test_lspci = parse_lspci.read_lspci(target_file)
    target_output = open('output.yaml', 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)
    yaml.dump(test_cpu_stats, target_output)
    yaml.dump(test_memory_stats, target_output)
    yaml.dump(test_storage_stats, target_output)
    yaml.dump(test_dm_multipath, target_output)
    yaml.dump(test_lspci, target_output)

def test_read_ethtool():
    target_file = open('test.out')
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    test_cpu_stats = parse_cpu.read_cpu_stats(target_file)
    test_memory_stats = parse_memory.read_memory_stats(target_file)
    test_storage_stats = parse_storage.read_storage_stats(target_file)
    test_dm_multipath = parse_dm_multipath.parse_dm_multipath(target_file)
    test_lspci = parse_lspci.read_lspci(target_file)
    test_ethtool = parse_ethtool.read_ethtool(target_file)
    target_output = open('output.yaml', 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)
    yaml.dump(test_cpu_stats, target_output)
    yaml.dump(test_memory_stats, target_output)
    yaml.dump(test_storage_stats, target_output)
    yaml.dump(test_dm_multipath, target_output)
    yaml.dump(test_lspci, target_output)
    yaml.dump(test_ethtool, target_output)

def read_entire_file(input_filename, output_filename):
    target_file = open(input_filename)
    test_dmi = parse_dmidecode.read_dmidecode(target_file)
    test_os = parse_operating_system.read_operating_system(target_file)
    test_cpu_stats = parse_cpu.read_cpu_stats(target_file)
    test_memory_stats = parse_memory.read_memory_stats(target_file)
    test_storage_stats = parse_storage.read_storage_stats(target_file)
    test_dm_multipath = parse_dm_multipath.parse_dm_multipath(target_file)
    test_lspci = parse_lspci.read_lspci(target_file)
    test_ethtool = parse_ethtool.read_ethtool(target_file)
    target_output = open(output_filename, 'w')
    yaml.dump(test_dmi, target_output)
    yaml.dump(test_os, target_output)
    yaml.dump(test_cpu_stats, target_output)
    yaml.dump(test_memory_stats, target_output)
    yaml.dump(test_storage_stats, target_output)
    yaml.dump(test_dm_multipath, target_output)
    yaml.dump(test_lspci, target_output)
    yaml.dump(test_ethtool, target_output)

def main():
    read_entire_file(sys.argv[1], sys.argv[2])

if __name__ == "__main__":
    main()