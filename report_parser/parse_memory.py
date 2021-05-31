import yaml
import re

class MemoryStats(yaml.YAMLObject):
    yaml_tag = u'!MEMORY_STATS'
    def __init__(self, warnings, stats_graph, ram_stats, huge_pages, thp, slab, page_tables, shmem, swap):
        self.warnings = warnings
        self.stats_graph = stats_graph
        self.ram_stats = ram_stats
        self.huge_pages = huge_pages
        self.thp = thp
        self.slab = slab
        self.page_tables = page_tables
        self.shmem = shmem
        self.swap = swap

class StatsGraph(yaml.YAMLObject):
    yaml_tag = u'!STATS_GRAPH'
    def __init__(self, mem_used, buffers, cached, huge_pages, dirty):
        self.mem_used = mem_used
        self.buffers = buffers
        self.cached = cached
        self.huge_pages = huge_pages
        self.dirty = dirty

class RamStats(yaml.YAMLObject):
    yaml_tag = u'!RAM_STATS'
    def __init__(self, total_ram, used_ram, used_excluding_buffers, dirty):
        self.total_ram = total_ram
        self.used_ram = used_ram
        self.used_excluding_buffers = used_excluding_buffers
        self.dirty = dirty

def read_memory_stats(target_file):
    target_file.readline()
    target_file.readline()
    target_string = target_file.readline()
    warnings = ""
    if target_string.find("WARNING") != -1:
        warnings = target_string.split(':')[1].strip() + ' ' + target_file.readline().strip()
        target_file.readline()
    else:
        warnings = ""
    memory_graph = read_memory_graph(target_file)
    ram_stats = read_ram_stats(target_file)
    target_file.readline()
    huge_pages = target_file.readline().strip()
    target_file.readline()
    thp = target_file.readline().strip()
    target_file.readline()
    slab = target_file.readline().strip()
    page_tables = target_file.readline().strip()
    shmem = target_file.readline().strip()
    target_file.readline()
    swap = target_file.readline().strip()
    return MemoryStats(warnings, memory_graph, ram_stats, huge_pages, thp, slab, page_tables, shmem, swap)

def read_memory_graph(target_file):
    percentage_expression_string = r'\d{1,3}\.\d\%'
    mem_used = re.search(percentage_expression_string, target_file.readline()).group(0)
    buffers = re.search(percentage_expression_string, target_file.readline()).group(0)
    cached = re.search(percentage_expression_string, target_file.readline()).group(0)
    huge_pages = re.search(percentage_expression_string, target_file.readline()).group(0)
    dirty = re.search(percentage_expression_string, target_file.readline()).group(0)
    return StatsGraph(mem_used, buffers, cached, huge_pages, dirty)


def read_ram_stats(target_file):
    target_file.readline()
    total_ram = target_file.readline().strip()
    used_ram = target_file.readline().strip()
    used_excluding_buffers = target_file.readline().strip()
    dirty = target_file.readline().strip()
    return RamStats(total_ram, used_ram, used_excluding_buffers, dirty)