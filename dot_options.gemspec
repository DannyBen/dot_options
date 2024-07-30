lib = File.expand_path 'lib', __dir__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require 'dot_options/version'

Gem::Specification.new do |s|
  s.name        = 'dot_options'
  s.version     = DotOptions::VERSION
  s.summary     = 'Options object with dot-notation access'
  s.description = 'Convert any hash to a deep dot-notation object'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*']
  s.homepage    = 'https://github.com/dannyben/dot_notation'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.1'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/dot_options/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/dot_options/blob/master/CHANGELOG.md',
    'source_code_uri'       => 'https://github.com/DannyBen/dot_options',
    'rubygems_mfa_required' => 'true',
  }
end
