function pill
  set port $argv[1]
  set pid $(lsof -ti :$port)
  if test -n "$pid"
    kill $pid
  end
end
