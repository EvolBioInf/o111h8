all: data
data:
	curl https://owncloud.gwdg.de/index.php/s/UWYXjJL8ScRx4V1/download -o data_o111h8.tbz
	tar -xvjf data_o111h8.tbz
	rm data_o111h8.tbz

tangle:
	make -C pilot
	cp pilot/*.sh scripts/ 
	make -C query
	cp query/*.sh scripts/ 

clean:
	rm -rf data
