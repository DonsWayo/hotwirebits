# frozen_string_literal: true

Rails.application.config.routes.draw do
  mount HotwireBits::Engine => '/hotwirebits'
end
