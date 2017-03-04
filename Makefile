PHP      := `which php`
PHPUNIT  := $(PHP) vendor/bin/phpunit -v --colors=auto
SRC2MD   := ./node_modules/docblox2md/cli.js --skip-protected

DOCS := $(wildcard *.md */*.md)

SRC := Email.php

help:
	echo "Targets: help, clean, test, lint, docs"

clean:
	rm -fr build

test:
	$(PHPUNIT) --whitelist Email.php --coverage-html build/coverage --coverage-clover build/logs/clover.xml test.php

lint:
	$(PHP) -l Email.php

docs:	$(DOCS)

%.md:	$(SRC)
	$(SRC2MD) $@

.SILENT:	help

.PHONY:	clean help test lint docs
