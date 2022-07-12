#!/bin/bash
#
# =============================================================
# greatest_common_divisor test
#
# description: This command is test to ./greatest_common_divisor.sh
#
# usage: ./test.sh
# =============================================================
#

set -uC

source "./greatest_common_divisor.sh"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

ERROR_COUNT=0

function should_caluculate_gcd() {
    local test_cases=(
        "32 12 4"
        "12 32 4"
        "6 2 2"
        "120 60 60"
        "230 15 5"
        "120 32 8"
        "7 2 1"
    )

    for test_case in "${test_cases[@]}"
    do
        local num1
        local num2
        local gcd
        local result

        num1="$(echo "$test_case" | cut -d ' ' -f 1)"
        num2="$(echo "$test_case" | cut -d ' ' -f 2)"
        gcd="$(echo "$test_case" | cut -d ' ' -f 3)"

        result=$(main "$num1" "$num2")

        if [[ "$result" == "$gcd" ]]; then
            echo -e "${GREEN}Success: g.c.d of $num1 and $num2 is $gcd${NC}"
        else
            echo -e "${GREEN}Error: g.c.d of $num1 and $num2 is $result${NC}"
            ERROR_COUNT+=1
        fi
    done
}


function should_throw_error_when_pass_to_incorrect_value() {
    local test_cases=(
        "a 1"
        "b a"
        " 2"
        "-10 5"
    )
    for test_case in "${test_cases[@]}"
    do
        local num1
        local num2
        local gcd
        local result

        num1="$(echo "$test_case" | cut -d ' ' -f 1)"
        num2="$(echo "$test_case" | cut -d ' ' -f 2)"
        gcd="$(echo "$test_case" | cut -d ' ' -f 3)"

        result=$(validate_args "$num1" "$num2" 2>/dev/null)
        if [[ $? -ne 0 ]] ; then
            echo -e "${GREEN}Success: throw error when $num1 and $num2${NC}"
        else
            echo -e "${RED}Error: Don't throw error when $num1 and $num2${NC}"
            ERROR_COUNT+=1
        fi
    done
}

function run_test() {
    should_caluculate_gcd
    should_throw_error_when_pass_to_incorrect_value

    if [[ $ERROR_COUNT -eq 0 ]] ; then
        exit 0
    else
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_test
fi
