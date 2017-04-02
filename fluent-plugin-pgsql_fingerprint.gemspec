# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name = 'fluent-plugin-pgsql_fingerprint'
  spec.version = '0.0.1'
  spec.authors = ['Daisuke Hirakiuchi']
  spec.email = ['hirakiuc@gmail.com']

  spec.summary = "A Fluent filter plugin to convert postgres sql to sql's fingerprint"
  spec.description = spec.summary
  spec.homepage = "https://github.com/hirakiuc/fluent-plugin-pgsql_fingerprint"
  spec.license = "MIT"

  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'fluentd', '>= 0.14'
  spec.add_runtime_dependency 'pg_query', '>= 0.11'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'test-unit'
end
