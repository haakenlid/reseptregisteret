#! /usr/bin/awk -E

# Clean up messy and bloated data from http://www.reseptregisteret.no/

BEGIN {
  FS=OFS=","  # comma is field separator
  CONVFMT="%.3f"  # max 3 trailing digits in floats to reduce filesize
}
BEGINFILE {
  if(FILENAME=="-") inplace = 0  # don't use inplace when input is stdin
}
@include "inplace"

FNR==1 {  # first line of each file
  gsub(/,(Value|Sum)/, ",")
  gsub(/_/, " ")
  gsub(/time/, "year")
  $0 = tolower($0)
}
{
  gsub(/ ?[-+].*/, "", $3)  # age ranges to single number
  gsub(/ *, */, ",")        # trim spaces around strings
  gsub(/Mann/, "M")         # single letter gender
  gsub(/Kvinne/, "F")
  for(i =1; i <= NF; i++)
    if($i ~ /[0-9]\./) $i = 0 + $i  # parse real numbers to floats
  print
}
