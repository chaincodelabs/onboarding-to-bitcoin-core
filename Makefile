all: test-before-build build-other-versions build test-after-build
production: clean all production-test

## If we call git in our tests without using the --no-pager option
## or redirecting stdout to another command, fail unconditionally.
## This addresses an issue where `make` can't be run within an IDE because
## it tries to paginate the output, see:
## https://github.com/bitcoinops/bitcoinops.github.io/pull/494#discussion_r546376335
export GIT_PAGER='_contrib/kill0'
JEKYLL_FLAGS = --future --drafts --unpublished --incremental

clean:
	bundle exec jekyll clean

preview:
	## Don't do a full rebuild (to save time), but always rebuild index pages.
	rm -f _site/index.html \

	bundle exec jekyll serve --host 0.0.0.0 $(JEKYLL_FLAGS)

build:
	@# Tiny sleep for when running concurrently to ensure output
	@# files aren't created before changed input files are marked
	@# for schema validation.
	@sleep 0.1

	mkdir -p tmp
	cp links-separate.adoc tmp/links.adoc
	bundle exec jekyll build $(JEKYLL_FLAGS)

test-before-build: $(compatibility_validation) $(topic_validation)
	## Check for Markdown formatting problems
	@ ## - MD009: trailing spaces (can lead to extraneous <br> tags
	bundle exec mdl -g -r MD009 .

test-after-build: build
	## Check for unexpected changes between the Jekyll version and
	##the one-page asciidoc version
	#FIXME diff -u $$( find qa -type f | sort -n | tail -n1 ) bin/book.html

	## Check for broken Markdown reference-style links that are displayed in text unchanged, e.g. [broken][broken link]
	## Check for duplicate anchors
	! find _site/ -name '*.html' | while read file ; do \
	  cat $$file \
	  | egrep -o "(id|name)=[\"'][^\"']*[\"']" \
	  | sed -E "s/^(id|name)=//; s/[\"']//g" \
	  | sort | uniq -d \
	  | sed "s|.*|Duplicate anchor in $$file: #&|" ; \
	done | grep .

	## Check for broken links
	bundle exec htmlproofer --disable-external --ignore-urls '/^\/bin/.*/' ./_site

build-other-versions:
	mkdir -p tmp
	cp links-onepage.adoc tmp/links.adoc
	mkdir -p bin
	asciidoctor -o book.html index.adoc
	## Delete non-deterministic asciidoctor output
	sed -i '/^Last updated /d' book.html
	mv book.html bin/
