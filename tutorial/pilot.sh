ln -s ../data/neidb
taxi O111:H8 neidb
neighbors -l -L complete -t 991910 neidb |
    head -n 30
neighbors -l -L complete -t 991910 neidb |
    grep -c '^t'
neighbors -l -L complete -t 991910 neidb |
    grep -c '^n'
neighbors -l -L complete -t 562 -o neidb |
    grep -c '^t'
neighbors -l -L complete -t 991910 neidb |
    grep '^[tn]' |
    head -n 50 > accTax.txt
awk '{print $2}' accTax.txt > acc.txt
datasets download genome accession \
           --inputfile acc.txt \
           --dehydrated \
           --exclude-atypical
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mkdir all
for file in $(ls ncbi_*/*/*/*.fna); do
    acc=$(basename $file |
                sed -E 's/(G.._[^_]+)_.*/\1/')
    tax=$(grep $acc accTax.txt |
                awk '{print $3}')
    name="${tax}_${acc}"
    ln -s $(pwd)/$file all/$name
done
phylonium all/* |
    nj |
    midRoot > all.nwk
land all.nwk > t
mv t all.nwk
fintac -t 991910 all.nwk
pickle 29 all.nwk |
    grep -c 991910
mkdir targets
pickle 29 all.nwk |
    grep -v '^#' |
    while read name; do
          ln -s $(pwd)/all/${name} targets/${name}.fasta
    done
mkdir neighbors
pickle -c 29 all.nwk |
    grep -v '^#' |
    while read name; do
          ln -s $(pwd)/all/${name} neighbors/${name}.fasta
    done
makeFurDb -t targets -n neighbors -d pilot.db
fur -d pilot.db |
    cleanSeq > pilot.fasta
cres pilot.fasta
fa2prim pilot.fasta |
    primer3_core |
    prim2tab |
    head
rm -r accTax.txt acc.txt all all.nwk md5sum.txt \
   ncbi_dataset ncbi_dataset.zip neidb neighbors \
   pilot.db README.md targets
