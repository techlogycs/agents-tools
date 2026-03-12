# state-use-variants-for-state

> Express interactive and media-driven styling with variants instead of extra conditional CSS

## Why It Matters

Tailwind provides variants for hover, focus, disabled, dark mode, reduced motion, responsive breakpoints, and many other states. Using those variants keeps stateful styling close to markup and reduces unnecessary custom CSS and imperative class toggling.

## Bad

```tsx
function SaveButton({ disabled }: { disabled: boolean }) {
  const className = disabled
    ? "bg-gray-300 text-gray-500"
    : "bg-blue-600 text-white";

  return (
    <button disabled={disabled} className={className}>
      Save
    </button>
  );
}
```

## Good

```tsx
function SaveButton({ disabled }: { disabled: boolean }) {
  return (
    <button
      disabled={disabled}
      className="bg-blue-600 text-white hover:bg-blue-700 disabled:bg-gray-300 disabled:text-gray-500 motion-reduce:transition-none"
    >
      Save
    </button>
  );
}
```

## Prefer Built-in Variants For

- interaction: `hover:`, `focus:`, `active:`, `disabled:`
- layout responsiveness: `sm:`, `md:`, `lg:`
- accessibility and user preferences: `dark:`, `motion-reduce:`, `contrast-more:`
- browser capability checks: `supports-[...]`

## See Also

- [class-keep-utilities-statically-detectable](./class-keep-utilities-statically-detectable.md)
- [rel-use-group-peer-and-has](./rel-use-group-peer-and-has.md)
