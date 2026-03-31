/**
 * Global Vitest setup file.
 * Suppresses known jsdom StyleSheet.href errors that occur when
 * classList.toggle triggers CSS cascade resolution in jsdom.
 */

// Suppress jsdom's "get href called on invalid StyleSheet" errors
const originalConsoleError = console.error
console.error = (...args) => {
  const msg = typeof args[0] === "string" ? args[0] : String(args[0]?.message || "")
  if (msg.includes("StyleSheet") || msg.includes("get href")) return
  originalConsoleError.call(console, ...args)
}

// Suppress unhandled rejections from jsdom StyleSheet.href
process.on("unhandledRejection", (reason) => {
  if (reason?.message?.includes("StyleSheet") || reason?.message?.includes("get href")) return
  throw reason
})

// Suppress uncaught exceptions from jsdom StyleSheet.href
process.on("uncaughtException", (error) => {
  if (error?.message?.includes("StyleSheet") || error?.message?.includes("get href")) return
  throw error
})
