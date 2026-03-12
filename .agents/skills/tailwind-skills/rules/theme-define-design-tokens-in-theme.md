# theme-define-design-tokens-in-theme

> Define reusable design tokens in the Tailwind theme layer when they should produce utilities

## Why It Matters

Tailwind documents `@theme` variables as more than ordinary CSS variables: they also generate utility classes and variants. When a value is a real design token intended for repeated use, putting it in the theme layer keeps utility APIs aligned with the design system.

## Bad

```css
:root {
  --brand-primary: oklch(0.72 0.11 178);
}
```

```html
<div class="bg-[var(--brand-primary)]"></div>
```

## Good

```css
@import "tailwindcss";

@theme {
  --color-brand-500: oklch(0.72 0.11 178);
}
```

```html
<div class="bg-brand-500 text-white"></div>
```

## Use `:root` Instead When

- the variable should not create a Tailwind utility
- the value is purely application-specific runtime state
- the variable exists only for custom CSS internals

## See Also

- [state-use-variants-for-state](./state-use-variants-for-state.md)
