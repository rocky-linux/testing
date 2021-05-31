import yaml

class CpuStats(yaml.YAMLObject):
    yaml_tag = u'!CPU_STATS'
    def __init__(self, logical_processors, processors_desc, threads_cores):
        self.logical_processors = logical_processors
        self.processors_desc = processors_desc
        self.threads_cores = threads_cores

def read_cpu_stats(target_file):
    target_file.readline()
    logical_processors = target_file.readline().strip()
    processors_desc = target_file.readline().strip()
    threads_cores = target_file.readline().strip()
    return CpuStats(logical_processors, processors_desc, threads_cores)