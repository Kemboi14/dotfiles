function v --description "Jump to a project with zoxide and open it in an editor (codium/code, else nvim)"
    if test (count $argv) -gt 0
        z $argv; or return 1
    end
    for ed in codium code
        if command -q $ed
            $ed .
            return
        end
    end
    nvim .
end
