docs = ~/WinHome/ownCloud/docs
nw = $(shell which noweb)
src = intro.tex pilot.tex query.tex
all: $(src) o111h8Doc.pdf
%.tex:	../*/%.org
	bash ../scripts/org2nw $< | noweave -n -x > $@
o111h8Doc.pdf: o111h8Doc.tex $(src) header.tex
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
