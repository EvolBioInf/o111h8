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
makeFurDb -t targets -n neighbors -d markers.db
fur -d markers.db |
    cleanSeq > markers.fasta
blastn -query markers.fasta -subject pilot.fasta \
         -outfmt "6 qstart qend"  |
    awk '{l=$2-$1+1;s+=l}END{print s}'
fa2prim markers.fasta |
    primer3_core > markers.prim
prim2tab markers.prim |
    sort -n |
    head
rm -r all acc.txt all.nwk md5sum.txt ncbi_dataset \
   ncbi_dataset.zip markers.db markers.prim neidb \
   neighbors README.md targets
