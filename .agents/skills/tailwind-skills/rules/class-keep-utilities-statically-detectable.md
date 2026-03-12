# class-keep-utilities-statically-detectable

> Keep utility class names statically detectable instead of constructing fragments dynamically

## Why It Matters

Tailwind scans source files as plain text. If class names are built dynamically from fragments, Tailwind may never see the final utility and will not generate the CSS. The docs recommend mapping props to complete class strings instead.

## Bad

```tsx
function Button({ color }: { color: "red" | "green" }) {
  return (
    <button className={`bg-${color}-600 hover:bg-${color}-700 text-white`}>
      Save
    </button>
  );
}
```

## Good

```tsx
const buttonVariants = {
  red: "bg-red-600 hover:bg-red-700 text-white",
  green: "bg-green-600 hover:bg-green-700 text-white",
} as const;

function Button({ color }: { color: keyof typeof buttonVariants }) {
  return <button className={buttonVariants[color]}>Save</button>;
}
```

## See Also

- [state-use-variants-for-state](./state-use-variants-for-state.md)
- [rel-use-group-peer-and-has](./rel-use-group-peer-and-has.md)
