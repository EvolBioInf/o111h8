ln -s ../data/phylonium.nwk all.nwk
pickle 5005 all.nwk |
    grep -v '^#' |
    sed 's/[^_]*_//' > acc.txt
datasets download genome accession \
           --inputfile acc.txt \
           --dehydrated \
           --exclude-atypical
unzip ncbi_dataset.zip
datasets rehydrate --directory .
ln -s ../data/neidb
mkdir all
for file in $(ls ncbi_*/*/*/*.fna); do
    acc=$(basename $file |
                sed -E 's/(G.._[^_]+)_.*/\1/')
    q="select taxid from genome where accession='$acc'"
    tax=$(sqlite3 neidb "$q")
    name="${tax}_${acc}"
    ln -s $(pwd)/$file all/$name
done
mkdir targets
pickle -t 5005 all.nwk |
    pickle 5007 |
    grep -v '^#' |
    while read name; do
          ln -s $(pwd)/all/${name} targets/${name}.fasta
    done
mkdir neighbors
pickle -t 5005 all.nwk |
    pickle -c 5007 |
    grep -v '^#' |
    while read name; do
          ln -s $(pwd)/all/${name} neighbors/${name}.fasta
    done
makeFurDb -t targets -n neighbors -d o111h8.db
fur -d o111h8.db |
    cleanSeq > o111h8.fasta
fa2prim o111h8.fasta |
    primer3_core > o111h8.prim
prim2tab o111h8.prim |
    sort -n |
    head
rm -r all acc.txt all.nwk md5sum.txt ncbi_dataset \
   ncbi_dataset.zip neidb neighbors o111h8.db \
   o111h8.fasta o111h8.prim README.md targets
