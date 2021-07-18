"""Assembles operating system information from the report."""
import yaml

class KernelGrubInfo(yaml.YAMLObject):
    """Assembles kernel boot information"""
    yaml_tag = u'KERNEL_GRUB_INFO'
    def __init__(self,grub_default, build_version, kernel_cmdline, grub_default_kernel_cmdline):
        self.grub_default = grub_default
        self.build_version = build_version
        self.kernel_cmdline = kernel_cmdline
        self.grub_default_kernel_cmdline = grub_default_kernel_cmdline

class Kernel(yaml.YAMLObject):
    """Assembles kernel information."""
    yaml_tag = u'!KERNEL'
    def __init__(self, booted_kernel, kernel_grub_info, taint_check):
        self.booted_kernel = booted_kernel
        self.kernel_grub_info = kernel_grub_info
        self.taint_check = taint_check

class OperatingSystemDistroInfo(yaml.YAMLObject):
    """Assembles distribution and package information"""
    yaml_tag = u'!OS_DISTRO'
    def __init__(self, distro, rhn, rhsm, yum):
        self.distro = distro
        self.rhn = rhn
        self.rhsm = rhsm
        self.yum = yum

class OperatingSystemKernelInfo(yaml.YAMLObject):
    """Assembles kernel, security, and runlevel information."""
    yaml_tag = u'!OS_KERNEL'
    def __init__(self, runlevel, selinux, arch, kernel):
        self.runlevel = runlevel
        self.selinux = selinux
        self.arch = arch
        self.kernel = kernel

class OperatingSystemTimeInfo(yaml.YAMLObject):
    """Assembles time-related information."""
    yaml_tag = u'!OS_TIME'
    def __init__(self, sys_time, boot_time, time_zone, uptime):
        self.sys_type = sys_time
        self.boot_time = boot_time
        self.time_zone = time_zone
        self.uptime = uptime

class OperatingSystemTimeAndTasksInfo(yaml.YAMLObject):
    """Assembles time-related, load average, and /proc/stat information."""
    yaml_tag = u'!OS_TIME_TASKS'
    def __init__(self, os_time_info, load_avg, proc_stat):
        self.os_time_info = os_time_info
        self.load_avg = load_avg
        self.proc_stat = proc_stat

class OperatingSystem(yaml.YAMLObject):
    """Assembles general operating system information."""
    yaml_tag = u'!OS'
    def __init__(self, hostname, os_distro_info, os_kernel_info, os_time_tasks):
        self.hostname = hostname
        self.os_distro_info = os_distro_info
        self.os_kernel_info = os_kernel_info
        self.os_time_tasks = os_time_tasks

def read_distribution_info(target_file):
    """Reads distribution and package information from the report."""
    distro = ""
    rhn = ""
    distro = target_file.readline().split(':')[1].strip()
    target_string = target_file.readline()
    while target_string.find(':') == -1:
        distro += ' ' + target_string.strip()
        target_string = target_file.readline()
    rhn = target_string.split(':')[1].strip()
    target_string = target_file.readline()
    while target_string.find(':') == -1:
        rhn += ' ' + target_string.strip()
        target_string = target_file.readline()
    rhsm = ""
    yum = ""
    rhsm = target_string.split(':')[1].strip()
    target_string = target_file.readline()
    while target_string.find(':') == -1:
        rhsm += target_string.strip()
        target_string = target_file.readline()
    yum = target_string.partition(':')[2].strip()
    return OperatingSystemDistroInfo(distro, rhn , rhsm, yum)

def read_kernel_info(target_file):
    """Reads kernel information from the report."""
    run_level = target_file.readline().split(':')[1].strip()
    selinux = target_file.readline().split(':')[1].strip()
    arch = target_file.readline().split(':')[1].strip()
    kernel = read_kernel(target_file)
    return OperatingSystemKernelInfo(run_level, selinux, arch, kernel)

def read_time_tasks(target_file):
    """Reads time and task-related information from the report."""
    sys_time = target_file.readline().split(':')[1].strip()
    boot_time = target_file.readline().split(':')[1].strip()
    time_zone = target_file.readline().split(':')[1].strip()
    uptime = target_file.readline().partition(':')[2].strip()
    load_avg = target_file.readline().split(':')[1].strip()
    proc_stat = ""
    target_string = target_file.readline().strip()
    while not target_string.isspace():
        proc_stat += target_string.strip()
        target_string = target_file.readline()
    time_info = OperatingSystemTimeInfo(sys_time, boot_time, time_zone, uptime)
    return OperatingSystemTimeAndTasksInfo(time_info, load_avg, proc_stat)

def read_operating_system(target_file):
    """Reads operating system information from the report."""
    target_file.readline()
    target_file.readline()
    hostname = target_file.readline().split(':')[1].strip()
    distro_info = read_distribution_info(target_file)
    kernel_info = read_kernel_info(target_file)
    time_tasks_info = read_time_tasks(target_file)
    return OperatingSystem(hostname, distro_info, kernel_info, time_tasks_info)

def read_kernel(target_file):
    """Reads kernel information from the report."""
    target_file.readline()
    booted_kernel = target_file.readline().split(':')[1].strip()
    grub_default = target_file.readline().split(':')[1].strip()
    build_version = ""
    booted_kernel_cmdline = ""
    grub_default_cmdline = ""
    taint_check = ""
    target_file.readline()
    build_version, booted_kernel_cmdline = read_multiple_lines(target_file,
    build_version, booted_kernel_cmdline, 'Booted kernel cmdline:')
    booted_kernel_cmdline, grub_default_cmdline = read_multiple_lines(target_file,
    booted_kernel_cmdline, grub_default_cmdline, 'GRUB default kernel cmdline:')
    grub_default_cmdline, taint_check = read_multiple_lines(target_file,
    grub_default_cmdline, taint_check, ':')
    target_string = target_file.readline()
    while target_string.find('- -') == -1:
        taint_check += target_string
        target_string = target_file.readline()
    kernel_grub_info = KernelGrubInfo(grub_default, build_version,
    booted_kernel_cmdline, grub_default_cmdline)
    return Kernel(booted_kernel, kernel_grub_info, taint_check)


def read_multiple_lines(target_file, target_variable, next_variable, separator):
    """Reads a variable that may be several lines long."""
    target_string = target_file.readline()
    while target_string.find(separator) == -1:
        target_variable += ' ' + target_string.strip()
        target_string = target_file.readline()
    next_variable = target_string.partition(separator)[2].strip()
    return target_variable, next_variable
