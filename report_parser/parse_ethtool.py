import yaml

class Ethtool(yaml.YAMLObject):
    yaml_tag = u'!ETHTOOL'
    def __init__(self, interface_status, interface_errors):
        self.interface_status = interface_status
        self.interface_errors = interface_errors

def read_ethtool(target_file):
    interface_status = []
    interface_errors = []
    target_file.readline()
    target_file.readline()
    target_string = target_file.readline().strip()
    while target_string != "Interface Errors:":
        interface_status.append(target_string)
        target_string = target_file.readline().strip()
    target_string = target_file.readline()
    while target_string.isspace() == False:
        interface_errors.append(target_string)
        target_string = target_file.readline()
    return Ethtool(interface_status, interface_errors)