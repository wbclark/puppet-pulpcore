# @summary Re-usable, overridable strings for file headers
#
# @param custom_installer_name
#   Override installer_name in headers from "Puppet" to e.g. "foreman-installer"
#
# @param custom_settings_explanation
#   Custom string providing further instructions to the user in settings.py header
class pulpcore::header_strings(
  Optional[String] $custom_installer_name = undef,
  Optional[String] $custom_settings_explanation = undef,
) {
  if $custom_installer_name {
    $installer_name = $custom_installer_name
  } else {
    $installer_name = 'Puppet'
  }

  $installer_header = "File managed by ${installer_name}.\nModule: ${module_name}"
  $warning_header   = '!!! WARNING: DO NOT EDIT THIS FILE !!!'

  if $custom_settings_explanation {
    $explanation = $custom_settings_explanation
  } else {
    $explanation = @("EXPLANATION"/L)
      Not only are your edits likely to be overwritten, there is also a strong possibility \
      of breaking your system if you change configuration here without making required \
      changes elsewhere. Refer to the documentation you used to install Pulpcore to \
      determine the safe and persistent way to modify the configuration.
      | - EXPLANATION
  }

  $settings_header_content = pulpcore::generate_header_content(
    [
      $warning_header,
      $installer_header,
      $explanation,
    ],
    80,
    '#',
  )
}
