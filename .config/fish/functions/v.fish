function v --description "Jump to a project with zoxide and open it in VSCodium"
    if test (count $argv) -gt 0
        z $argv; or return 1
    end
    codium .
end
