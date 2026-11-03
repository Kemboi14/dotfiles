function cursor --description 'Switch cursor theme now and for the next login'
    set -l name $argv[1]
    set -l size 24
    if string match -qr '^\d+$' -- "$argv[2]"
        set size $argv[2]
    end

    set -l dirs /usr/share/icons ~/.icons ~/.local/share/icons

    if test -z "$name"
        echo 'Usage: cursor THEME [SIZE]'
        echo 'Installed cursor themes:'
        for d in $dirs/*
            test -d $d/cursors; and echo '  '(basename $d)
        end
        return 1
    end

    set -l found
    for d in $dirs
        test -d $d/$name/cursors; and set found 1
    end
    if not set -q found[1]
        echo "cursor: theme '$name' not found (run 'cursor' to list themes)"
        return 1
    end

    mkdir -p ~/.icons/default
    printf '[Icon Theme]\nName=Default\nComment=Default Cursor Theme\nInherits=%s\n' $name >~/.icons/default/index.theme

    set -l ini ~/.config/gtk-3.0/settings.ini
    if test -f $ini
        sed -i -e "s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$name/" \
            -e "s/^gtk-cursor-theme-size=.*/gtk-cursor-theme-size=$size/" $ini
    end

    gsettings set org.gnome.desktop.interface cursor-theme $name
    gsettings set org.gnome.desktop.interface cursor-size $size
    hyprctl setcursor $name $size >/dev/null

    echo "Cursor set to $name ($size). Log out and back in so every app follows."
end
