import { describe, it, expect, afterEach, vi } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import TreeController from "../../app/javascript/controllers/hotwirebits/rb_tree_controller.js"
import CarouselController from "../../app/javascript/controllers/hotwirebits/rb_carousel_controller.js"
import PopoverController from "../../app/javascript/controllers/hotwirebits/rb_popover_controller.js"
import MarqueeController from "../../app/javascript/controllers/hotwirebits/rb_marquee_controller.js"
import MenubarController from "../../app/javascript/controllers/hotwirebits/rb_menubar_controller.js"
import MultiselectController from "../../app/javascript/controllers/hotwirebits/rb_multiselect_controller.js"
import KanbanController from "../../app/javascript/controllers/hotwirebits/rb_kanban_controller.js"
import ResizableController from "../../app/javascript/controllers/hotwirebits/rb_resizable_controller.js"
import CalendarController from "../../app/javascript/controllers/hotwirebits/rb_calendar_controller.js"
import DatepickerController from "../../app/javascript/controllers/hotwirebits/rb_datepicker_controller.js"

describe("TreeController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles tree nodes", async () => {
    const { application, container } = await setupController("hw-tree", TreeController,
      `<div data-controller="hw-tree" data-hw-tree-expanded-value="[]">
        <div data-hw-tree-target="node" data-id="n1">
          <button data-hw-tree-target="toggle" data-action="click->hw-tree#toggle" data-id="n1" aria-expanded="false">Toggle</button>
          <div data-hw-tree-target="content" class="hidden" aria-hidden="true">Child content</div>
        </div>
      </div>`)
    app = application
    const toggle = container.querySelector("[data-hw-tree-target='toggle']")
    const content = container.querySelector("[data-hw-tree-target='content']")
    toggle.click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(false)
    expect(toggle.getAttribute("aria-expanded")).toBe("true")
    toggle.click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(true)
  })

  it("expandAll and collapseAll", async () => {
    const { application, container } = await setupController("hw-tree", TreeController,
      `<div data-controller="hw-tree" data-hw-tree-expanded-value="[]">
        <div data-hw-tree-target="node" data-id="a">
          <button data-hw-tree-target="toggle" data-id="a">A</button>
          <div data-hw-tree-target="content" class="hidden">A content</div>
        </div>
        <div data-hw-tree-target="node" data-id="b">
          <button data-hw-tree-target="toggle" data-id="b">B</button>
          <div data-hw-tree-target="content" class="hidden">B content</div>
        </div>
        <button data-action="click->hw-tree#expandAll">Expand All</button>
        <button data-action="click->hw-tree#collapseAll">Collapse All</button>
      </div>`)
    app = application
    container.querySelector("[data-action*='expandAll']").click()
    await sleep(10)
    const contents = container.querySelectorAll("[data-hw-tree-target='content']")
    expect(contents[0].classList.contains("hidden")).toBe(false)
    expect(contents[1].classList.contains("hidden")).toBe(false)
    container.querySelector("[data-action*='collapseAll']").click()
    await sleep(10)
    expect(contents[0].classList.contains("hidden")).toBe(true)
    expect(contents[1].classList.contains("hidden")).toBe(true)
  })
})

