"""Reads and parses the ETHTOOL section of the report."""
import yaml

class Ethtool(yaml.YAMLObject):
    """Stores interface status and error information."""
    yaml_tag = u'!ETHTOOL'
    def __init__(self, interface_status, interface_errors):
        self.interface_status = interface_status
        self.interface_errors = interface_errors

def read_ethtool(target_file):
    """Reads and parses interface information."""
    interface_status = []
    interface_errors = []
    test_line = target_file.readline()
    if "ETHTOOL" in test_line or "Interface" in test_line:
        target_file.readline()
        target_string = target_file.readline().strip()
        while target_string != "Interface Errors:":
            interface_status.append(target_string)
            target_string = target_file.readline().strip()
        target_string = target_file.readline().strip()
        while target_string != '':
            if target_string.find('- -') == -1:
                interface_errors.append(target_string)
            target_string = target_file.readline().strip()
        return Ethtool(interface_status, interface_errors)
    return Ethtool(interface_status, interface_errors)
