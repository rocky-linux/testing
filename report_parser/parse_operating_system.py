import yaml

class Kernel(yaml.YAMLObject):
    yaml_tag = u'!Kernel'
    def __init__(self, booted_kernel, grub_default, build_version, kernel_cmdline, grub_default_kernel_cmdline,
                taint_check):
                self.booted_kernel = booted_kernel
                self.grub_default = grub_default
                self.build_version = build_version
                self.kernel_cmdline = kernel_cmdline
                self.grub_default_kernel_cmdline = grub_default_kernel_cmdline
                self.taint_check = taint_check

class OperatingSystem(yaml.YAMLObject):
    yaml_tag = u'!OS'
    def __init__(self, hostname, distro, rhn, rhsm, yum, runlevel, selinux, arch, kernel, sys_time, boot_time,
                time_zone, uptime, load_avg, proc_stat):
                self.hostname = hostname
                self.distro = distro
                self.rhn = rhn
                self.rhsm = rhsm
                self.yum = yum
                self.runlevel = runlevel
                self.selinux = selinux
                self.arch = arch
                self.kernel = kernel
                self.sys_type = sys_time
                self.boot_time = boot_time
                self.time_zone = time_zone
                self.uptime = uptime
                self.load_avg = load_avg
                self.proc_stat = proc_stat 

def read_operating_system(target_file):
    target_file.readline()
    target_file.readline()
    hostname = target_file.readline().split(':')[1].strip()
    distro = ""
    rhn = ""
    distro = target_file.readline().split(':')[1].strip()
    target_string = target_file.readline()
    while target_string.find(':') == -1:
        distro += ' ' + target_string.strip()
        target_string = target_file.readline()
    
    rhn = target_string.split(':')[1].strip()
    rhsm = ""
    yum = ""
    rhsm = target_file.readline().split(':')[1].strip()
    target_string = target_file.readline()
    while target_string.find(':') == -1:
        rhsm += target_string.strip()
        target_string = target_file.readline()
    
    yum = target_string.partition(':')[2].strip()
    run_level = target_file.readline().split(':')[1].strip()
    selinux = target_file.readline().split(':')[1].strip()
    arch = target_file.readline().split(':')[1].strip()
    kernel = read_kernel(target_file)
    sys_time = target_file.readline().split(':')[1].strip()
    boot_time = target_file.readline().split(':')[1].strip()
    time_zone = target_file.readline().split(':')[1].strip()
    uptime = target_file.readline().partition(':')[2].strip()
    load_avg = target_file.readline().split(':')[1].strip()
    proc_stat = ""
    target_string = target_file.readline().strip()
    while target_string.isspace() == False:
        proc_stat += target_string.strip()
        target_string = target_file.readline()
    return OperatingSystem(hostname, distro, rhn, rhsm, yum, run_level, selinux, arch, kernel, sys_time, boot_time, time_zone, uptime, load_avg, proc_stat)

def read_kernel(target_file):
    target_file.readline()
    booted_kernel = target_file.readline().split(':')[1].strip()
    grub_default = target_file.readline().split(':')[1].strip()
    build_version = ""
    booted_kernel_cmdline = ""
    grub_default_cmdline = ""
    taint_check = ""
    target_file.readline()
    build_version, booted_kernel_cmdline = read_multiple_lines(target_file, build_version, booted_kernel_cmdline, 'Booted kernel cmdline:')
    booted_kernel_cmdline, grub_default_cmdline = read_multiple_lines(target_file, booted_kernel_cmdline, grub_default_cmdline, 'GRUB default kernel cmdline:')
    grub_default_cmdline, taint_check = read_multiple_lines(target_file, grub_default_cmdline, taint_check, ':')
    target_string = target_file.readline()
    while target_string.find('- -') == -1:
        taint_check += target_string
        target_string = target_file.readline()
    return Kernel(booted_kernel, grub_default, build_version, booted_kernel_cmdline, grub_default_cmdline, taint_check)


def read_multiple_lines(target_file, target_variable, next_variable, separator):
    target_string = target_file.readline()
    while target_string.find(separator) == -1:
            target_variable += ' ' + target_string.strip()
            target_string = target_file.readline()
    next_variable = target_string.partition(separator)[2].strip()
    return target_variable, next_variable