---
name: shadcn-svelte
description: 'Use when creating, editing, reviewing, or debugging shadcn-svelte UI in Svelte or SvelteKit apps. Covers init and add CLI workflows, components.json, Tailwind setup, Bits UI composition, theming, dark mode, local component ownership, version-aware migration, and verification for shadcn-svelte components such as Button, Dialog, Sheet, Sidebar, Form, Chart, and Data Table surfaces.'
argument-hint: 'Describe the shadcn-svelte task, component, migration, or setup problem you want implemented or reviewed.'
---

# shadcn-svelte

Use this skill for shadcn-svelte work that goes beyond generic Svelte guidance.

This skill assumes the project may also benefit from these existing skills:
- `svelte-code-writer` for Svelte documentation lookup and autofixer validation
- `svelte-core-bestpractices` for general Svelte architecture, reactivity, and component design
- `tailwind-skills` when utility composition, tokens, or state-driven styling becomes the main problem

## When to Use

- Building or refactoring UI with shadcn-svelte components
- Adding shadcn-svelte to a Svelte or SvelteKit codebase
- Fixing broken `components.json`, aliases, CSS variables, or global styling setup
- Reviewing whether generated shadcn-svelte components are being used idiomatically
- Migrating shadcn-svelte work across Svelte, Tailwind, or library version changes
- Debugging Bits UI based behavior, dark mode, class composition, forms, chart surfaces, or local component overrides

## Default Workflow

1. Identify whether the task is actually shadcn-svelte specific.
If the issue is generic Svelte state, reactivity, routing, or component structure, rely on the Svelte skills first and use this skill for the library-specific parts.

2. Confirm the project shape before editing.
Check whether the app uses Svelte or SvelteKit, which package manager it already uses, whether Tailwind is installed, whether `components.json` exists, where the global CSS file lives, and whether aliases such as `$lib`, `$lib/components`, `$lib/components/ui`, and `$lib/utils` are already established.

3. Check the current shadcn-svelte documentation before changing APIs.
Use Context7 with `/websites/shadcn-svelte` whenever the task depends on exact install steps, CLI behavior, component APIs, theming details, or migration guidance.

4. Prefer the documented CLI workflow when adopting or extending the library.
For setup, prefer the project package manager equivalent of `pnpm dlx shadcn-svelte@latest init`. For standard components, prefer the project package manager equivalent of `pnpm dlx shadcn-svelte@latest add <component>` instead of hand-copying stale snippets.

5. Inspect the local generated structure before modifying behavior.
Look for `components.json`, the global CSS file, the `cn` utility, and generated component code under the configured `ui` alias or local components path. Treat those local files as the source of truth for the app.

6. Implement with local ownership and composition first.
shadcn-svelte components are intended to be copied into the application and customized there. Prefer editing the local component code, styles, and composition instead of wrapping everything with extra abstraction or trying to treat the system like a closed external widget library.

7. Preserve the version-specific styling model.
Current docs target Svelte 5 with Tailwind 4. Do not apply Tailwind 3 era configuration patterns, plugin assumptions, or legacy snippets to a Tailwind 4 project without verifying that the project is actually on a legacy stack.

8. Validate behavior and integration after changes.
Check imports, alias resolution, generated component ownership, dark mode behavior, token usage, responsive layout, keyboard behavior for interactive primitives, and whether the chosen setup matches the app's actual Svelte and Tailwind versions.

## Library-Specific Rules

### Setup and Configuration

- Prefer the documented CLI flow for initialization and component addition before manual setup.
- Keep `components.json` aligned with the actual project aliases, CSS file path, and component directories.
- Reuse the package manager already present in the repo rather than introducing a different one.
- Confirm that the project's global CSS includes the expected Tailwind imports, animation support, and theme variables for the stack that is actually installed.
- If the project is not on current shadcn-svelte requirements, consult the migration or legacy docs before changing setup files.

### Component Ownership and Composition

- Treat generated components as local application code, not as untouchable vendor artifacts.
- Prefer composing and extending the generated primitives in the local codebase rather than building parallel replacements with raw HTML when shadcn-svelte already owns that UI surface.
- Respect the Bits UI based composition model for interactive primitives such as dialogs, sheets, popovers, menus, comboboxes, and accordions.
- Keep imports consistent with the configured aliases and local file layout.
- Do not copy React `shadcn/ui` examples directly into Svelte projects without adapting them to shadcn-svelte and current Svelte syntax.

### Styling and Theming

- Prefer theme tokens, CSS variables, and utility classes over one-off custom CSS selectors.
- Preserve the app's existing light and dark mode strategy instead of introducing a second theming model.
- Use the local `cn` utility or equivalent class-merging convention already present in the project.
- For Tailwind 4 projects, prefer the current CSS-variable-driven setup from the shadcn-svelte docs instead of older Tailwind config patterns.
- If a component needs visual changes, first update local tokens, variants, or component classes before adding brittle page-specific overrides.

### Version Awareness and Migration

- Verify the current project stack before changing setup or generated code: Svelte version, Tailwind version, and installed shadcn-svelte generation style matter.
- The current mainline docs target Svelte 5 and Tailwind 4.
- If the project is on Svelte 5 with Tailwind 3 or on Svelte 4 with Tailwind 3, use the legacy or migration documentation instead of forcing current defaults into the repo.
- Be cautious with migration-sensitive areas such as form components, chart components, sidebar variables, animation packages, and Tailwind config differences.

### Accessibility and Interaction

- Preserve accessible names, focus behavior, keyboard interaction, and semantic structure for dialogs, menus, sheets, tabs, forms, and popovers.
- Verify that interactive primitives still behave correctly after local customization.
- Do not break responsive behavior while editing generated layouts or variants.

## Completion Checks

- The task actually uses shadcn-svelte patterns where that adds value, rather than recreating the same UI surface from scratch.
- The chosen setup path matches the repo's actual Svelte and Tailwind versions.
- `components.json`, aliases, global CSS, and generated component locations are internally consistent.
- Local component edits preserve the library's composition model instead of fighting it.
- Styling changes use tokens and utilities where possible and do not introduce avoidable brittle overrides.
- Interactive components remain accessible, responsive, and compatible with the project's dark mode strategy.
- Any migration-sensitive edits were checked against current or legacy docs as appropriate.

## Useful Prompts

- `Use shadcn-svelte to add a dialog, form, and toast flow to this SvelteKit app.`
- `Review this Svelte component tree and refactor it to use shadcn-svelte patterns where appropriate.`
- `Fix the shadcn-svelte setup in this project. Check aliases, components.json, global CSS, and Tailwind compatibility.`
- `Migrate this older shadcn-svelte screen to the current Svelte 5 and Tailwind 4 approach without breaking the UI.`
- `Customize these local shadcn-svelte components to match the app's theme without introducing brittle overrides.`
