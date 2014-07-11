all:check

export BEAKER_destory = onpass

bundledir    = .bundles
puppetfiles := $(shell find . -not -path '*/\.*' -not -path './pkg/*' -name '*.pp')
lintflags    = --no-80chars-check --with-filename --with-context

bundle:${bundledir}/.empty

${bundledir}/.empty: Gemfile
	bundle install --path ${bundledir} && touch $@

check: accept parse lint

accept: bundle parse lint
	bundle exec rspec spec

parse: bundle
	bundle exec puppet parser validate ${puppetfiles}

lint: bundle
	bundle exec puppet-lint ${lintflags} ${puppetfiles}
