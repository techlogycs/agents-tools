# asset-use-imports-or-public-intentionally

> Choose imported assets or `public` assets intentionally based on how the file is used

## Why It Matters

Vite supports both imported assets and files placed in `public`. Imported assets join the build graph, receive hashed filenames, and can be optimized. `public` assets are copied as-is and should be used only when hashing and import-based processing are not wanted.

## Bad

```ts
// Asset never joins the build graph and keeps a fragile hard-coded path.
const logoUrl = "/src/assets/logo.png";
```

## Good

```ts
import logoUrl from './assets/logo.png';

export function Header() {
  return <img src={logoUrl} alt="Logo" />;
}
```

## Also Good

```txt
public/robots.txt
public/icon.svg
```

```html
<link rel="icon" href="/icon.svg" />
```

## Prefer Imported Assets When

- the asset is referenced from source code
- hashed filenames are desirable
- plugin processing or optimization matters

## Prefer `public` When

- the file must keep its exact name
- the file is referenced without source import
- the file is a root-level web asset like `robots.txt`

## See Also

- [env-expose-only-safe-client-vars](./env-expose-only-safe-client-vars.md)
