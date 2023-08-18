
function commit --description 'git conventional commits'
    if count $argv > /dev/null
        set commit_type $argv[1]
        set commit_msg (string join " " $commit_msg $argv[2..-1])
        git commit -s -m $commit_type": "$commit_msg
    else
        set wtc (curl -s https://whatthecommit.com/index.txt)
        git commit -s -m "fix: $wtc" -m "Commit generated by whatthecommit.com"
        echo -e "\n$wtc"
    end
end
