# frozen_string_literal: true

require "test_helper"
require "rails/generators/test_case"
require "generators/hotwirebits/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests HotwireBits::Generators::InstallGenerator
  destination File.expand_path("../../tmp/generators", __dir__)
  setup :prepare_destination

  test "copies theme stylesheet" do
    run_generator
    assert_file "app/assets/stylesheets/hotwirebits/theme.css"
  end

  test "creates stimulus controllers directory" do
    run_generator
    assert_file "app/javascript/controllers/hotwirebits/.keep"
  end

  test "adds stimulus import when index.js exists" do
    FileUtils.mkdir_p(File.join(destination_root, "app/javascript/controllers"))
    File.write(File.join(destination_root, "app/javascript/controllers/index.js"), "// controllers\n")

    run_generator

    assert_file "app/javascript/controllers/index.js" do |content|
      assert_match(/HotwireBits/, content)
    end
  end

  test "skips stimulus import when index.js does not exist" do
    run_generator
    assert_no_file "app/javascript/controllers/index.js"
  end
end
