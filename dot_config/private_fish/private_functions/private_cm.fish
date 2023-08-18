function cm --wraps=chezmoi --description 'chezmoi shorthand'
    if string match -q -- "/home/sky/code/repos/samip5/dotfiles" (pwd)
        printf "Do not run chezmoi within the dotfiles repo"
        return
    else
        chezmoi $argv
    end
end
