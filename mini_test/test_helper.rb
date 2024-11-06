require 'minitest/autorun'
require "minitest/spec"
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(
  reports_dir: 'mini_test/spec_reports',
  color: true,
  mode: :clean,
)