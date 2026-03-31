import { defineConfig } from "vitest/config"

export default defineConfig({
  test: {
    environment: "jsdom",
    globals: true,
    include: ["test/javascript/**/*.test.js"],
    setupFiles: ["./test/javascript/vitest-setup.js"],
    testTimeout: 10000,
  },
})
