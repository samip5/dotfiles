function watch --description 'watch with fish alias support'
    if count $argv > /dev/null
        if type -q viddy
            viddy -d -n 2 --shell fish $argv[1..-1]
        else
            /usr/bin/watch -x fish -c "$argv"
        end
    end
end
