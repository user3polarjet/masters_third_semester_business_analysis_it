TYP := $(wildcard lab*/*.typ)
PDF := $(TYP:.typ=.pdf)

LAB3_DIR := lab3
LAB3_BPMN := $(LAB3_DIR)/order-delivery-layouted.bpmn
LAB3_SVG := $(LAB3_DIR)/order-delivery.svg
LAB3_TYP := $(LAB3_DIR)/КП3_ІП_51мн_Панченко_Сергій.typ
LAB3_PDF := $(LAB3_TYP:.typ=.pdf)

CHROME_BIN ?= $(shell command -v chromium 2>/dev/null || command -v chromium-browser 2>/dev/null || command -v google-chrome 2>/dev/null)

.PHONY: all clean lab3 lab3-svg lab3-pdf

all: $(PDF)

lab3: $(LAB3_PDF)

lab3-svg: $(LAB3_SVG)

lab3-pdf: $(LAB3_PDF)

$(LAB3_SVG): $(LAB3_BPMN) $(LAB3_DIR)/package.json $(LAB3_DIR)/package-lock.json
	@test -n "$(CHROME_BIN)" || { echo "Chromium/Chrome executable not found; set CHROME_BIN=/path/to/browser" >&2; exit 1; }
	cd $(LAB3_DIR) && PUPPETEER_EXECUTABLE_PATH="$(CHROME_BIN)" npm run render -- "$(notdir $(LAB3_BPMN)):$(notdir $(LAB3_SVG))"

$(LAB3_PDF): $(LAB3_TYP) $(LAB3_SVG) kpi.svg
	typst compile --root . "$(LAB3_TYP)" "$(LAB3_PDF)"

%.pdf: %.typ
	typst compile "$<" "$@"

clean:
	rm -f $(PDF)
