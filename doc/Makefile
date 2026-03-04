date = $(shell git log | grep -m 1 Date | sed -r 's/Date: +[A-Z][a-z]+ ([A-Z][a-z]+) ([0-9]+) [^ ]+ ([0-9]+) .+/\2_\1_\3/')
version = $(shell git describe)
docs = ~/WinHome/ownCloud/docs
nw = $(shell which noweb)
src = intro.tex pilot.tex query.tex markers.tex
all: $(src) o111h8Doc.pdf
%.tex:	../*/%.org
	bash ../scripts/org2nw $< | noweave -n -x > $@
o111h8Doc.pdf: o111h8Doc.tex $(src) header.tex
	echo $(date) | tr '_' ' ' > date.txt
	echo $(version) | tr '-' ' ' | awk '{printf "%s", $$1; if ($$2) printf "-%s", $$2; printf "\n"}' > version.txt
	latex o111h8Doc
	bibtex o111h8Doc
	latex o111h8Doc
	latex o111h8Doc
	dvipdf -dALLOWPSTRANSPARENCY o111h8Doc
publish: $(docs)/o111h8Doc.pdf
$(docs)/o111h8Doc.pdf: o111h8Doc.pdf
	cp o111h8Doc.pdf $(docs)
clean:
	rm -f o111h8Doc.aux o111h8Doc.dvi o111h8Doc.log o111h8Doc.out o111h8Doc.pdf $(src)
