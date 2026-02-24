all: query.sh

query.sh: query.org ../pilot/pilot.org
	bash ../scripts/org2nw query.org ../pilot/pilot.org | notangle -Rquery.sh > query.sh
test: clean query.sh
	bash query.sh
clean:
	rm -rf all.nwk neidb query.sh
