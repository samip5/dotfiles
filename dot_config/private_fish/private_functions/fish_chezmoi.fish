function __fish_chezmoi_install
    abbr -a cm 'chezmoi'
    abbr -a cma 'chezmoi add'
    abbr -a cmap 'chezmoi apply'
    abbr -a cmu 'chezmoi update'
    abbr -a cmd 'chezmoi diff'
end


function __fish_chezmoi_uninstall --on-event fish_chezmoi_uninstall
    abbr --erase cm
    abbr --erase cma
    abbr --erase cmap
    abbr --erase cmu
    abbr --erase cmd
end
