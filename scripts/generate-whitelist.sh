#!/bin/bash
# creates a swift file that will contain a struct with a static list of ip addresses found in the 'whitelist.txt' file
filename='whitelist.txt'
str="import Foundation\n\npublic struct IpAddresses {\n\tpublic static let list: [String] = [\n"

while read -r line; do
  str="$str\t\t\"$line\",\n"
done < $filename

# remove last new line (2 chars) and last comma (1 char), then put back new line
str="${str%???}"
str="$str\n"

str="$str\t];\n}"

# write final string to a swift file
echo -e $str > "../Sources/IpWhitelistCheckerLib/IpAddressList.swift"
