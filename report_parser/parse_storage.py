"""Assembles storage information from the report."""
import re
import yaml

class WholeDisk(yaml.YAMLObject):
    """Assembles name and size of disks from the report."""
    yaml_tag = u'!WHOLE_DISK'
    def __init__(self, name, size_in_gb):
        self.name = name
        self.size_in_gb = size_in_gb

class StorageStats(yaml.YAMLObject):
    """Assembles partition information."""
    yaml_tag = u'!STORAGE'
    def __init__(self, disk_list, output_lsblk, output_df):
        self.disk_list = disk_list
        self.output_lsblk = output_lsblk
        self.output_df = output_df

def read_whole_disks(target_file):
    """Reads general disk information."""
    target_file.readline()
    target_file.readline()
    target_file.readline()
    target_file.readline()
    whole_disks = []
    find_alpha = r'\w+'
    find_digit = r'\d+'
    target_string = target_file.readline()
    while not target_string.isspace():
        disk_name = re.search(find_alpha, target_string).group(0)
        disk_size = re.search(find_digit, target_string).group(0)
        whole_disks.append(WholeDisk(disk_name, disk_size))
        target_string = target_file.readline()
    return whole_disks

def read_storage_stats(target_file):
    """Reads partition information."""
    target_file.readline()
    test_string = target_file.readline()
    if "STORAGE" in test_string:
        target_file.readline()
        whole_disks = read_whole_disks(target_file)
        target_file.readline()
        disk_layout_lsblk = ""
        filesystem_df = ""
        target_string = target_file.readline()
        while not target_string.isspace():
            disk_layout_lsblk += target_string
            target_string = target_file.readline()
        target_file.readline()
        target_string = target_file.readline()
        while not target_string.isspace():
            filesystem_df += target_string
            target_string = target_file.readline()
        return StorageStats(whole_disks, disk_layout_lsblk, filesystem_df)
    if "Whole" in test_string:
        whole_disks = read_whole_disks(target_file)
        target_file.readline()
        disk_layout_lsblk = ""
        filesystem_df = ""
        target_string = target_file.readline()
        while not target_string.isspace():
            disk_layout_lsblk += target_string
            target_string = target_file.readline()
        target_file.readline()
        target_string = target_file.readline()
        while not target_string.isspace():
            filesystem_df += target_string
            target_string = target_file.readline()
        return StorageStats(whole_disks, disk_layout_lsblk, filesystem_df)
    whole_disks = []
    return StorageStats(whole_disks, "", "")
