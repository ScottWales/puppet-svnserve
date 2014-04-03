all:check

bundledir = .vendor

bundle:${bundledir}/.empty

${bundledir}/.empty: Gemfile
	bundle install --path ${bundledir} && touch $@

check: bundle
	bundle exec rspec
