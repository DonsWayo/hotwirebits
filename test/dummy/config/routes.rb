# frozen_string_literal: true

Rails.application.routes.draw do
  mount HotwireBits::Engine => '/hotwirebits'
end
