function tex
  set cmd $argv[1]
  switch $cmd
    case "new"
      set preamble $argv[2]
      set name $argv[3]
      if test -n "$name" && test -n "$preamble"
        set preamble_path $TEX_PREAMBLES_DIR/"$preamble".tex
        if test -e "$preamble_path"
          tectonic -X new $name
          cp -f $preamble_path "$name"/src/_preamble.tex
          sed -i '' 's/name = \"default\"/name = \"'"$name"'\"/' "$name"/Tectonic.toml
        else
          echo "A preamble `$preamble` not found from `$preamble_path`"
        end
      else
        tectonic -X new $name
      end
    case "open"
      set output "$(ls build)"
      open build/"$output"/"$output".pdf
    case "*"
      tectonic -X $cmd
  end
end

