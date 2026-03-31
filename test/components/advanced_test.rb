# frozen_string_literal: true

require "test_helper"

class HeroComponentTest < ViewComponent::TestCase
  test "renders centered hero" do
    render_inline(HotwireBits::HeroComponent.new(
      title: "Welcome",
      subtitle: "Get started today",
      primary_cta: {label: "Sign Up", href: "/signup"}
    ))

    assert_text "Welcome"
    assert_text "Get started today"
    assert_selector "a[href='/signup']", text: "Sign Up"
  end

  test "renders hero with secondary CTA" do
    render_inline(HotwireBits::HeroComponent.new(
      title: "Title",
      primary_cta: {label: "Primary", href: "/primary"},
      secondary_cta: {label: "Learn More", href: "/learn"}
    ))

    assert_selector "a[href='/primary']", text: "Primary"
    assert_selector "a[href='/learn']", text: "Learn More"
  end
end

class CarouselComponentTest < ViewComponent::TestCase
  test "renders carousel" do
    items = [{image: "/slide1.jpg", alt: "Slide 1"}, {image: "/slide2.jpg", alt: "Slide 2"}]
    render_inline(HotwireBits::CarouselComponent.new(items: items))

    assert_selector "div[data-controller='hw-carousel']"
    assert_selector "img[src='/slide1.jpg']"
    assert_selector "img[src='/slide2.jpg']"
  end

  test "renders carousel with arrows" do
    items = [{content: "Slide 1"}, {content: "Slide 2"}]
    render_inline(HotwireBits::CarouselComponent.new(items: items, show_arrows: true))

    assert_selector "button[data-action='click->hw-carousel#prev']"
    assert_selector "button[data-action='click->hw-carousel#next']"
  end

  test "renders carousel with dots" do
    items = [{content: "A"}, {content: "B"}]
    render_inline(HotwireBits::CarouselComponent.new(items: items, show_dots: true))

    assert_selector "button[data-hw-carousel-target='dot']", count: 2
  end
end

class CalendarComponentTest < ViewComponent::TestCase
  test "renders calendar" do
    render_inline(HotwireBits::CalendarComponent.new(date: Date.new(2026, 3, 15)))

    assert_selector "div[data-controller='hw-calendar']"
    assert_text "March"
    assert_text "2026"
  end
end

class KanbanBoardComponentTest < ViewComponent::TestCase
  test "renders kanban board" do
    columns = [
      {title: "To Do", items: [{title: "Task 1"}]},
      {title: "Done", items: [{title: "Task 2"}]}
    ]
    render_inline(HotwireBits::KanbanBoardComponent.new(columns: columns))

    assert_text "To Do"
    assert_text "Task 1"
    assert_text "Done"
    assert_text "Task 2"
    assert_selector "div[data-controller='hw-kanban']"
  end
end

class MarqueeComponentTest < ViewComponent::TestCase
  test "renders marquee" do
    render_inline(HotwireBits::MarqueeComponent.new) { "Scrolling text" }

    assert_selector "div[data-controller='hw-marquee']"
    assert_text "Scrolling text"
  end
end

class ClipboardComponentTest < ViewComponent::TestCase
  test "renders clipboard" do
    render_inline(HotwireBits::ClipboardComponent.new(text: "copy-me"))

    assert_selector "div[data-controller='hw-clipboard']"
  end

  test "renders with copy button" do
    render_inline(HotwireBits::ClipboardComponent.new(text: "text"))

    assert_selector "button"
  end
end

class QrCodeComponentTest < ViewComponent::TestCase
  test "renders QR code" do
    render_inline(HotwireBits::QrCodeComponent.new(value: "https://example.com"))

    assert_selector "svg"
  end
end

class SearchComponentTest < ViewComponent::TestCase
  test "renders search" do
    render_inline(HotwireBits::SearchComponent.new(placeholder: "Search..."))

    assert_selector "div[data-controller='hw-search']"
    assert_selector "input[placeholder='Search...']"
  end
end

class ChatBubbleComponentTest < ViewComponent::TestCase
  test "renders chat bubble" do
    render_inline(HotwireBits::ChatBubbleComponent.new(message: "Hello!", sender: "Alice"))

    assert_text "Hello!"
    assert_text "Alice"
  end

  test "renders outgoing bubble" do
    render_inline(HotwireBits::ChatBubbleComponent.new(message: "Hi!", direction: :outgoing))

    assert_text "Hi!"
  end
end

class TestimonialComponentTest < ViewComponent::TestCase
  test "renders testimonial" do
    render_inline(HotwireBits::TestimonialComponent.new(
      quote: "Great product!",
      author: "Jane",
      role: "CEO"
    ))

    assert_text "Great product!"
    assert_text "Jane"
    assert_text "CEO"
  end
end

class PricingSectionComponentTest < ViewComponent::TestCase
  test "renders pricing section" do
    plans = [
      {name: "Free", price: "$0", features: ["1 user", "10 items"]},
      {name: "Pro", price: "$10", features: ["5 users", "100 items"], highlighted: true}
    ]
    render_inline(HotwireBits::PricingSectionComponent.new(title: "Pricing", plans: plans))

    assert_text "Pricing"
    assert_text "Free"
    assert_text "$0"
    assert_text "Pro"
    assert_text "$10"
  end
end

class FaqSectionComponentTest < ViewComponent::TestCase
  test "renders FAQ section" do
    items = [
      {question: "What is this?", answer: "A UI library."},
      {question: "Is it free?", answer: "Yes!"}
    ]
    render_inline(HotwireBits::FaqSectionComponent.new(title: "FAQ", items: items))

    assert_text "FAQ"
    assert_text "What is this?"
    assert_text "A UI library."
    assert_text "Is it free?"
    assert_text "Yes!"
  end
end

class ErrorPageComponentTest < ViewComponent::TestCase
  test "renders error page" do
    render_inline(HotwireBits::ErrorPageComponent.new(code: 404, title: "Not Found", description: "Page missing"))

    assert_text "404"
    assert_text "Not Found"
    assert_text "Page missing"
  end

  test "renders with back link" do
    render_inline(HotwireBits::ErrorPageComponent.new(code: 500, title: "Error", action_label: "Go Back", action_href: "/"))

    assert_selector "a[href='/']"
  end
end
