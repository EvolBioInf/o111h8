taxon=$1
neighbors -g -o -l -L complete -t $taxon neidb |
    awk 'NR>1{print $3}' |
    sort |
    uniq |
    awk '{if (NR==1){printf "%s",$1} else
    {printf "|%s",$1}}
    END{printf "\n"}'
