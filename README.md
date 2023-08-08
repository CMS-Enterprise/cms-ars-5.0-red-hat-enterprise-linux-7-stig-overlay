# cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay
InSpec profile overlay to validate the secure configuration of Red Hat Enterprise Linux 7 against [DISA's](https://iase.disa.mil/stigs/Pages/index.aspx) Red Hat Enterprise Linux 7 STIG Version 3 Release 10 tailored for CMS ARS 5.0.

## Getting Started  
### InSpec (CINC-auditor) setup
For maximum flexibility/accessibility, we’re moving to “cinc-auditor”, the open-source packaged binary version of Chef InSpec, compiled by the CINC (CINC Is Not Chef) project in coordination with Chef using Chef’s always-open-source InSpec source code. For more information: https://cinc.sh/

It is intended and recommended that CINC-auditor and this profile overlay be run from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target. This can be any Unix/Linux/MacOS or Windows runner host, with access to the Internet.

__For the best security of the runner, always install on the runner the _latest version_ of CINC-auditor.__ 

__The simplest way to install CINC-auditor is to use this command for a UNIX/Linux/MacOS runner platform:__
```
curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-auditor
```

__or this command for Windows runner platform (Powershell):__
```
. { iwr -useb https://omnitruck.cinc.sh/install.ps1 } | iex; install -project cinc-auditor
```
To confirm successful install of cinc-auditor:
```
cinc-auditor -v
```
> sample output:  _4.24.32_

Latest versions and other installation options are available at https://cinc.sh/start/auditor/.

## Specify your BASELINE system categization as an environment variable:
### (if undefined defaults to Moderate baseline)

```
# BASELINE (choices: Low, Low-HVA, Moderate, Moderate-HVA, High, High-HVA)
# (if undefined defaults to Moderate baseline)

on linux:
BASELINE=Moderate

on Powershell:
$env:BASELINE="Moderate"
```

## Tailoring to Your Environment

The following inputs may be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```
# Used by InSpec checks SV-204392, SV-204478, SV-214799
# InSpec Tests that are known to consistently have long run times can be disabled with this attribute
# Acceptable values: false, true
# (default: false)
disable_slow_controls: 

# Used by InSpec check SV-204392
# list of system files that should be allowed to change from an rpm verify point of view
rpm_verify_perms_except: []

# Used by InSpec check SV-214799
# list of system files that should be allowed to change from an rpm verify point of view
rpm_verify_integrity_except: []

# Used by InSpec check SV-204575 (default: false)
# Do NOT set to 'true' UNLESS the server is documented as being used as a log aggregation server. 
log_aggregation_server: 

# Used by InSpec check SV-204624 (default: false)
# Do NOT set to 'true' UNLESS use of X Windows System is documented and approved. 
x11_enabled: 

# Accounts of known managed users (Array)
user_accounts: []

# System accounts that support approved system activities. (Array) (defaults shown below)
known_system_accounts: []

# Name of tool
file_integrity_tool: ''

# Interval to run the file integrity tool (monthly, weekly, or daily).
file_integrity_interval: ''

# Used by InSpec checks SV-204498 SV-204499 SV-204500 (default: "/etc/aide.conf")
# Path to the aide.conf file
aide_conf_path:

# SV-204441, SV-204631, SV-204633
# (enabled or disabled)
smart_card_status: "enabled"

# SV-204489, SV-204574
# The path to the logging package
log_pkg_paths: "/etc/rsyslog.conf"

# SV-204467, SV-204468, SV-204469, SV-204470, SV-204471, SV-204472, SV-204473
# SV-204474, SV-204475, SV-204476, SV-204477, SV-204478, SV-204493
# Users exempt from home directory-based controls in array format
exempt_home_users: []

# SV-244557
# main grub boot config file
grub_main_cfg: ""

# Main grub boot config file
grub_uefi_main_cfg: ''

# grub boot config files
grub_user_boot_files: []

# SV-204444
# system accounts that support approved system activities
admin_logins: []

# The list of packages needed for MFA on RHEL
mfa_pkg_list: []

# SV-204397
# should dconf have smart card authentication (e.g., true or false <- no quotes!)
multifactor_enabled: true

# These shells do not allow a user to login
non_interactive_shells: []

# File systems that don't correspond to removable media
non_removable_media_fs: []

# SV-204629
# approved configured tunnels prepended with word 'conn'
# Example: ['conn myTunnel']
approved_tunnels: []

# SV-204479
# Is the target expected to be a virtual machine
virtual_machine: false

# Services that firewalld should be configured to allow.
firewalld_services: []

# Hosts that firewalld should be configured to allow.
firewalld_hosts_allow: []

# Hosts that firewalld should be configured to deny.
firewalld_hosts_deny: []

# Ports that firewalld should be configured to allow.
firewalld_ports_allow: []

# Ports that firewalld should be configured to deny.
firewalld_ports_deny: {}

# Allow rules from etc/hosts.allow.
tcpwrappers_allow: {}

# Deny rules from etc/hosts.deny.
tcpwrappers_deny: {}

# Iptable rules that should exist.
iptables_rules: []

# Services that firewalld should be configured to deny.
firewalld_services_deny: {}

# Zones that should be present on the system.
firewalld_zones: []

# Whether an antivirus solution, other than nails, is in use.
custom_antivirus: false

# Description of custom antivirus solution, when in use.
custom_antivirus_description: ''

```

## Running This Overlay Directly from Github

Against a remote target using ssh with escalated privileges (i.e., cinc-auditor installed on a separate runner host)
```bash
cinc-auditor exec https://github.com/CMS-Enterprise/cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay/archive/main.tar.gz -t ssh://TARGET_USERNAME:TARGET_PASSWORD@TARGET_IP:TARGET_PORT --sudo --sudo-password=<SUDO_PASSWORD_IF_REQUIRED> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```

Against a remote target using a pem key with escalated privileges (i.e., cinc-auditor installed on a separate runner host)
```bash
cinc-auditor exec https://github.com/CMS-Enterprise/cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay/archive/main.tar.gz -t ssh://TARGET_USERNAME@TARGET_IP:TARGET_PORT --sudo -i <your_PEM_KEY> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json>  
```

Against a local Red Hat host with escalated privileges (i.e., cinc-auditor installed on the target)
```bash
sudo cinc-auditor exec https://github.com/CMS-Enterprise/cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay/archive/main.tar.gz --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```
### Different Run Options

  [Full exec options](https://docs.chef.io/inspec/cli/#options-3)

## Running This Overlay from a local Archive copy
If your runner is not always expected to have direct access to GitHub, use the following steps to create an archive bundle of this overlay and all of its dependent tests:

(Git is required to clone the InSpec profile using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site.) 

```
mkdir profiles
cd profiles
git clone https://github.com/CMS-Enterprise/cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay.git
cinc-auditor archive cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay
sudo cinc-auditor exec <name of generated archive> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```

For every successive run, follow these steps to always have the latest version of this overlay and dependent profiles:

```
cd cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay
git pull
cd ..
cinc-auditor archive cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay --overwrite
sudo cinc-auditor exec <name of generated archive> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```

## Using Heimdall for Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://heimdall-lite.cms.gov/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/CMS-Enterprise/heimdall2)__, allowing for additional functionality such as to store and compare multiple profile runs.

## Authors
* Sumaa Sayed
* Shivani Karikar
* Raheel Aziz

## Special Thanks
* Eugene Aronne
* Will Dower

## Contributing and Getting Help
To report a bug or feature request, please open an [issue](https://github.com/CMS-Enterprise/cms-ars-5.0-red-hat-enterprise-linux-7-stig-overlay/issues/new).

### NOTICE
© 2023 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE 

MITRE grants permission to reproduce, distribute, modify, and otherwise use this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.
 
This software was produced by The MITRE Corporation for the U. S. Government under contract. As such the U.S. Government has certain use and data rights in this software. No use other than those granted to the U. S. Government, or to those acting on behalf of the U. S. Government, under these contract arrangements is authorized without the express written permission of The MITRE Corporation.
 
For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.

DISA STIGs are published at: https://public.cyber.mil/stigs/