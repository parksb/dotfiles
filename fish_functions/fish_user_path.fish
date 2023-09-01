function fish_user_path
  set cmd $argv[1]
  switch $cmd
    case "list"
      echo $fish_user_paths | tr " " "\n" | nl
    case "erase"
      set index $(fish_user_path list | fzf --height 40% --border | rg -o '\d+')
      set --erase --universal fish_user_paths[$index]
      fish_user_path list
    case "*"
      echo "Unknown argument"
  end
end
