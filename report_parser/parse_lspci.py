import yaml

class Lspci(yaml.YAMLObject):
    yaml_tag = u'!LSPCI'
    def __init__(self, net, storage, vga):
        self.net = net
        self.storage = storage
        self.vga = vga

def read_lspci(target_file):
    target_file.readline()
    target_file.readline()
    net = []
    storage = []
    vga = []
    target_string = target_file.readline().strip()
    while target_string != "Storage:":
        net.append(target_string)
        target_string = target_file.readline().strip()
    target_string = target_file.readline().strip()
    while target_string != "VGA:":
        storage.append(target_string)
        target_string = target_file.readline().strip()
    target_string = target_file.readline().strip()
    while target_string.isspace() == False:
        vga.append(target_string)
        target_string = target_file.readline()
    return Lspci(net, storage, vga)
