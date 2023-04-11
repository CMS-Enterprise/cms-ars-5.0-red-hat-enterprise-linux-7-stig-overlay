encoding: utf-8
overlay_controls = input('overlay_controls')
system_categorization = input('system_categorization')

include_controls 'redhat-enterprise-linux-7-stig-baseline' do
  unless overlay_controls.empty?
    overlay_controls.each do |overlay_control|
      control overlay_control do
        impact 0.0
        desc "caveat", "Not applicable for this CMS ARS 5.0 overlay, since the requirement is not included in CMS ARS 5.0"
      end
    end
  end

  
  ## NIST tags updated due to changes between NIST SP 800-53 rev 4 and rev 5 (https://csrc.nist.gov/csrc/media/Publications/sp/800-53/rev-5/final/documents/sp800-53r4-to-r5-comparison-workbook.xlsx)

  ## IA-2(6) incorporates withdrawn control IA-2(11)
  control 'SV-204397' do
    tag nist: ["IA-2 (6)", "IA-2 (12)", "IA-2 (12)"]
  end

  control 'SV-204631' do
    tag nist: ["IA-2 (6)", "IA-2 (12)", "IA-2 (12)"]
  end

  control 'SV-204632' do
    tag nist: ["IA-2 (6)", "IA-2 (12)", "IA-2 (12)"]
  end

  control 'SV-204633' do
    tag nist: ["IA-2 (6)", "IA-2 (12)", "IA-2 (12)"]
  end

  ## AC-2(3) incorporates withdrawn control IA-4 e
  control 'SV-204426' do
    tag nist: ["AC-2 (3)"]
  end

  ## CM-14 incorporates withdrawn control CM-5 (3)
  control 'SV-204447' do
    tag nist: ["CM-14"]
  end

  control 'SV-204448' do
    tag nist: ["CM-14"]
  end

  control 'SV-214799' do
    tag nist: ["CM-14"]
  end
  
  ## SC-45 (1) incorporates withdrawn control AU-8 (1)
  control 'SV-204603' do
    tag nist: ["SC-45 (1)"]
  end
