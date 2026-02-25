ln -s ../data/phylonium.nwk all.nwk

#+RESULTS:

pickle 1 all.nwk |
    grep -c -v '^#'
ln -s ../data/neidb
neighbors -L complete -t 991910 -o -l neidb |
    grep -v '^#' |
    awk '{print $3}' |
    sort |
    uniq 
pickle 1 all.nwk |
    grep -c '^991910_'
fintac -t '^991910_' all.nwk
climt 5041 all.nwk
pickle 5007 all.nwk |
    grep -c '^991910_'
pickle 5008 all.nwk |
    grep -c '^991910_'
pickle -t 5005 all.nwk |
    land -r |
    plotTree
pickle 5007 all.nwk |
    grep -v '^#' -c
pickle 5007 all.nwk |
  grep -v '^#' |
  tr '_' ' ' |
  awk '{print $1}' |
  sort |
  uniq -c |
  sort -n -r
for a in 373045 585396 397453 168927 1055542; do
    echo "# $a"
    ants $a neidb |
          tail -n 2
done
rm all.nwk neidb
