# frozen_string_literal: true

class PagesController < ApplicationController
  COMPONENTS = YAML.safe_load(
    File.read(Rails.root.join('config', 'components.yml')),
    permitted_classes: [Symbol]
  ).freeze

  CATEGORIES = {
    'primitives' => 'Primitives',
    'forms' => 'Form Controls',
    'data-display' => 'Data Display',
    'navigation' => 'Navigation',
    'overlays' => 'Overlays',
    'feedback' => 'Feedback',
    'layout' => 'Layout',
    'advanced' => 'Advanced',
    'marketing' => 'Marketing'
  }.freeze

  def index
    @categories = CATEGORIES
    @components = COMPONENTS
  end

  def show
    @component = COMPONENTS[params[:id]]
    if @component
      @id = params[:id]
      @source_rb = read_component_source(@id, 'rb')
      @source_erb = read_component_source(@id, 'erb')
    else
      render :not_found, status: :not_found
    end
  end

  def primitives
    load_category('primitives')
  end

  def forms
    load_category('forms')
  end

  def data_display
    load_category('data-display')
  end

  def navigation
    load_category('navigation')
  end

  def overlays
    load_category('overlays')
  end

  def feedback
    load_category('feedback')
  end

  def layout
    load_category('layout')
  end

  def advanced
    load_category('advanced')
  end

  def marketing
    load_category('marketing')
  end

  private

  def load_category(cat)
    @category = cat
    @category_name = CATEGORIES[cat]
    @components = COMPONENTS.select { |_, v| v['category'] == cat }
    render :category
  end

  def read_component_source(id, format)
    file_name = id.tr('-', '_')
    base_path = Rails.root.join('..', '..', 'app', 'components', 'hotwirebits')
    if format == 'rb'
      path = base_path.join("#{file_name}_component.rb")
      File.exist?(path) ? File.read(path) : '# Source not found'
    else
      path = base_path.join("#{file_name}_component.html.erb")
      File.exist?(path) ? File.read(path) : '<!-- Source not found -->'
    end
  end
end
