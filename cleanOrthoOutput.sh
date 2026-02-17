    csplit -z -f results/ortho\
             results/ortho.data /^#/ {1}

    grep -v '#' results/ortho00 > results/ortho.map

    grep -v '#' results/ortho01 |
        head -n -1 |
        awk 'BEGIN{OFS="\t"}
                  {printf "%s", $1;
                  for (i=2;i<=NF;i++)
                  printf "\t%.3f",(100-$i)/100};
                  {printf "\n"}' > results/ortho.matrix

    count=$(wc -l results/ortho.matrix |
                  awk '{print $1}')

    join -1 1 -2 1 results/ortho.map \
         results/ortho.matrix |
        cut -f 2- -d ' ' |
        awk -v count=$count \
              'BEGIN{print count}{print $0}' > tmp.txt
