#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo $DIR
input=""
output=""

# ERRORS
NO_FILE_SPECIFIED=1

# Helper Functions
function print_usage() {
    echo -e "Usage:\t$0 [options] -i input_file_path -o output_file_path\n"
    echo -e "\tOptions:"
    echo -e "\t\t-v, --version\t Print version"
    echo -e "\n"
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

echo ${INPUT}
echo ${OUTPUT}
echo ${DEFAULT}
echo ${POSITIONAL}

echo "GOOD BYE"

