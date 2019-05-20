#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $DIR

# Global Variables
input=""
output=""

SIGNATURE=0xcafeface

# ERRORS
NO_FILE_SPECIFIED=1

# Helper Functions
function print_usage() {
    echo -e "Usage:\t$0 [options] -i input_file_path -o output_file_path\n"
    echo -e "\tOptions:"
    echo -e "\t\t-v, --version\t Print version"
    echo -e "\n"
}

function print_32byte() {
    byte3="\x"$(echo $1 | cut -c3-4)
    byte2="\x"$(echo $1 | cut -c5-6)
    byte1="\x"$(echo $1 | cut -c7-8)
    byte0="\x"$(echo $1 | cut -c9-10)
    echo -en $byte0 
    echo -en $byte1
    echo -en $byte2
    echo -en $byte3
}
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -i|--input)
    INPUT="$2"
    shift # past argument
    shift # past value
    ;;
    -o|--output)
    OUTPUT="$2"
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -z $INPUT ]]; then
    echo -e "\nNo input file provided\n\n"
    print_usage
    exit $NO_FILE_SPECIFIED
fi
if [[ -z $OUTPUT ]]; then
    echo -e "\nNo output file provided\n\n"
    exit -$NO_FILE_SPECIFIED
fi

# Build Binary
echo "SIGNATURE: $SIGNATURE"
print_32byte $SIGNATURE > $OUTPUT
print_32byte 0x67453412 >> $OUTPUT
print_32byte 0xEFCDAB89 >> $OUTPUT

# DEBUG
echo ${INPUT}
echo ${OUTPUT}
echo ${DEFAULT}
echo ${POSITIONAL}

echo "GOOD BYE"