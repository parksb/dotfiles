function kebab
  set x $argv[1]
  echo $x | tr '[:upper:]' '[:lower:]' | sed 's/: /-/g' | tr -d '/?' | tr ' ' '-'
end
