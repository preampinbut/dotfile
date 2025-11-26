# skip fastfetch in tmux
if [[ -z "$TMUX" ]]; then
  sleep 0.1
	fastfetch
  sleep 0.1
fi