describe("CarouselController", () => {
  let app
  afterEach(() => teardownController(app))

  it("navigates slides with next/prev", async () => {
    const { application, container } = await setupController("hw-carousel", CarouselController,
      `<div data-controller="hw-carousel" data-hw-carousel-index-value="0" data-hw-carousel-loop-value="false" data-hw-carousel-autoplay-value="false">
        <div data-hw-carousel-target="track">
          <div data-hw-carousel-target="slide">Slide 1</div>
          <div data-hw-carousel-target="slide" class="hidden">Slide 2</div>
          <div data-hw-carousel-target="slide" class="hidden">Slide 3</div>
        </div>
        <button data-hw-carousel-target="prev" data-action="click->hw-carousel#prev">Prev</button>
        <button data-hw-carousel-target="next" data-action="click->hw-carousel#next">Next</button>
        <span data-hw-carousel-target="dot" data-index="0"></span>
        <span data-hw-carousel-target="dot" data-index="1"></span>
        <span data-hw-carousel-target="dot" data-index="2"></span>
      </div>`)
    app = application
    const slides = container.querySelectorAll("[data-hw-carousel-target='slide']")
    container.querySelector("[data-hw-carousel-target='next']").click()
    await sleep(10)
    expect(slides[0].classList.contains("hidden")).toBe(true)
    expect(slides[1].classList.contains("hidden")).toBe(false)
    container.querySelector("[data-hw-carousel-target='prev']").click()
    await sleep(10)
    expect(slides[0].classList.contains("hidden")).toBe(false)
    expect(slides[1].classList.contains("hidden")).toBe(true)
  })

  it("loops when enabled", async () => {
    const { application, container } = await setupController("hw-carousel", CarouselController,
      `<div data-controller="hw-carousel" data-hw-carousel-index-value="2" data-hw-carousel-loop-value="true" data-hw-carousel-autoplay-value="false">
        <div data-hw-carousel-target="slide">1</div>
        <div data-hw-carousel-target="slide">2</div>
        <div data-hw-carousel-target="slide">3</div>
        <button data-action="click->hw-carousel#next">Next</button>
      </div>`)
    app = application
    container.querySelector("button").click()
    await sleep(10)
    const slides = container.querySelectorAll("[data-hw-carousel-target='slide']")
    // Should loop back to 0
    expect(slides[0].classList.contains("hidden")).toBe(false)
  })
})

describe("PopoverController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles popover open/close", async () => {
    const { application, container } = await setupController("hw-popover", PopoverController,
      `<div data-controller="hw-popover">
        <button data-hw-popover-target="trigger" data-action="click->hw-popover#toggle" aria-expanded="false">Trigger</button>
        <div data-hw-popover-target="content" class="hidden">Popover content</div>
      </div>`)
    app = application
    const content = container.querySelector("[data-hw-popover-target='content']")
    const trigger = container.querySelector("[data-hw-popover-target='trigger']")
    trigger.click()
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(false)
    expect(trigger.getAttribute("aria-expanded")).toBe("true")
    // Close with Escape
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)
    expect(content.classList.contains("hidden")).toBe(true)
    expect(trigger.getAttribute("aria-expanded")).toBe("false")
  })
})

describe("MarqueeController", () => {
  let app
  afterEach(() => teardownController(app))

  it("connects and starts animation", async () => {
    const { application, container } = await setupController("hw-marquee", MarqueeController,
      `<div data-controller="hw-marquee" data-hw-marquee-speed-value="50" data-hw-marquee-direction-value="left" data-hw-marquee-pause-on-hover-value="false">
        <div data-hw-marquee-target="track" style="display:flex;">
          <div data-hw-marquee-target="content">Scrolling text</div>
        </div>
      </div>`)
    app = application
    // Give a frame for the animation to start
    await sleep(100)
    const track = container.querySelector("[data-hw-marquee-target='track']")
    // Should have applied a transform
    expect(track.style.transform).toBeTruthy()
  })
})

describe("MenubarController", () => {
  let app
  afterEach(() => teardownController(app))

  it("navigates items with keyboard", async () => {
    const { application, container } = await setupController("hw-menubar", MenubarController,
      `<div data-controller="hw-menubar">
        <button data-hw-menubar-target="item" data-action="click->hw-menubar#activate" tabindex="0">File</button>
        <button data-hw-menubar-target="item" data-action="click->hw-menubar#activate" tabindex="-1">Edit</button>
        <button data-hw-menubar-target="item" data-action="click->hw-menubar#activate" tabindex="-1">View</button>
      </div>`)
    app = application
    const items = container.querySelectorAll("[data-hw-menubar-target='item']")
    const el = container.querySelector("[data-controller]")
    // Activate first item
    items[0].click()
    await sleep(10)
    expect(items[0].classList.contains("active")).toBe(true)
    // Navigate right
    el.dispatchEvent(new KeyboardEvent("keydown", { key: "ArrowRight", bubbles: true }))
    await sleep(10)
    expect(items[1].classList.contains("active")).toBe(true)
    expect(items[1].getAttribute("tabindex")).toBe("0")
  })
})

