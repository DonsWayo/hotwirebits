# frozen_string_literal: true

module HotwireBits
  class CalendarComponent < Base
    def initialize(month: nil, year: nil, events: [], selected_date: nil, **attrs)
      @month = month || Date.today.month
      @year = year || Date.today.year
      @events = events
      @selected_date = selected_date
      @extra_attrs = attrs
    end

    def date
      Date.new(@year, @month, 1)
    end

    def days_in_month
      date.end_of_month.day
    end

    def start_wday
      date.wday
    end

    def month_name
      date.strftime("%B")
    end

    def events_for(day)
      d = Date.new(@year, @month, day)
      @events.select { |e| e[:date].to_s == d.to_s }
    end

    def selected?(day)
      @selected_date && Date.new(@year, @month, day) == @selected_date
    end

    def today?(day)
      Date.new(@year, @month, day) == Date.today
    end

    def container_classes
      merge_classes(
        "rounded-lg border border-hw-border bg-hw-card p-4",
        @extra_attrs.delete(:class)
      )
    end
  end
end
