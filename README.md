# 🧱 HotwireBits

**The most comprehensive free UI component library for Ruby on Rails.**

[![CI](https://github.com/DonsWayo/hotwirebits/actions/workflows/ci.yml/badge.svg)](https://github.com/DonsWayo/hotwirebits/actions)
[![Gem Version](https://badge.fury.io/rb/hotwirebits.svg)](https://rubygems.org/gems/hotwirebits)
[![npm](https://img.shields.io/npm/v/@hotwirebits/stimulus)](https://www.npmjs.com/package/@hotwirebits/stimulus)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## What is HotwireBits?

HotwireBits is a **free, open-source** UI component library for Ruby on Rails with **240+ components** and **99 Stimulus controllers**. Each component ships in two formats:

- **ERB partials** — Copy-paste friendly, no magic
- **ViewComponent classes** — Ruby-first, testable, composable

All styled with **Tailwind CSS v4**, interactive via **Stimulus.js**, and fully **Turbo-compatible** including Turbo Native.

## Quick Start

### As a Gem

```ruby
# Gemfile
gem "hotwirebits"
```

```bash
bundle install
rails generate hotwirebits:install
```

### Copy-Paste (shadcn-style)

The repository ships a CLI for copying components into an existing Rails project:

```bash
git clone https://github.com/DonsWayo/hotwirebits
cd hotwirebits
bin/hotwirebits init
bin/hotwirebits add button card alert
```

`init` creates the component directories and copies the theme stylesheet. `add` copies the ViewComponent class and its template for each named component. Run `bin/hotwirebits help` for the full command list.

The published `hotwirebits` gem (0.1.0) does not include the CLI yet; use it from a checkout until the next release.

## Components

241 components across nine categories — Primitives, Form Controls, Data Display, Navigation, Overlays, Feedback, Layout, Advanced, and Marketing Blocks. Every component ships as an ERB partial in `app/views/hotwirebits/` and a ViewComponent class in `app/components/hotwirebits/`.

Run `bin/hotwirebits list` for the full list.

## Usage

### ERB Partials

```erb
<%= render HotwireBits::ButtonComponent.new(label: "Click me", variant: :primary) %>

<%= render HotwireBits::CardComponent.new(title: "Welcome", description: "Get started") do %>
  <p>Your content here</p>
<% end %>

<%= render HotwireBits::AlertComponent.new(type: :success, title: "Success!", message: "Changes saved.") %>
```

### With Stimulus

```erb
<%= render HotwireBits::DialogComponent.new(title: "Confirm", size: :md) do %>
  <p>Are you sure?</p>
  <div class="flex gap-2 justify-end">
    <%= render HotwireBits::ButtonComponent.new(label: "Cancel", variant: :outline) %>
    <%= render HotwireBits::ButtonComponent.new(label: "Confirm", variant: :primary) %>
  </div>
<% end %>
```

## Theme System

HotwireBits uses CSS custom properties (shadcn-style) for theming:

```css
/* Import the theme */
@import "hotwirebits/theme";

/* Or customize variables */
:root {
  --color-hw-primary: hsl(263 70% 58%);
  --color-hw-primary-foreground: hsl(0 0% 100%);
}
```

## Stimulus Controllers

99 Stimulus controllers for interactive components, registered with the `hw-` prefix:

```
accordion          activity-feed      ai-chat            alert
angle-slider       animated-number    autocomplete       badge
banner             burger             calendar           carousel
clipboard          code-highlight     collapsible        color-input
color-picker       combobox           command-bar        compare
confirm-dialog     confirm-popup      context-menu       cookie-consent
cookie-settings    countdown          data-view          date-range
datepicker         dialog             drag-drop          drawer
dropdown           feedback           file-browser       highlight
hover-3d           hover-card         hover-gallery      image
image-compare      image-zoom         inline-edit        inplace
input-number       json-input         kanban             knob
lightbox           like               listbox            marquee
menubar            month-picker       month-picker-input multiselect
nav-menu           newsletter         notification       otp
paginator          panel              password           password-strength
password-toggle    popover            portal             quickview
range-slider       rating             resizable          rich-text-editor
search             sheet              sidebar            signature
speed-dial         splitter           spoiler            stepper-form
steps              swap               switch             tabs
tag-input          tags               text-rotate        theme
theme-selector     time-picker        toast              toggle
toggle-button      toggle-group       tooltip            tree
two-factor         validator          voice-recorder
```

## License

MIT License — free for personal and commercial use.

## Test Suite

| Suite | Tests | Tool |
|-------|-------|------|
| Components & Helpers | 659 tests, 1433 assertions | Minitest |
| Stimulus Controllers | 254 tests | Vitest + jsdom |
| Generators | 11 tests | Minitest |

```bash
bundle exec rake test   # Ruby tests
npm test                # JavaScript tests
bundle exec standardrb  # Lint
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

1. Fork it
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -am 'feat: add amazing component'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Create a Pull Request
