all: data
data:
	curl https://owncloud.gwdg.de/index.php/s/UWYXjJL8ScRx4V1/download -o data_o111h8.tbz
	tar -xvjf data_o111h8.tbz
	rm data_o111h8.tbz
clean:
	rm -rf data