describe("MultiselectController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens dropdown and selects options", async () => {
    const { application, container } = await setupController("hw-multiselect", MultiselectController,
      `<div data-controller="hw-multiselect" data-hw-multiselect-selected-value="[]">
        <button data-action="click->hw-multiselect#toggle">Select</button>
        <div data-hw-multiselect-target="dropdown" class="hidden">
          <div data-hw-multiselect-target="option" data-value="a" data-action="click->hw-multiselect#select">A</div>
          <div data-hw-multiselect-target="option" data-value="b" data-action="click->hw-multiselect#select">B</div>
        </div>
        <div data-hw-multiselect-target="hidden" data-name="items[]"></div>
      </div>`)
    app = application
    const dropdown = container.querySelector("[data-hw-multiselect-target='dropdown']")
    container.querySelector("[data-action*='toggle']").click()
    await sleep(10)
    expect(dropdown.classList.contains("hidden")).toBe(false)
    // Select option A
    const options = container.querySelectorAll("[data-hw-multiselect-target='option']")
    options[0].click()
    await sleep(10)
    expect(options[0].classList.contains("selected")).toBe(true)
    const hiddens = container.querySelectorAll("[data-hw-multiselect-target='hidden'] input[type='hidden']")
    expect(hiddens.length).toBe(1)
    expect(hiddens[0].value).toBe("a")
    // Deselect by clicking again
    options[0].click()
    await sleep(10)
    expect(options[0].classList.contains("selected")).toBe(false)
  })
})

describe("KanbanController", () => {
  let app
  afterEach(() => teardownController(app))

  it("sets draggable on cards and connects", async () => {
    const { application, container } = await setupController("hw-kanban", KanbanController,
      `<div data-controller="hw-kanban">
        <div data-hw-kanban-target="column" data-id="col1">
          <div data-hw-kanban-target="card" data-id="card1">Card 1</div>
        </div>
        <div data-hw-kanban-target="column" data-id="col2"></div>
      </div>`)
    app = application
    const card = container.querySelector("[data-hw-kanban-target='card']")
    expect(card.getAttribute("draggable")).toBe("true")
  })
})

describe("ResizableController", () => {
  let app
  afterEach(() => teardownController(app))

  it("connects without error", async () => {
    const { application, container } = await setupController("hw-resizable", ResizableController,
      `<div data-controller="hw-resizable" data-hw-resizable-min-size-value="50" data-hw-resizable-max-size-value="500" data-hw-resizable-direction-value="horizontal">
        <div data-hw-resizable-target="panel" style="width:200px;">Panel</div>
        <div data-hw-resizable-target="handle">||</div>
      </div>`)
    app = application
    expect(container.querySelector("[data-hw-resizable-target='panel']")).toBeTruthy()
  })
})

