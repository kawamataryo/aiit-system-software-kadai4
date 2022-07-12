#!/bin/bash
#
# =============================================================
# greatest_common_divisor
#
# description: This command calculates the greatest common divisor of two given natural numbers
#
# usage: ./greatest_common_divisor.sh [NUM_1] [NUM_2]
# =============================================================
#

set -euC


function usage() {
  cat <<EOS >&2
This command calculates the greatest common divisor of two given natural numbers
usage: $0 [NUM_1] [NUM_2]
EOS
    exit 1
}

function is_number() {
    local number="$1"
    if [[ $number =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

function validate_args() {
    if [[ $# -ne 2 ]]; then
        echo "Error: Incorrect number of arguments. Please pass two natural numbers as arguments." 1>&2
        usage
        exit 128
    fi

    if ! is_number "$1" || ! is_number "$2"; then
        echo "Error: Incorrect type of arguments. Please pass two natural numbers as arguments." 1>&2
        usage
        exit 128
    fi
}

function  greatest_common_divisor() {
    local num1="$1"
    local num2="$2"
    local gcd=1

    while : ;
    do
        if [[ $num1 -eq $num2 ]]; then
            gcd=$num1
            break
        fi

        if [[ $num1 -eq 0 ]]; then
            gcd=$num2
            break
        fi

        if [[ $num2 -eq 0 ]]; then
            gcd=$num1
            break
        fi

        if [[ $num1 -gt $num2 ]]; then
            num1=$((num1 % num2))
        else
            num2=$((num2 % num1))
        fi
    done

    echo "$gcd"
}

function main() {
    local NUM_1="$1"
    local NUM_2="$2"

    greatest_common_divisor "$NUM_1" "$NUM_2"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    validate_args "$@"
    main "$1" "$2"
fi
