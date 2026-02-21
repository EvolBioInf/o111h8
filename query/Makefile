all: query.sh

query.sh: query.org ../pilot/pilot.org
	bash ../scripts/org2nw query.org ../pilot/pilot.org | notangle -Rquery.sh > query.sh
test: clean query.sh
	bash query.sh
clean:
	rm -rf all acc.txt all.nwk md5sum.txt ncbi_dataset ncbi_dataset.zip neidb neighbors o111h8.db o111h8.fasta query.sh README.md targets
