TYP := $(wildcard lab*/*.typ)
PDF := $(TYP:.typ=.pdf)

.PHONY: all clean

all: $(PDF)

%.pdf: %.typ
	typst compile "$<" "$@"

clean:
	rm -f $(PDF)
