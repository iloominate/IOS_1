POSIXLY_CORRECT=yes
#!/bin/bash

LIST=""
SECRETLOG=""

DIRECTORY="$PWD"
FILE=""

group=""
mode=""
before=""
after=""
workDir=""

if [[ -z "$MOLE_RC" ]]; then
  echo "Configuration error, MOLE_RC is null"
  exit 1
elif ! [[ -f "$MOLE_RC" ]]; then
  echo "Configuration error, MOLE_RC is not a file"
fi

usage() {
  echo "Usage: $0 [-h] [-g GROUP] [-m] [-b DATE] [-a DATE] [FILTERS] [DIRECTORY]" 1>&2
}

if [[ $1 == "list" ]]; then
  LIST=true
  shift 1
elif [[ $1 == "secret-log" ]]; then
  SECRETLOG=true
  shift 1
fi

usage=""
group=""
mode=""
before=""
after=""
workDir=""

while getopts ":g:b:a:mh" opt; do
  case ${opt} in
    h ) usage;;
    g ) group="$OPTARG";;
    m ) mode="true";;
    b ) before="$OPTARG";;
    a ) after="$OPTARG";;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2;;
    : ) 
      echo "Option -$OPTARG requires an argument." 1>&2; usage;;
  esac
done
shift $((OPTIND -1))

if [[ $# -gt 0 ]]; then
  if [ -d "$1" ]; then
    DIRECTORY="$1"
  elif [ -f "$1" ]; then
    FILE="$1"
  else 
    echo "Invalid argument: $1" 1>&2
  fi
fi

echo "FILE: $FILE"
echo "Directory: $DIRECTORY"
echo "a- $after"
echo "b- $before"
echo "Secret log: $SECRETLOG"
echo "LIST: $LIST"

