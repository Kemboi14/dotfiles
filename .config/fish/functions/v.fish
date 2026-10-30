function v --description "Jump to a project with zoxide and open it in Neovim"
    if test (count $argv) -gt 0
        z $argv; or return 1
    end
    nvim .
end
