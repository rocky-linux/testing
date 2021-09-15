"""Reads and parses lscpi information from the report."""
import yaml

class Lspci(yaml.YAMLObject):
    """Stores information from the lspci section."""
    yaml_tag = u'!LSPCI'
    def __init__(self, net, storage, vga):
        self.net = net
        self.storage = storage
        self.vga = vga

def read_lspci(target_file):
    """Parses the lspci section of the report."""
    test_line = target_file.readline()
    if "LSPCI" in test_line or "Net" in test_line:
        net = []
        storage = []
        vga = []
        target_string = target_file.readline().strip()
        while "Storage" not in target_string:
            if "Net:" not in target_string:
                net.append(target_string)
            target_string = target_file.readline().strip()
        target_string = target_file.readline().strip()
        while target_string != "VGA:":
            storage.append(target_string)
            target_string = target_file.readline().strip()
        target_string = target_file.readline()
        while target_string.isspace() is False:
            vga.append(target_string)
            target_string = target_file.readline()
            if target_string == '':
                break
        return Lspci(net, storage, vga)
    net = []
    storage = []
    vga = []
    return Lspci(net, storage, vga)
