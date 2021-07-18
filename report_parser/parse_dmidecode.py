"""Parses and stores data from the DMI decode section.

    Contains the classes:
        * Bios
        * UserSystem
        * Cpu
        * Memory
        * DmiDecode
    Contains the functions:
        * read_dmidecode(target_file)
"""
import yaml

class BiosRevisionData(yaml.YAMLObject):
    """Stores BIOS revision information."""
    yaml_tag = u'!BIOS_REVISION'
    def __init__(self, revision, fw_revision):
        self.revision = revision
        self.fw_revision = fw_revision

class Bios(yaml.YAMLObject):
    """Stores BIOS-related information."""
    yaml_tag = u'!BIOS'
    def __init__(self, vendor, version, date, revision_data):
        self.vendor = vendor
        self.version = version
        self.date = date
        self.revision_data = revision_data

class UserSystemIdentifiers(yaml.YAMLObject):
    """Stores identifying system information"""
    yaml_tag = u'!SYSTEM_IDS'
    def __init__(self, serial_number, uuid):
        self.serial_number = serial_number
        self.uuid = uuid

class UserSystem(yaml.YAMLObject):
    """Stores general system information."""
    yaml_tag = u'!SYSTEM'
    def __init__(self, manufacturer, prod, version, identifiers_data):
        self.manufacturer = manufacturer
        self.prod = prod
        self.version = version
        self.identifiers_data = identifiers_data

class CpuManufacturerInfo(yaml.YAMLObject):
    """Stores general CPU manufacturer information."""
    yaml_tag = u'!CPU_MANUFACTURER'
    def __init__(self, sct, manufacturer, family):
        self.sct = sct
        self.manufacturer = manufacturer
        self.family = family

class Cpu(yaml.YAMLObject):
    """Stores basic CPU information."""
    yaml_tag = u'!CPU'
    def __init__(self, cpu_manufacturer_info, frequency, version):
        self.cpu_manufacturer_info = cpu_manufacturer_info
        self.frequency = frequency
        self.version = version

class Memory(yaml.YAMLObject):
    """Stores general memory information."""
    yaml_tag = u'!Memory'
    def __init__(self, total_memory, dimms, max_capacity):
        self.total_memory = total_memory
        self.dimms = dimms
        self.max_capacity = max_capacity

class DmiDecode(yaml.YAMLObject):
    """Assembles sub-sections of the DMI_DECODE report."""
    yaml_tag = u'!DmiDecode'
    def __init__(self, bios, user_system, cpu, memory):
        self.bios = bios
        self.user_system = user_system
        self.cpu = cpu
        self.memory = memory

def read_bios_info(target_file):
    """Reads and parses BIOS information from the DMI_DECODE section."""
    vendor = target_file.readline().split(':')[1].strip()
    version = target_file.readline().split(':')[1].strip()
    date = target_file.readline().split(':')[1].strip()
    revision = target_file.readline().split(':')[1].strip()
    fw_revision = target_file.readline().split(':')[1].strip()
    bios_revision_data = BiosRevisionData(revision, fw_revision)
    return Bios(vendor, version, date, bios_revision_data)

def read_user_system(target_file):
    """Reads and parses system information from the DMI_DECODE section."""
    manufacturer = target_file.readline().split(':')[1].strip()
    prod = target_file.readline().split(':')[1].strip()
    sys_version = target_file.readline().split(':')[1].strip()
    serial_num = target_file.readline().split(':')[1].strip()
    if serial_num[0] == '\u28FF':
        serial_num = 'SCRUBBED'
    uuid = target_file.readline().split(':')[1].strip()
    if uuid[0] == '\u28FF':
        uuid = 'SCRUBBED'
    user_system_ids = UserSystemIdentifiers(serial_num, uuid)
    return UserSystem(manufacturer, prod, sys_version, user_system_ids)

def read_cpu_information(target_file):
    """Reads and parses CPU information from the DMI_DECODE section."""
    sct = target_file.readline().strip() + ' ' + target_file.readline().strip()
    cpu_manufacturer = target_file.readline().split(':')[1].strip()
    cpu_family = target_file.readline().split(':')[1].strip()
    frequency = target_file.readline().split(':')[1].strip()
    cpu_version = target_file.readline().split(':')[1].strip()
    cpu_manufacturer_info = CpuManufacturerInfo(sct, cpu_manufacturer, cpu_family)
    return Cpu(cpu_manufacturer_info, frequency, cpu_version)

def read_memory_information(target_file):
    """Reads and parses memory information from the DMI_DECODE section."""
    total_memory = target_file.readline().split(':')[1].strip()
    dimms = target_file.readline().split(':')[1].strip()
    max_capacity = target_file.readline().split(':')[1].strip()
    return Memory(total_memory, dimms, max_capacity)

def read_dmidecode(target_file):
    """Reads and parses the DMI_DECODE section of the report."""
    target_file.readline()
    target_file.readline()
    input_bios = read_bios_info(target_file)
    target_file.readline()
    user_system = read_user_system(target_file)
    target_file.readline()
    cpu = read_cpu_information(target_file)
    target_file.readline()
    memory = read_memory_information(target_file)
    return DmiDecode(input_bios, user_system, cpu, memory)
