# frozen_string_literal: true

Rails.application.config.routes.draw do
  mount RailsBits::Engine => '/railsbits'
end
