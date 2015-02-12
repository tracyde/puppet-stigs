# Definition: stigs::delete_string
#
# This class deletes all occurrences of a pattern found in a file
#
# Parameters:
# - The $file to search and modify
# - The $pattern is a regular expression of the string you wish to remove
#
# Actions:
# - Removes occurrences of a pattern found in a file
#
# Requires:
# - Nothing
#
# Sample Usage:
#  stigs::delete_string { 'remove-test':
#    file    => '/tmp/test',
#    pattern => 'test',
#  }
#
define stigs::delete_string($file, $pattern) {
  exec { "/bin/sed -i -r -e 's/${pattern}//g' ${file}":
    onlyif => "/bin/grep -E '${pattern}' '${file}'",
  }
}
