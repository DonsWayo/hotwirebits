# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'

  # Component categories
  get 'primitives', to: 'pages#primitives'
  get 'forms', to: 'pages#forms'
  get 'data-display', to: 'pages#data_display'
  get 'navigation', to: 'pages#navigation'
  get 'overlays', to: 'pages#overlays'
  get 'feedback', to: 'pages#feedback'
  get 'layout', to: 'pages#layout'
  get 'advanced', to: 'pages#advanced'
  get 'marketing', to: 'pages#marketing'

  # Individual component pages (dynamic)
  get 'components/:id', to: 'pages#show', as: :component

  # API for component source code
  get 'api/components/:id/source', to: 'api#source', as: :component_source
end
