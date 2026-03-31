import { Application } from "@hotwired/stimulus"

/**
 * Create a Stimulus application and register a single controller for testing.
 *
 * Usage:
 *   const { application, container } = await setupController(
 *     "hw-accordion",
 *     AccordionController,
 *     `<div data-controller="hw-accordion">...</div>`
 *   )
 *
 * Returns { application, container } where container is the div#test-container
 * in which the HTML was inserted.
 */
export async function setupController(identifier, controllerClass, html) {
  // Clean up previous test
  const existing = document.getElementById("test-container")
  if (existing) existing.remove()

  const container = document.createElement("div")
  container.id = "test-container"
  container.innerHTML = html
  document.body.appendChild(container)

  const application = Application.start(container)
  application.register(identifier, controllerClass)

  // Wait for Stimulus to connect
  await new Promise((resolve) => setTimeout(resolve, 50))

  return { application, container }
}

/**
 * Teardown: stop application and remove test container.
 */
export function teardownController(application) {
  if (application) application.stop()
  const container = document.getElementById("test-container")
  if (container) container.remove()
}

/**
 * Dispatch a custom event on an element.
 */
export function dispatch(element, eventName, detail = {}) {
  const event = new CustomEvent(eventName, {
    bubbles: true,
    cancelable: true,
    detail,
  })
  element.dispatchEvent(event)
  return event
}

/**
 * Wait for a specified number of milliseconds.
 */
export function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}
