# skip fastfetch in tmux
if [[ -z "$TMUX" && -z "$NVIM" ]]; then
	fastfetch
fi
