#! /bin/bash

# FIXME don't use that because it affects other scripts
# https://tiswww.case.edu/php/chet/bash/FAQ (see E13)
# https://stackoverflow.com/q/28479216/735926
# https://github.com/gruntjs/grunt-cli/pull/65/files
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

_my_gsutil_completions() {
  COMPREPLY="$(gsutil +autocomplete "${COMP_WORDS[*]}")"
}
complete -o nospace -F _my_gsutil_completions gsutil
