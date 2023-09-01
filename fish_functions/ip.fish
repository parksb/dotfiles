function ip
  echo "Local: $(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')"
  echo "Public: $(curl -s ifconfig.me)"
end
