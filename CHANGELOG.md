# Changelog

All notable changes to HotwireBits will be documented in this file.

## [Unreleased]

### Added
- JavaScript test suite: 254 Vitest tests covering all 99 Stimulus controllers (15 original + 98 new)
- Full controller coverage: 34 stub controllers + 65 non-stub controllers all tested
- Generator tests: 11 Minitest tests for install and component generators
- CONTRIBUTING.md guide for new contributors
- CI job for JavaScript tests (`npm test`)

### Fixed
- CalendarComponentTest: fixed date-dependent test using proper month/year params
- bin/setup: fixed path resolution bug
- bin/hotwirebits: fixed RailsBits→HotwireBits naming, updated component list to 241
- Gemfile: removed 4 duplicate runtime dependencies
- gemspec: constrained tailwindcss-rails to ~> 3.0

### Changed
- All 33 ERB partials rewritten for consistency with ViewComponent counterparts
- StandardRB lint: 0 violations across entire codebase
- Removed dead `:spec` Rake task and empty `spec/` directory
- Removed audit_button.json from git tracking

## [0.1.0] - 2026-03-23

### Added
- Initial release with 240+ components
- Theme system with CSS custom properties (light/dark mode)
- 99 Stimulus controllers for interactive components
- CLI tool (`hotwirebits`) for copy-paste installation
- ERB partial + ViewComponent dual format for all components
- Tailwind CSS v4 support

### Components
- **Primitives**: Button, Badge, Chip, Tag, Avatar, Status, Indicator, Label, Separator, Skeleton, Spinner, Typography, Kbd, Icon, ThemeIcon
- **Forms**: Input, Password, Number, Search, Phone, Textarea, Checkbox, Radio, Switch, Toggle, Select, NativeSelect, Combobox, MultiSelect, Slider, Rating, DatePicker, InputOTP, InputTags, FileInput, ColorPicker, ColorSwatch, FormGroup
- **Data Display**: Card, Table, DataTable, Stats, Stat, Timeline, TreeView, List, Image, CodeBlock, NumberFormatter, Diff, Progress, ProgressRing, MeterGroup, Highlight, Mark, Accordion, Collapsible, Spoiler
- **Navigation**: Navbar, Sidebar, Breadcrumb, Pagination, Tabs, Menu, Dropdown, NavigationMenu, Menubar, DockMenu, Steps, NavLink, Footer, Burger, SpeedDial
- **Overlays**: Dialog, AlertDialog, Sheet, Drawer, Popover, Tooltip, HoverCard, Toast, Notification, LoadingOverlay
- **Feedback**: Alert, EmptyState, Banner, SkeletonCard, Feedback, Swap, Countdown, AnimatedNumber, StatusDot, ThemeController
- **Layout**: Container, Grid, Flex, Stack, Group, AspectRatio, ScrollArea, Resizable, Box, Center, SimpleGrid, Space, Divider, Join, Mask, BentoGrid, DeviceMockup, AppShell, Splitter, Fluid
- **Advanced**: Carousel, Calendar, Chart, ChatBubble, Testimonial, KanbanBoard, Search, Clipboard, QRCode, Marquee
- **Marketing**: Hero, FeatureSection, CTASection, PricingSection, FAQSection, TestimonialsSection, LogoCloud, AuthBlock, ErrorPage, CookieConsent
