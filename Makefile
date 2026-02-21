all: data tangle
data:
	curl https://owncloud.gwdg.de/index.php/s/UWYXjJL8ScRx4V1/download -o data_o111h8.tbz
	tar -xvjf data_o111h8.tbz
	rm data_o111h8.tbz
tangle:
	make -C pilot
	cp pilot/pilot.sh tutorial/
	make -C query
	cp query/query.sh tutorial/
setup:
	bash scripts/setup.sh
clean:
	rm -rf data
