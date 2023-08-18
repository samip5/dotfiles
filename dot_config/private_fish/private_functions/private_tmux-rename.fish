function ssh
  if set -q TMUX
    tmux rename-window (echo ssh: $argv)
    command ssh "$argv"
    tmux set-window-option automatic-rename "on"
  else
    command ssh "$argv"
  end
end
