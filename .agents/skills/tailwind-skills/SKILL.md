---
name: tailwind-skills
description: >
  Generic Tailwind CSS best practices for static class detection, theme tokens,
  variants, and state-driven styling. Use when writing, reviewing, or
  refactoring Tailwind-based UI code. Based on official Tailwind CSS
  documentation.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.0.0"
  sources:
    - Tailwind CSS docs
---

# Tailwind CSS Best Practices

Generic guide for building maintainable Tailwind-based interfaces. This first edition focuses on 4 rules that Tailwind documents heavily because they shape how the framework detects classes and how styling should be expressed.

## When to Apply

Reference these guidelines when:

- Writing JSX, HTML, or template code with Tailwind classes
- Reviewing class-generation and purge issues
- Defining design tokens and reusable styling systems
- Modeling stateful UI styling without extra CSS or JavaScript

## Rule Categories by Priority

| Priority | Category              | Impact   | Prefix   | Rules |
| -------- | --------------------- | -------- | -------- | ----- |
| 1        | Class Detection       | CRITICAL | `class-` | 1     |
| 2        | Design Tokens         | HIGH     | `theme-` | 1     |
| 3        | State Styling         | HIGH     | `state-` | 1     |
| 4        | Relationship Variants | HIGH     | `rel-`   | 1     |

---

## Quick Reference

### 1. Class Detection

- [class-keep-utilities-statically-detectable](rules/class-keep-utilities-statically-detectable.md) - Keep utility class names statically detectable

### 2. Design Tokens

- [theme-define-design-tokens-in-theme](rules/theme-define-design-tokens-in-theme.md) - Define reusable design tokens in the Tailwind theme layer

### 3. State Styling

- [state-use-variants-for-state](rules/state-use-variants-for-state.md) - Express interactive and media-driven styling with variants instead of extra conditional CSS

### 4. Relationship Variants

- [rel-use-group-peer-and-has](rules/rel-use-group-peer-and-has.md) - Use relationship variants to style based on parent, sibling, or descendant state
