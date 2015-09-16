#! /usr/bin/env bash
# vim: set filetype=sh ts=2 sw=2 expandtab :

if [[ -n $DEBUG ]]; then
  # Enable debug log file and copy STDOUT and STDERR to it using tee(1)
  DEBUG_LOG="/tmp/${0##*/}.debug.$(date +%Y%m%d_%H%M%S).log"

  > "$DEBUG_LOG"                   # Truncate DEBUG_LOG
  exec >  >(tee -a $DEBUG_LOG)     # Copy STDOUT to DEBUG_LOG
  exec 2> >(tee -a $DEBUG_LOG >&2) # Copyd STDERR to DEBUG_LOG

  echo "+($(date +%Y%m%d_%H%M%S): debug output): $DEBUG_LOG" >&2

  # Add more info to xtrace: source file, line number, function name
  export PS4='+(${BASH_SOURCE##*/}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

  set -o xtrace  # Print command traces before executing command.
  set -o errexit # Abort script at first error (command exits non-zero).
fi

SCRIPT=$(realpath $0)
echo $SCRIPT

# The rest of the script goes here
