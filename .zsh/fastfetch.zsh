# skip fastfetch in tmux
if [[ -z "$TMUX" && -z "$NVIM" ]]; then
  sleep 0.1
	fastfetch
  sleep 0.1
fi
