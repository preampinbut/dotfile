# skip fastfetch in tmux
if [[ -z "$TMUX" && -z "$NVIM" ]]; then
  sleep 0.05
	fastfetch
  sleep 0.05
fi
