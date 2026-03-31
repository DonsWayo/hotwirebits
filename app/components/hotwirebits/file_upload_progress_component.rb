# frozen_string_literal: true

module HotwireBits
  class FileUploadProgressComponent < Base
    STATUSES = %i[uploading complete error].freeze

    def initialize(file_name:, progress: 0, status: :uploading, **attrs)
      @file_name = file_name
      @progress = progress.to_i
      @status = STATUSES.include?(status) ? status : :uploading
      @extra_attrs = attrs
    end

    def bar_color
      case @status
      when :complete then "bg-hw-success"
      when :error then "bg-hw-destructive"
      else "bg-hw-primary"
      end
    end

    def status_icon
      case @status
      when :complete
        %(<svg class="h-4 w-4 text-hw-success" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>)
      when :error
        %(<svg class="h-4 w-4 text-hw-destructive" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>)
      else
        %(<svg class="h-4 w-4 animate-spin text-hw-primary" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path></svg>)
      end
    end
  end
end
