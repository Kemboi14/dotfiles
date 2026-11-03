function rdp --description "RDP to a Windows host via sdl-freerdp3"
    argparse "d/domain=" "n/ntlm" -- $argv; or return 1
    if test (count $argv) -lt 2
        echo "usage: rdp [-d DOMAIN] [-n] <host> <user>" >&2
        return 1
    end
    set -l args /v:$argv[1] /u:$argv[2] /dynamic-resolution /gfx:AVC444 /network:auto +clipboard /cert:tofu +auto-reconnect
    set -q _flag_domain; and set -a args /d:$_flag_domain
    set -q _flag_ntlm; and set -a args "/auth-pkg-list:!kerberos"
    sdl-freerdp3 $args
end
