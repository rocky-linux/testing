import yaml

class DmMultipath(yaml.YAMLObject):
    yaml_tag = u'!DM_MULTIPATH'
    def __init__(self, path):
        self.path = path

def parse_dm_multipath(target_file):
    path = ""
    target_file.readline()
    target_string = target_file.readline()
    while target_string.isspace() == False:
        path += target_string.strip()
        target_string = target_file.readline()
    return DmMultipath(path)