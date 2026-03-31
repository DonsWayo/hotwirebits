# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Run JavaScript tests with Vitest"
task :js_test do
  system("npm test") || abort("JavaScript tests failed!")
end

desc "Run all tests (Ruby + JavaScript)"
task test_all: [:test, :js_test]

task default: :test
