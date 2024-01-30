#!/bin/bash
# Part 2 of the day 1 2023 challenge (https://adventofcode.com/2023/day/1).
# Same as part 1, but now the spelled digit are also keeped (one, two, three, four, five, six, seven, eight and nine).

# INPUT is the first argument of the script
INPUT=$1

TOTAL=0
Counter=0

# Function to extract numbers form a string
# Arg 1: string to be processed
function extract_numbers()
{
	local str=$1;
	local string_numbers=$(echo $str | tr -dc '0-9');
	echo "$string_numbers";
}

# Function to get first and last digit of a number and return them in a formatted two digit string. If the input number is one digit length, it will be first and last, so 7 will return 77.
# Arg 1: number to process
function get_first_last_digits()
{
	local number=$1;
	local first=${number:0:1};
	local last=${number: -1}
	echo $first$last;
}

# Function to replace litteral numbers by numeric digits (one --> 1, two --> 2, etc...)
# Arg 1: string to process
function replace_litteral_by_numeric()
{
	local str=$1;
	# Manage combined litteral numbers:
	# one eight --> oneight --> 18 --> oneeight
	# two one --> twone --> 21 --> twoone
	# three eight --> threeight --> 38 --> threeeight
	# five eight --> fiveight --> 58 --> fiveeight
	# seven nine --> sevenine --> 79 --> sevennine
	# eight two --> eightwo --> 82 --> eighttwo
	# eight three --> eighthree --> 83 --> eightthree
	# nine eight --> nineight --> 98 --> nineeight
	local modstr=$(echo $str | sed 's/oneight/oneeight/g' | sed 's/twone/twoone/g' | sed 's/threeight/threeeight/g' | sed 's/fiveight/fiveeight/g' | sed 's/sevenine/sevennine/g' | sed 's/eightwo/eighttwo/g' | sed 's/eighthree/eightthree/g' | sed 's/nineight/nineeight/g');
	# Replace litteral by numeric values
	local replaced_str=$(echo $modstr | sed 's/one/1/g' | sed 's/two/2/g' | sed 's/three/3/g' | sed 's/four/4/g' | sed 's/five/5/g' | sed 's/six/6/g' | sed 's/seven/7/g' | sed 's/eight/8/g' | sed 's/nine/9/g');
	echo $replaced_str;
}

# Main program
# Loop to read each line of the file passed in the $INPUT variable, included the last line even without newline at the end
while IFS='' read -r LinefromFile || [[ -n "${LinefromFile}" ]];
do
	((Counter++));
	echo Line $Counter is: "${LinefromFile}"
	# Calls function to replace spelled digit by number digit
	numeric_line=$(replace_litteral_by_numeric "${LinefromFile}");
	echo Numeric line $Counter is: $numeric_line;
	# Calls function to extract numbers from the line
	numbers=$(extract_numbers "${numeric_line}");
	echo String $Counter numbers: $numbers;
	# Calls function to keep only first and last digit in a two digits formatted string
	value=$(get_first_last_digits "${numbers}");
	echo Keeped value for line $Counter: $value;
	# Add the result to the global total
	TOTAL=$((TOTAL + value));
	echo Sub-total is $TOTAL
done < "$INPUT";

# Sources
# Process a file line by line: https://www.howtogeek.com/709838/how-to-process-a-file-line-by-line-in-a-linux-bash-script/
# Extract numbers from a string: https://linuxconfig.org/how-to-extract-number-from-a-string-using-bash-example
# Return value from a function: https://linuxize.com/post/bash-functions/#return-values
# Get first char in string: https://www.tutorialkart.com/bash-shell-scripting/bash-get-first-character-in-string/#gsc.tab=0
# Get last char in string: https://www.tutorialkart.com/bash-shell-scripting/bash-get-last-character-in-string/#gsc.tab=0
# Concat two strings: https://www.tutorialkart.com/bash-shell-scripting/bash-concatenate-strings/#gsc.tab=0
# Simple sed syntaxe for substitution: https://linuxhint.com/replace-one-character-with-another-bash/#2
