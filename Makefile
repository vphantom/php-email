PHP      := `which php`
PHPUNIT  := $(PHP) vendor/bin/phpunit -v --colors=auto

help:
	echo "This is help."

clean:
	rm -fr build

test:
	$(PHPUNIT) --whitelist Email.php --coverage-html build/coverage --coverage-clover build/logs/clover.xml test.php

lint:
	$(PHP) -l Email.php

.SILENT:	help

.PHONY:	clean help test lint
