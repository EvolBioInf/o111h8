all: pilot.sh

pilot.sh: pilot.org
	bash ../scripts/org2nw pilot.org | notangle -Rpilot.sh > pilot.sh
test: clean pilot.sh
	bash pilot.sh
clean:
	rm -rf accTax.txt acc.txt all all.nwk md5sum.txt ncbi_dataset ncbi_dataset.zip pilot.sh README.md
