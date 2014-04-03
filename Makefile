all:check

bundledir    = .vendor
puppetfiles := $(shell find . -not -path '*/\.*' -name '*.pp')
lintflags    = --no-80chars-check

bundle:${bundledir}/.empty

${bundledir}/.empty: Gemfile
	bundle install --path ${bundledir} && touch $@

check: spec parse lint

spec: bundle parse lint
	bundle exec rspec

parse: bundle
	bundle exec puppet parser validate ${puppetfiles}

lint: bundle
	bundle exec puppet-lint ${lintflags} ${puppetfiles}
