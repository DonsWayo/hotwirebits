# frozen_string_literal: true

module HotwireBits
  class PermissionBadgeComponent < Base
    ROLES = {
      admin: { bg: 'bg-hw-destructive/10 text-hw-destructive border-red-200', label: 'Admin' },
      editor: { bg: 'bg-hw-info/10 text-hw-info border-blue-200', label: 'Editor' },
      viewer: { bg: 'bg-hw-muted text-hw-foreground border-gray-200', label: 'Viewer' },
      owner: { bg: 'bg-hw-primary/10 text-hw-primary border-purple-200', label: 'Owner' }
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
