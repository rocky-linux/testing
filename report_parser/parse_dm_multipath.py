"""Reads and parses the DM_MULTIPATH section of the report."""
import yaml

class DmMultipath(yaml.YAMLObject):
    """Stores information from the DM_MULTIPATH section."""
    yaml_tag = u'!DM_MULTIPATH'
    def __init__(self, path):
        self.path = path

def parse_dm_multipath(target_file):
    """Parses the DM_MULTIPATH section."""
    path = ""
    title = target_file.readline()
    if title == "DM-MULTIPATH":
        target_string = target_file.readline()
        while target_string.isspace() is False:
            path += target_string.strip()
            target_string = target_file.readline()
    return DmMultipath(path)
