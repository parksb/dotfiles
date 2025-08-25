function pathhead -a N
  if test -z "$N"; or not string match -qr '^[0-9]+$' -- $N; or test $N -lt 1
    echo "Usage: pathhead N [PATH...]" >&2
    return 1
  end

  set -l rep (math $N - 1)
  set -l pattern (printf '^(/?(?:[^/]+/){%d}[^/]+)(?:/.*)?$' $rep)

  if test (count $argv) -gt 1
    for line in $argv[2..-1]
      string replace -r $pattern '$1' $line
    end
  else
    while read -l line
      string replace -r $pattern '$1' $line
    end
  end
end
