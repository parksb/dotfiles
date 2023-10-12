function fish_prompt
  set -l last_command_status $status
  set -l cwd (prompt_pwd)

  set -l fish     ""
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⇄"
  set -l dirty    "✗"
  set -l stash    "≡"
  set -l none     "✓"

  set -l normal_color     (set_color normal)
  set -l success_color    (set_color cyan)
  set -l error_color      (set_color $fish_color_error 2> /dev/null; or set_color red --bold)
  set -l directory_color  (set_color $fish_color_quote 2> /dev/null; or set_color brown)
  set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)

  set -l prompt_string $fish

  if test "$theme_ignore_ssh_awareness" != 'yes' -a -n "$SSH_CLIENT$SSH_TTY"
    set prompt_string "$fish "(whoami)"@"(hostname -s)" $fish"
  end

  if test $last_command_status -eq 0
    echo -n -s $success_color $prompt_string $normal_color
  else
    echo -n -s $error_color $prompt_string $normal_color
  end

  if git_is_repo
    echo -n -s $directory_color $cwd $normal_color
    echo -n -s " on " $repository_color (git_branch_name) $normal_color

    set -l list
    if git_is_stashed
      set list " $stash"
    end
    if git_is_touched
      if test -z "$list"
        set list " $dirty"
      else
        set list "$list $dirty"
      end
    end
    echo -n "$list"

    if test -z "$list"
      echo -n -s " " (git_ahead $ahead $behind $diverged $none)
    end
  else
    echo -n -s $directory_color $cwd $normal_color
  end

  echo -n -s " "
end
