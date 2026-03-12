---
name: vite-skills
description: >
  Generic Vite best practices for type checking, environment variables, asset
  handling, and configuration. Use when writing, reviewing, or refactoring Vite
  projects. Based on official Vite documentation.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.0.0"
  sources:
    - Vite guide
    - Vite config reference
---

# Vite Best Practices

Generic guide for using Vite correctly in application and library projects. This first edition captures 4 rules that Vite explicitly documents and that frequently affect correctness in real projects.

## When to Apply

Reference these guidelines when:

- Configuring a new Vite project
- Reviewing environment-variable handling
- Organizing static assets
- Designing build and type-check workflows

## Rule Categories by Priority

| Priority | Category              | Impact   | Prefix   | Rules |
| -------- | --------------------- | -------- | -------- | ----- |
| 1        | Build Safety          | CRITICAL | `build-` | 1     |
| 2        | Environment Variables | CRITICAL | `env-`   | 1     |
| 3        | Asset Handling        | HIGH     | `asset-` | 1     |
| 4        | Configuration         | HIGH     | `cfg-`   | 1     |

---

## Quick Reference

### 1. Build Safety

- [build-separate-typecheck-from-transpile](rules/build-separate-typecheck-from-transpile.md) - Run TypeScript checking separately from the Vite build pipeline

### 2. Environment Variables

- [env-expose-only-safe-client-vars](rules/env-expose-only-safe-client-vars.md) - Only expose intentionally public client variables through the Vite env surface

### 3. Asset Handling

- [asset-use-imports-or-public-intentionally](rules/asset-use-imports-or-public-intentionally.md) - Choose imported assets or `public` assets intentionally based on how the file is used

### 4. Configuration

- [cfg-use-defineconfig-and-loadenv](rules/cfg-use-defineconfig-and-loadenv.md) - Structure Vite config with `defineConfig` and explicit env loading
