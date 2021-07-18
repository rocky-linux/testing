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
    target_file.readline()
    target_file.readline()
    net = []
    storage = []
    vga = []
    target_string = target_file.readline().strip()
    while target_string.find("Storage:") == -1:
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
    return Lspci(net, storage, vga)
