if status is-interactive
    # Colors follow the terminal (and therefore Caelestia)
    set -gx BAT_THEME ansi

    # eza: ls with icons and git status
    alias ls "eza --icons --group-directories-first"
    alias ll "eza -lh --icons --git --group-directories-first"
    alias la "eza -lha --icons --git --group-directories-first"
    alias lt "eza --tree --level=2 --icons"

    # bat: cat with syntax highlighting
    alias cat "bat --paging=never --style=plain"

    # zoxide: smart cd (z folder) and fzf: fuzzy search (Ctrl+R, Ctrl+T)
    zoxide init fish | source
    fzf --fish | source
end
