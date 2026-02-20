all: query.sh

query.sh: query.org
	bash ../scripts/org2nw query.org | notangle -Rquery.sh > query.sh
test: clean query.sh
	bash query.sh
clean:
	rm -f query.sh
