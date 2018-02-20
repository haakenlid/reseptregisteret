#! /usr/bin/awk -E

BEGIN {
  FS=OFS=",";
  CONVFMT="%.3f"
}
BEGINFILE {
  if(FILENAME=="-"){
    inplace = 0
  }
}
@include "inplace"

FNR==1 {
  gsub(/,(Value|Sum)/, ",");
  gsub(/_/, " ");
  gsub(/time/, "year");
  $0 = tolower($0)
}
{
  gsub(/ ?[-+].*/, "", $3);
  gsub(/ *, */, ",");
  gsub(/Mann/, "M");
  gsub(/Kvinne/, "F");
  for(i =1; i <= NF; i++) {
    if($i ~ /[0-9]\./){
      $i = 0 + $i
    }
  }
  print
}
