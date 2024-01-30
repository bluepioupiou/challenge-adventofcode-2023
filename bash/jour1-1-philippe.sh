#!/bin/bash
# Part 1 of the day 1 2023 challenge (https://adventofcode.com/2023/day/1).
# Extract first and last digit of each line of input file, concat them in a two digit number, then add all of them to get the final result.

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

# Main program
# Loop to read each line of the file passed in the $INPUT variable, included the last line even without newline at the end
while IFS='' read -r LinefromFile || [[ -n "${LinefromFile}" ]];
do
	((Counter++));
	# Calls function to extract numbers from the line
	numbers=$(extract_numbers "${LinefromFile}");
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
