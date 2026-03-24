# 🧱 HotwireBits

**The most comprehensive free UI component library for Ruby on Rails.**

[![CI](https://github.com/hotwirebits/hotwirebits/actions/workflows/ci.yml/badge.svg)](https://github.com/hotwirebits/hotwirebits/actions)
[![Gem Version](https://badge.fury.io/rb/hotwirebits.svg)](https://rubygems.org/gems/hotwirebits)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## What is HotwireBits?

HotwireBits is a **free, open-source** UI component library for Ruby on Rails with **240+ components** and **40+ Stimulus controllers**. Each component ships in two formats:

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

```bash
gem install hotwirebits_cli
hotwirebits init
hotwirebits add button card alert
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

40 Stimulus controllers for interactive components:

```
hw-accordion  hw-alert      hw-banner     hw-burger
hw-calendar   hw-carousel   hw-clipboard  hw-collapsible
hw-combobox   hw-cookie     hw-countdown  hw-datepicker
hw-dialog     hw-drawer     hw-dropdown   hw-feedback
hw-highlight  hw-kanban     hw-marquee    hw-menubar
hw-multiselect hw-otp       hw-password   hw-popover
hw-rating     hw-resizable  hw-search     hw-sheet
hw-sidebar    hw-speed-dial hw-spoiler    hw-steps
hw-swap       hw-switch     hw-tabs       hw-tags
hw-theme      hw-toast      hw-toggle     hw-tree
```

## License

MIT License — free for personal and commercial use.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -am 'feat: add amazing component'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Create a Pull Request