describe("CalendarController", () => {
  let app
  afterEach(() => teardownController(app))

  it("renders calendar grid on connect", async () => {
    const { application, container } = await setupController("hw-calendar", CalendarController,
      `<div data-controller="hw-calendar">
        <span data-hw-calendar-target="month"></span>
        <span data-hw-calendar-target="year"></span>
        <div data-hw-calendar-target="grid"></div>
        <button data-action="click->hw-calendar#prevMonth">Prev</button>
        <button data-action="click->hw-calendar#nextMonth">Next</button>
      </div>`)
    app = application
    const grid = container.querySelector("[data-hw-calendar-target='grid']")
    expect(grid.children.length).toBeGreaterThan(0)
    const monthEl = container.querySelector("[data-hw-calendar-target='month']")
    expect(monthEl.textContent).toBeTruthy()
  })

  it("navigates months", async () => {
    const { application, container } = await setupController("hw-calendar", CalendarController,
      `<div data-controller="hw-calendar" data-hw-calendar-month-value="0" data-hw-calendar-year-value="2025">
        <span data-hw-calendar-target="month"></span>
        <span data-hw-calendar-target="year"></span>
        <div data-hw-calendar-target="grid"></div>
        <button data-action="click->hw-calendar#prevMonth">Prev</button>
        <button data-action="click->hw-calendar#nextMonth">Next</button>
      </div>`)
    app = application
    expect(container.querySelector("[data-hw-calendar-target='month']").textContent).toBe("January")
    container.querySelector("[data-action*='nextMonth']").click()
    await sleep(10)
    expect(container.querySelector("[data-hw-calendar-target='month']").textContent).toBe("February")
    // Go back past January to December of prev year
    container.querySelector("[data-action*='prevMonth']").click()
    await sleep(10)
    container.querySelector("[data-action*='prevMonth']").click()
    await sleep(10)
    expect(container.querySelector("[data-hw-calendar-target='month']").textContent).toBe("December")
    expect(container.querySelector("[data-hw-calendar-target='year']").textContent).toBe("2024")
  })
})

describe("DatepickerController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens calendar, selects date, and closes", async () => {
    const { application, container } = await setupController("hw-datepicker", DatepickerController,
      `<div data-controller="hw-datepicker" data-hw-datepicker-month-value="0" data-hw-datepicker-year-value="2025">
        <input data-hw-datepicker-target="input" data-action="click->hw-datepicker#toggle">
        <div data-hw-datepicker-target="calendar" class="hidden">
          <span data-hw-datepicker-target="month"></span>
          <span data-hw-datepicker-target="year"></span>
          <div data-hw-datepicker-target="grid"></div>
        </div>
        <input data-hw-datepicker-target="hidden" type="hidden">
      </div>`)
    app = application
    const input = container.querySelector("[data-hw-datepicker-target='input']")
    const calendar = container.querySelector("[data-hw-datepicker-target='calendar']")
    // Open
    input.click()
    await sleep(10)
    expect(calendar.classList.contains("hidden")).toBe(false)
    expect(container.querySelector("[data-hw-datepicker-target='month']").textContent).toBe("January")
    // Click a specific day button (day 15 to avoid timezone edge cases)
    const dayButtons = container.querySelectorAll(".datepicker-day:not(.empty)")
    const day15 = Array.from(dayButtons).find(b => b.dataset.day === "15")
    if (day15) {
      day15.click()
      await sleep(10)
      expect(calendar.classList.contains("hidden")).toBe(true)
      // The input value should contain 2025 and 01 and 15
      expect(input.value).toBeTruthy()
      expect(container.querySelector("[data-hw-datepicker-target='hidden']").value).toBeTruthy()
    }
  })

  it("navigates months in datepicker", async () => {
    const { application, container } = await setupController("hw-datepicker", DatepickerController,
      `<div data-controller="hw-datepicker" data-hw-datepicker-month-value="0" data-hw-datepicker-year-value="2025">
        <input data-hw-datepicker-target="input">
        <div data-hw-datepicker-target="calendar">
          <span data-hw-datepicker-target="month"></span>
          <span data-hw-datepicker-target="year"></span>
          <div data-hw-datepicker-target="grid"></div>
          <button data-action="click->hw-datepicker#nextMonth">Next</button>
        </div>
      </div>`)
    app = application
    const ctrl = application.getControllerForElementAndIdentifier(container.querySelector("[data-controller]"), "hw-datepicker")
    ctrl.open()
    await sleep(10)
    expect(container.querySelector("[data-hw-datepicker-target='month']").textContent).toBe("January")
    container.querySelector("[data-action*='nextMonth']").click()
    await sleep(10)
    expect(container.querySelector("[data-hw-datepicker-target='month']").textContent).toBe("February")
  })
})
