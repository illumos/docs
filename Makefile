TOP =		$(PWD)
OUTDIR =	$(PWD)/site

all:
	mkdocs build -d "$(OUTDIR)"

clean:
	rm -rf "$(OUTDIR)"
