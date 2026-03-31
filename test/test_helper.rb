# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
require "rails/test_help"
require "view_component/test_helpers"

class ActiveSupport::TestCase
  # No parallelization for now — keep debugging simple
end

class ViewComponent::TestCase
  include ViewComponent::TestHelpers
end
