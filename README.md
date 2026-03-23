# 🧱 RailsBits

**The most comprehensive free UI component library for Ruby on Rails.**

[![CI](https://github.com/railsbits/railsbits/actions/workflows/ci.yml/badge.svg)](https://github.com/railsbits/railsbits/actions)
[![Gem Version](https://badge.fury.io/rb/railsbits.svg)](https://rubygems.org/gems/railsbits)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## What is RailsBits?

RailsBits is a **free, open-source** UI component library for Ruby on Rails with **130+ components** and **40+ Stimulus controllers**. Each component ships in two formats:

- **ERB partials** — Copy-paste friendly, no magic
- **ViewComponent classes** — Ruby-first, testable, composable

All styled with **Tailwind CSS v4**, interactive via **Stimulus.js**, and fully **Turbo-compatible** including Turbo Native.

## Quick Start

### As a Gem

```ruby
# Gemfile
gem "railsbits"
```

```bash
bundle install
rails generate railsbits:install
```

### Copy-Paste (shadcn-style)

```bash
gem install railsbits_cli
railsbits init
railsbits add button card alert
```

## Components

### Primitives (20)
Button, Badge, Chip, Tag, Avatar, Status, Indicator, Label, Separator, Skeleton, Spinner, Typography, Kbd, Icon, CloseButton, Toggle, ThemeIcon, Progress, ProgressRing

### Form Controls (22)
Input, Password, Number, Search, Phone, Textarea, JsonInput, Checkbox, Radio, Switch, Toggle, Select, NativeSelect, Combobox, MultiSelect, Slider, Rating, DatePicker, InputOTP, InputTags, FileInput, ColorPicker

### Data Display (20)
Card, Table, DataTable, Stats, Stat, Timeline, TreeView, List, Image, CodeBlock, NumberFormatter, Diff, Highlight, Mark, Accordion, Collapsible, Spoiler, MeterGroup, ColorSwatch, FormGroup

### Navigation (15)
Navbar, Sidebar, Breadcrumb, Pagination, Tabs, Menu, Dropdown, NavigationMenu, Menubar, DockMenu, Steps, NavLink, Footer, Burger, SpeedDial

### Overlays (10)
Dialog, AlertDialog, Sheet, Drawer, Popover, Tooltip, HoverCard, Toast, Notification, LoadingOverlay

### Feedback (10)
Alert, EmptyState, Banner, SkeletonCard, Feedback, Swap, Countdown, AnimatedNumber, StatusDot, ThemeController

### Layout (20)
Container, Grid, Flex, Stack, Group, AspectRatio, ScrollArea, Resizable, Box, Center, SimpleGrid, Space, Divider, Join, Mask, BentoGrid, DeviceMockup, AppShell, Splitter, Fluid

### Advanced (10)
Carousel, Calendar, Chart, ChatBubble, Testimonial, KanbanBoard, Search, Clipboard, QRCode, Marquee

### Marketing Blocks (10)
Hero, FeatureSection, CTASection, PricingSection, FAQSection, TestimonialsSection, LogoCloud, AuthBlock, ErrorPage, CookieConsent

## Usage

### ERB Partials

```erb
<%= render RailsBits::ButtonComponent.new(label: "Click me", variant: :primary) %>

<%= render RailsBits::CardComponent.new(title: "Welcome", description: "Get started") do %>
  <p>Your content here</p>
<% end %>

<%= render RailsBits::AlertComponent.new(type: :success, title: "Success!", message: "Changes saved.") %>
```

### With Stimulus

```erb
<%= render RailsBits::DialogComponent.new(title: "Confirm", size: :md) do %>
  <p>Are you sure?</p>
  <div class="flex gap-2 justify-end">
    <%= render RailsBits::ButtonComponent.new(label: "Cancel", variant: :outline) %>
    <%= render RailsBits::ButtonComponent.new(label: "Confirm", variant: :primary) %>
  </div>
<% end %>
```

## Theme System

RailsBits uses CSS custom properties (shadcn-style) for theming:

```css
/* Import the theme */
@import "railsbits/theme";

/* Or customize variables */
:root {
  --color-rb-primary: hsl(263 70% 58%);
  --color-rb-primary-foreground: hsl(0 0% 100%);
}
```

## Stimulus Controllers

40 Stimulus controllers for interactive components:

```
rb-accordion  rb-alert      rb-banner     rb-burger
rb-calendar   rb-carousel   rb-clipboard  rb-collapsible
rb-combobox   rb-cookie     rb-countdown  rb-datepicker
rb-dialog     rb-drawer     rb-dropdown   rb-feedback
rb-highlight  rb-kanban     rb-marquee    rb-menubar
rb-multiselect rb-otp       rb-password   rb-popover
rb-rating     rb-resizable  rb-search     rb-sheet
rb-sidebar    rb-speed-dial rb-spoiler    rb-steps
rb-swap       rb-switch     rb-tabs       rb-tags
rb-theme      rb-toast      rb-toggle     rb-tree
```

## Comparison

| Feature | RailsBits | shadcn-rails | RailsBlocks | Maquina |
|---------|-----------|-------------|-------------|---------|
| **Price** | FREE | FREE | Freemium | FREE |
| **Components** | 130+ | 47 | ~60 | ~20 |
| **Stimulus** | 40 | 0 | ~10 | ~5 |
| **ERB Partial** | ✅ | ❌ | ✅ | ✅ |
| **ViewComponent** | ✅ | ✅ | ✅ | ❌ |
| **Tailwind v4** | ✅ | ❌ | ✅ | ✅ |
| **CLI** | ✅ | ✅ | ❌ | ❌ |

## License

MIT License — free for personal and commercial use.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -am 'feat: add amazing component'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Create a Pull Request
