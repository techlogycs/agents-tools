---
name: flowbite-svelte
description: 'Use when creating, editing, reviewing, or debugging Flowbite Svelte UI in Svelte or SvelteKit apps. Covers installation checks, Tailwind and Flowbite setup, component composition, class overrides, theming, icons, dark mode, and verification for Flowbite Svelte components such as Button, Modal, Dropdown, Navbar, Tabs, forms, and tables.'
argument-hint: 'Describe the Flowbite Svelte UI task, component, or screen you want implemented or reviewed.'
---

# Flowbite Svelte

Use this skill for Flowbite Svelte work that goes beyond generic Svelte guidance.

This skill assumes the project may also benefit from these existing skills:
- `svelte-code-writer` for Svelte documentation lookup and autofixer validation
- `svelte-core-bestpractices` for general Svelte architecture and reactivity decisions
- `tailwind-skills` when Tailwind utility composition becomes the main problem

## When to Use

- Building new UI with Flowbite Svelte components
- Refactoring existing Flowbite Svelte screens or layouts
- Fixing broken imports, styling overrides, dark mode, or icon usage
- Reviewing whether a Svelte component uses Flowbite Svelte idiomatically
- Verifying install and configuration issues involving Tailwind CSS and the Flowbite plugin

## Default Workflow

1. Identify whether the task is actually Flowbite Svelte specific.
If the issue is generic Svelte state, event handling, or component structure, rely on the Svelte skills first and only use this skill for the library-specific parts.

2. Confirm the package and environment shape before editing.
Check whether the project uses `flowbite-svelte`, `flowbite-svelte-icons`, Tailwind CSS, and Svelte or SvelteKit. Reuse the package manager already present in the repo.

3. Check the active library guidance before changing APIs.
Use Context7 with `/themesberg/flowbite-svelte` for current component APIs, setup details, and customization behavior. Do this whenever the task depends on exact props, snippets, classes, or install steps.

4. Inspect the project's Tailwind setup.
Look for `app.css`, `src/app.css`, `tailwind.config.*`, `vite.config.*`, and `package.json`. Confirm that Flowbite sources or plugin configuration match the project's Tailwind version.

5. Implement with composition first.
Prefer assembling screens from existing Flowbite Svelte primitives instead of rebuilding the same interaction with raw HTML unless the design clearly requires custom markup.

6. Customize with supported overrides.
Prefer documented props and normal class overrides first. If a component resists overrides, verify whether important utilities like `!bg-*` are needed before introducing brittle CSS.

7. Validate both behavior and integration.
Check imports, generated markup, dark mode behavior, responsive layout, keyboard behavior for interactive components, and whether class scanning includes the relevant files.

## Library-Specific Rules

### Setup and Configuration

- Follow the project's existing Tailwind generation model instead of forcing a new config style.
- Confirm that Flowbite plugin and source scanning cover the files actually used by the app.
- When icons are needed, prefer `flowbite-svelte-icons` over ad hoc inline SVG when the project already uses the icon package.
- Keep installation instructions aligned with the project's package manager and lockfile.

### Component Usage

- Import only the components that are actually used.
- Prefer Flowbite Svelte components for common UI primitives such as buttons, modals, navbars, dropdowns, tabs, inputs, and tables when the library already owns that surface.
- Keep Svelte state minimal and pass data into Flowbite components rather than wrapping them with unnecessary effects.
- Match the existing app's composition style. Do not introduce a new layout or variant system unless the task requires it.

### Styling and Theming

- Prefer Tailwind utility overrides and documented component class customization over custom CSS selectors.
- Use custom CSS only when the component API and utility overrides cannot express the requirement cleanly.
- Preserve the project's color tokens and dark mode strategy.
- Be cautious with aggressive overrides. If `!` utilities are required, use them narrowly and only after confirming the component's merged classes block standard overrides.

### Accessibility and Interaction

- Preserve accessible names for buttons, links, dialogs, and menus.
- For modal, dropdown, drawer, popover, and navbar behavior, verify focus flow and keyboard interaction after changes.
- Do not break responsive behavior while adjusting classes or slot content.

## Completion Checks

- The chosen Flowbite Svelte components match the task instead of reimplementing them from scratch.
- Imports resolve against packages already present in the project, or package additions are explicit.
- Tailwind and Flowbite setup remain consistent with the repo's current version and configuration style.
- Class overrides are minimal, intentional, and compatible with the library's merge behavior.
- The final component still follows Svelte best practices for state and events.
- Interactive components remain accessible and responsive.

## Useful Prompts

- `Use flowbite-svelte to build a responsive settings panel in this Svelte app.`
- `Review this Svelte component and replace custom modal code with Flowbite Svelte if appropriate.`
- `Fix the Tailwind or Flowbite setup so these Flowbite Svelte components render correctly.`
- `Update this navbar and dropdown to use Flowbite Svelte patterns without breaking dark mode.`