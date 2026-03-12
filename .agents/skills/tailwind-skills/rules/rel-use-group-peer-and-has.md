# rel-use-group-peer-and-has

> Use relationship variants to style based on parent, sibling, or descendant state

## Why It Matters

Tailwind documents `group-*`, `peer-*`, and `has-*` variants specifically so UIs can respond to nearby state without extra JavaScript or bespoke selector CSS. These patterns keep markup expressive while staying within Tailwind's utility model.

## Bad

```tsx
function Field({ invalid }: { invalid: boolean }) {
  return (
    <div
      className={invalid ? "border border-red-500" : "border border-gray-300"}
    >
      <input className="outline-none" />
      <p className={invalid ? "text-red-500" : "hidden"}>Invalid email</p>
    </div>
  );
}
```

## Good

```html
<label class="block">
  <span class="text-sm font-medium text-gray-700">Email</span>
  <input
    type="email"
    class="peer mt-1 block w-full border border-gray-300 invalid:border-red-500"
  />
  <p class="invisible mt-1 text-sm text-red-500 peer-invalid:visible">
    Please provide a valid email address.
  </p>
</label>
```

## More Patterns

```html
<a class="group block rounded-lg border p-4">
  <h3 class="text-gray-900 group-hover:text-white">New project</h3>
</a>
```

```html
<label class="has-checked:bg-indigo-50 has-checked:text-indigo-900">
  <input type="radio" />
  Credit Card
</label>
```

## See Also

- [state-use-variants-for-state](./state-use-variants-for-state.md)
- [class-keep-utilities-statically-detectable](./class-keep-utilities-statically-detectable.md)
