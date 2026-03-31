# Contributing to HotwireBits

Thanks for your interest in contributing! HotwireBits welcomes contributions of all kinds: bug fixes, new components, documentation improvements, and more.

## Prerequisites

- **Ruby 3.4+**
- **Node.js 18+** (for Stimulus controller tests)
- **Bundler** (`gem install bundler`)

## Getting Started

```bash
git clone https://github.com/DonsWayo/hotwirebits.git
cd hotwirebits
bundle install
npm install
```

## Running Tests

### Ruby Tests (components, generators, helpers)

```bash
bundle exec rake test
```

This runs 670+ tests covering all 241 ViewComponents, 33 ERB partials, generators, and helpers.

### JavaScript Tests (Stimulus controllers)

```bash
npm test
```

This runs 156 Vitest tests covering Stimulus controller behavior.

### Lint

```bash
bundle exec standardrb
```

All Ruby code must pass [StandardRB](https://github.com/standardrb/standard) with zero violations.

## Project Structure

```
app/
  components/hotwirebits/     # ViewComponent classes + templates
  javascript/controllers/     # 99 Stimulus controllers
  views/hotwirebits/          # ERB partials
config/
  locales/                    # I18n files
lib/
  hotwirebits/                # Engine, version, helpers
  generators/hotwirebits/     # Rails generators (install, component)
test/
  components/                 # ViewComponent tests
  generators/                 # Generator tests
  javascript/                 # Vitest tests for Stimulus controllers
  dummy/                      # Rails dummy app for testing
```

## Adding a New Component

Use the built-in generator:

```bash
rails generate hotwirebits:component my_widget
```

This creates:

- `app/components/hotwirebits/my_widget_component.rb`
- `app/components/hotwirebits/my_widget_component.html.erb`
- `test/components/hotwirebits/my_widget_component_test.rb`

### Component Guidelines

1. **Inherit from `HotwireBits::Base`** (not `ViewComponent::Base` directly)
2. **Store extra HTML attributes** in `@extra_attrs` for pass-through
3. **Use Tailwind CSS v4 classes** with `hw-` prefixed CSS custom properties for theming
4. **Add a Stimulus controller** in `app/javascript/controllers/hotwirebits/` if the component needs interactivity
5. **Register the controller** in `app/javascript/controllers/hotwirebits/index.js`
6. **Write tests** for both the Ruby component and the JS controller

### Naming Conventions

- Ruby class: `HotwireBits::MyWidgetComponent`
- ERB partial: `app/views/hotwirebits/_my_widget.html.erb`
- Stimulus controller: `rb_my_widget_controller.js` (file), `hw-my-widget` (identifier)
- Test files: `test/components/hotwirebits/my_widget_component_test.rb`, `test/javascript/my_widget_controller.test.js`

## Stimulus Controller Guidelines

- Controllers live in `app/javascript/controllers/hotwirebits/rb_<name>_controller.js`
- Always clean up event listeners in `disconnect()`
- Handle Turbo caching in `disconnect()` or via `turbo:before-cache`
- Use `static targets`, `static values`, and `static classes` where appropriate
- Guard optional targets with `this.hasXxxTarget` before accessing

## Code Style

- **Ruby**: StandardRB (auto-fixable with `bundle exec standardrb --fix`)
- **JavaScript**: Keep controllers focused and minimal; no external dependencies beyond `@hotwired/stimulus`

## Commit Messages

Use conventional commit style:

```
feat: add sparkline component
fix: dropdown not closing on outside click
docs: update README with new component count
test: add vitest tests for sidebar controller
refactor: extract shared modal behavior to base class
```

## Pull Request Process

1. Fork and create a feature branch from `main`
2. Make your changes with tests
3. Ensure all tests pass: `bundle exec rake test && npm test`
4. Ensure lint passes: `bundle exec standardrb --no-fix`
5. Open a PR against `main` with a clear description

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
