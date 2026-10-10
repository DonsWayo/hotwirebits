# frozen_string_literal: true

require "test_helper"
require "open3"
require "tmpdir"

class CliTest < ActiveSupport::TestCase
  CLI_PATH = File.expand_path("../../bin/hotwirebits", __dir__)

  private

  def run_cli(*args, chdir:)
    Open3.capture3(RbConfig.ruby, CLI_PATH, *args, chdir: chdir)
  end

  test "init creates directories and copies the theme" do
    Dir.mktmpdir do |dir|
      out, _, status = run_cli("init", chdir: dir)

      assert_predicate status, :success?
      %w[
        app/components/hotwirebits
        app/views/hotwirebits
        app/javascript/controllers/hotwirebits
        app/assets/stylesheets/hotwirebits
      ].each { |path| assert File.directory?(File.join(dir, path)) }
      assert File.file?(File.join(dir, "app/assets/stylesheets/hotwirebits/theme.css"))
      assert_match(/stylesheet_link_tag "hotwirebits\/theme"/, out)
    end
  end

  test "add copies component class and template" do
    Dir.mktmpdir do |dir|
      out, _, status = run_cli("add", "button", "card", "alert", chdir: dir)

      assert_predicate status, :success?
      assert_match(/Added: button/, out)
      assert_match(/Added: card/, out)
      assert_match(/Added: alert/, out)
      %w[button card alert].each do |name|
        assert File.file?(File.join(dir, "app/components/hotwirebits/#{name}_component.rb"))
        assert File.file?(File.join(dir, "app/components/hotwirebits/#{name}_component.html.erb"))
      end
    end
  end

  test "add works without a prior init" do
    Dir.mktmpdir do |dir|
      _, _, status = run_cli("add", "button", chdir: dir)

      assert_predicate status, :success?
      assert File.file?(File.join(dir, "app/components/hotwirebits/button_component.rb"))
    end
  end

  test "add reports unknown components" do
    Dir.mktmpdir do |dir|
      out, _, status = run_cli("add", "nope", chdir: dir)

      assert_predicate status, :success?
      assert_match(/Unknown component: nope/, out)
    end
  end

  test "list reports the full component catalogue" do
    Dir.mktmpdir do |dir|
      out, _, status = run_cli("list", chdir: dir)

      assert_predicate status, :success?
      catalogue = Dir[File.expand_path("../../app/components/hotwirebits/*_component.rb", __dir__)].size
      assert_match(/Available HotwireBits components \(#{catalogue}\)/, out)
    end
  end

  test "version prints the CLI version" do
    Dir.mktmpdir do |dir|
      out, _, status = run_cli("version", chdir: dir)

      assert_predicate status, :success?
      assert_match(/\Ahotwirebits v\d+\.\d+\.\d+\z/, out.strip)
    end
  end

  test "unknown command exits non-zero" do
    Dir.mktmpdir do |dir|
      _, _, status = run_cli("frobnicate", chdir: dir)

      refute_predicate status, :success?
    end
  end
end
