import yaml

class Bios(yaml.YAMLObject):
    yaml_tag = u'!BIOS'
    def __init__(self, vendor, version, date, revision, fw_revision):
        self.vendor = vendor
        self.version = version
        self.date = date
        self.revision = revision
        self.fw_revision = fw_revision

class UserSystem(yaml.YAMLObject):
    yaml_tag = u'!SYSTEM'
    def __init__(self, manufacturer, prod, version, serial_number, uuid):
        self.manufacturer = manufacturer
        self.prod = prod
        self.version = version
        self.serial_number = serial_number
        self.uuid = uuid

class Cpu(yaml.YAMLObject):
    yaml_tag = u'!CPU'
    def __init__(self, sct, manufacturer, family, frequency, version):     
        self.sct = sct
        self.manufacturer = manufacturer
        self.family = family
        self.frequency = frequency
        self.version = version


class Memory(yaml.YAMLObject):
    yaml_tag = u'!Memory'
    def __init__(self, total_memory, dimms, max_capacity):
        self.total_memory = total_memory
        self.dimms = dimms
        self.max_capacity = max_capacity

class DmiDecode(yaml.YAMLObject):
    yaml_tag = u'!DmiDecode'
    def __init__(self, bios, user_system, cpu, memory):
        self.bios = bios
        self.user_system = user_system
        self.cpu = cpu
        self.memory = memory

def read_dmidecode(target_file):
    target_file.readline()
    target_file.readline()
    vendor = target_file.readline().split(':')[1].strip()
    version = target_file.readline().split(':')[1].strip()
    date = target_file.readline().split(':')[1].strip()
    revision = target_file.readline().split(':')[1].strip()
    fw_revision = target_file.readline().split(':')[1].strip()
    input_bios = Bios(vendor, version, date, revision, fw_revision)
    target_file.readline()
    manufacturer = target_file.readline().split(':')[1].strip()
    prod = target_file.readline().split(':')[1].strip()
    sys_version = target_file.readline().split(':')[1].strip()
    serial_num = target_file.readline().split(':')[1].strip()
    if serial_num[0] == '\u28FF':
        serial_num = 'SCRUBBED'
    uuid = target_file.readline().split(':')[1].strip()
    if uuid[0] == '\u28FF':
        uuid = 'SCRUBBED'
    user_system = UserSystem(manufacturer, prod, sys_version, serial_num, uuid)
    target_file.readline()
    sct = target_file.readline().strip() + ' ' + target_file.readline().strip()
    cpu_manufacturer = target_file.readline().split(':')[1].strip()
    cpu_family = target_file.readline().split(':')[1].strip()
    frequency = target_file.readline().split(':')[1].strip()
    cpu_version = target_file.readline().split(':')[1].strip()
    cpu = Cpu(sct, cpu_manufacturer, cpu_family, frequency, cpu_version)
    target_file.readline()
    total_memory = target_file.readline().split(':')[1].strip()
    dimms = target_file.readline().split(':')[1].strip()
    max_capacity = target_file.readline().split(':')[1].strip()
    memory = Memory(total_memory, dimms, max_capacity)
    return DmiDecode(input_bios, user_system, cpu, memory)