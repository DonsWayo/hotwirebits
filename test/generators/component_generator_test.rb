# frozen_string_literal: true

require "test_helper"
require "rails/generators/test_case"
require "generators/hotwirebits/component_generator"

class ComponentGeneratorTest < Rails::Generators::TestCase
  tests HotwireBits::Generators::ComponentGenerator
  destination File.expand_path("../../tmp/generators", __dir__)
  setup :prepare_destination

  test "generates both formats by default" do
    run_generator %w[notification]

    assert_file "app/views/hotwirebits/_notification.html.erb"
    assert_file "app/components/hotwirebits/notification_component.rb" do |content|
      assert_match(/class NotificationComponent < Base/, content)
    end
    assert_file "app/components/hotwirebits/notification_component.html.erb"
    assert_file "app/javascript/controllers/hotwirebits/notification_controller.js" do |content|
      assert_match(/@hotwired\/stimulus/, content)
    end
  end

  test "generates erb partial only" do
    run_generator %w[notification --format=erb]

    assert_file "app/views/hotwirebits/_notification.html.erb"
    assert_no_file "app/components/hotwirebits/notification_component.rb"
    assert_file "app/javascript/controllers/hotwirebits/notification_controller.js"
  end

  test "generates view_component only" do
    run_generator %w[notification --format=view_component]

    assert_no_file "app/views/hotwirebits/_notification.html.erb"
    assert_file "app/components/hotwirebits/notification_component.rb"
    assert_file "app/components/hotwirebits/notification_component.html.erb"
  end

  test "skips stimulus controller when flag is set" do
    run_generator %w[notification --skip-stimulus]

    assert_file "app/views/hotwirebits/_notification.html.erb"
    assert_file "app/components/hotwirebits/notification_component.rb"
    assert_no_file "app/javascript/controllers/hotwirebits/notification_controller.js"
  end

  test "generated component inherits from Base" do
    run_generator %w[my_widget]

    assert_file "app/components/hotwirebits/my_widget_component.rb" do |content|
      assert_match(/module HotwireBits/, content)
      assert_match(/class MyWidgetComponent < Base/, content)
      assert_match(/@extra_attrs = attrs/, content)
    end
  end

  test "generated erb template has data-controller attribute" do
    run_generator %w[my_widget]

    assert_file "app/components/hotwirebits/my_widget_component.html.erb" do |content|
      assert_match(/data-controller="hw-my_widget"/, content)
    end
  end

  test "generated stimulus controller has connect and disconnect" do
    run_generator %w[my_widget]

    assert_file "app/javascript/controllers/hotwirebits/my_widget_controller.js" do |content|
      assert_match(/connect\(\)/, content)
      assert_match(/disconnect\(\)/, content)
    end
  end
end
