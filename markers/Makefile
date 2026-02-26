all: markers.sh

markers.sh: markers.org ../pilot/pilot.org
	bash ../scripts/org2nw markers.org ../pilot/pilot.org | notangle -Rmarkers.sh > markers.sh
test: clean markers.sh
	bash markers.sh
clean:
	rm -rf all acc.txt all.nwk md5sum.txt ncbi_dataset ncbi_dataset.zip neidb neighbors markers.db markers.fasta markers.prim markers.sh README.md targets
