import yaml
import re

class WholeDisk(yaml.YAMLObject):
    yaml_tag = u'!WHOLE_DISK'
    def __init__(self, name, size_in_gb):
        self.name = name
        self.size_in_gb = size_in_gb

class StorageStats(yaml.YAMLObject):
    yaml_tag = u'!STORAGE'
    def __init__(self, disk_list, output_lsblk, output_df):
        self.disk_list = disk_list
        self.output_lsblk = output_lsblk
        self.output_df = output_df

def read_whole_disks(target_file):
    target_file.readline()
    target_file.readline()
    target_file.readline()
    target_file.readline()
    target_file.readline()
    target_file.readline()
    target_file.readline()
    whole_disks = []
    find_alpha = r'\w+'
    find_digit = r'\d+'
    target_string = target_file.readline()
    while target_string.isspace() == False:
        disk_name = re.search(find_alpha, target_string).group(0)
        disk_size = re.search(find_digit, target_string).group(0)
        whole_disks.append(WholeDisk(disk_name, disk_size))
        target_string = target_file.readline()
    return whole_disks

def read_storage_stats(target_file):
    whole_disks = read_whole_disks(target_file)
    target_file.readline()
    disk_layout_lsblk = ""
    filesystem_df = ""
    target_string = target_file.readline()
    while target_string.isspace() == False:
        disk_layout_lsblk += target_string
        target_string = target_file.readline()
    target_file.readline()
    target_string = target_file.readline()
    while target_string.isspace() == False:
        filesystem_df += target_string
        target_string = target_file.readline()
    return StorageStats(whole_disks, disk_layout_lsblk, filesystem_df)
