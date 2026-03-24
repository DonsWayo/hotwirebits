# frozen_string_literal: true

module HotwireBits
  class PermissionBadgeComponent < Base
    ROLES = {
      admin: { bg: 'bg-red-100 text-red-700 border-red-200', label: 'Admin' },
      editor: { bg: 'bg-blue-100 text-blue-700 border-blue-200', label: 'Editor' },
      viewer: { bg: 'bg-gray-100 text-gray-700 border-gray-200', label: 'Viewer' },
      owner: { bg: 'bg-purple-100 text-purple-700 border-purple-200', label: 'Owner' }
    }.freeze

    def initialize(role: :viewer, label: nil, **attrs)
      @role = role
      @label = label
      @extra_attrs = attrs
    end

    def role_config
      ROLES[@role] || ROLES[:viewer]
    end

    def display_label
      @label || role_config[:label]
    end

    def badge_classes
      merge_classes(
        'inline-flex items-center gap-1.5 rounded-full border px-2.5 py-0.5 text-xs font-semibold',
        role_config[:bg]
      )
    end
  end
end
