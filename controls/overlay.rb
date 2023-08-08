# encoding: utf-8
overlay_controls = input('overlay_controls')
system_categorization = input('system_categorization')

include_controls 'redhat-enterprise-linux-7-stig-baseline' do

  ## NIST tags updated due to changes between NIST SP 800-53 rev 4 and rev 5 (https://csrc.nist.gov/csrc/media/Publications/sp/800-53/rev-5/final/documents/sp800-53r4-to-r5-comparison-workbook.xlsx)

  ## IA-2(6) incorporates withdrawn control IA-2(11)
  control 'SV-204397' do
    tag nist: ['IA-2 (6)', 'IA-2 (12)', 'IA-2 (12)']
  end

  control 'SV-204631' do
    tag nist: ['IA-2 (6)', 'IA-2 (12)', 'IA-2 (12)']
  end

  control 'SV-204632' do
    tag nist: ['IA-2 (6)', 'IA-2 (12)', 'IA-2 (12)']
  end

  control 'SV-204633' do
    tag nist: ['IA-2 (6)', 'IA-2 (12)', 'IA-2 (12)']
  end

  ## AC-2(3) incorporates withdrawn control IA-4 e
  control 'SV-204426' do
    tag nist: ['AC-2 (3)']
  end

  ## CM-14 incorporates withdrawn control CM-5 (3)
  control 'SV-204447' do
    tag nist: ['CM-14']
  end

  control 'SV-204448' do
    tag nist: ['CM-14']
  end

  control 'SV-214799' do
    tag nist: ['CM-14']
  end
  
  ## SC-45 (1) incorporates withdrawn control AU-8 (1)
  control 'SV-204603' do
    tag nist: ['SC-45 (1)']
  end

  ## SEMANTIC CHANGES

  control 'SV-204577' do
    title 'The Red Hat Enterprise Linux operating system must be configured to prohibit or restrict the use of
      functions, ports, protocols, and/or services.'
     desc 'check', 'Inspect the firewall configuration and running services to verify that it is configured to prohibit
      or restrict the use of functions, ports, protocols, and/or services that are unnecessary or prohibited.
      Check which services are currently active with the following command:
      # firewall-cmd --list-all
      public (default, active)
      interfaces: enp0s3
      sources:
      services: dhcpv6-client dns http https ldaps rpc-bind ssh
      ports:
      masquerade: no
      forward-ports:
      icmp-blocks:
      rich rules:
      Verify the services allowed by the firewall match what is permitted by CMS.
      If there are additional ports, protocols, or services that are not permitted, or there are ports, protocols,
      or services that are prohibited by CMS, this is a finding.'
    desc 'fix', "Update the host's firewall settings and/or running services to comply with the CMS requirements."
  end
    
  control 'SV-204603' do
    title "The Red Hat Enterprise Linux operating system must, for networked systems, synchronize clocks with a server
    that is synchronized to one of the redundant United States Naval Observatory (USNO) time servers, a time server
    designated for the appropriate #{input('org_name')[:acronym]} network."
  end

  unless overlay_controls.empty?
    overlay_controls.each do |overlay_control|
      control overlay_control do
        impact 0.0
        desc "caveat", "Not applicable for this CMS ARS 5.0 overlay, since the requirement is not included in CMS ARS 5.0"
      end
    end
  end
end