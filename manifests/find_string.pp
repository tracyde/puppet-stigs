# Definition: stigs::find_string
#
# This class ensures pattern is found in a file
#
# Parameters:
# - The $file to search
# - The $pattern is a regular expression of the string you wish to search for
#
# Actions:
# - Ensures pattern is found in a file
#
# Requires:
# - Nothing
#
# Sample Usage:
#  stigs::find_string { 'find-test':
#    file    => '/tmp/test',
#    pattern => 'test',
#  }
#
define stigs::find_string($file, $pattern) {
  exec { "find_string-${pattern}-${file}":
    command => "/bin/echo 'Could not find pattern: \n  Pattern: ${pattern}\n  File: ${file}\n' && exit 1",
    unless  => "/bin/grep -E '${pattern}' '${file}'",
  }
}
