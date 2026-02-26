# Construct bin if necessary
test -d bin || mkdir bin
# Install curl, bzip2, and zip
sudo apt update
sudo apt install -y curl bzip2 zip
# Install Neighbors
git clone https://github.com/evolbioinf/neighbors
cd neighbors
bash scripts/setup.sh
make
ln -s $(pwd)/bin/* ~/bin/
cd ..
# Install datasets
curl https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets -o ~/bin/datasets
chmod +x ~/bin/datasets
# Install Fur
git clone https://github.com/evolbioinf/fur
cd fur
bash scripts/setup.sh
make
ln -s $(pwd)/bin/* ~/bin/
cd ..
# Install Prim
git clone https://github.com/evolbioinf/prim
cd prim
bash scripts/setup.sh
make
ln -s $(pwd)/bin/* ~/bin/
cd ..
# Install Biobox
git clone https://github.com/evolbioinf/biobox
cd biobox
bash scripts/setup.sh
make
ln -s $(pwd)/bin/* ~/bin/
cd ..
