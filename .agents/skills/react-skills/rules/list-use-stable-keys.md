# list-use-stable-keys

> Use stable keys derived from data identity instead of array indexes or random values

## Why It Matters

React uses keys to match rendered children between updates. Unstable keys cause incorrect state preservation, broken animations, remount churn, and subtle UI bugs when items are inserted, removed, or reordered.

## Bad

```tsx
type Todo = {
  id: string;
  title: string;
};

export function TodoList({ todos }: { todos: Todo[] }) {
  return (
    <ul>
      {todos.map((todo, index) => (
        <li key={index}>{todo.title}</li>
      ))}
    </ul>
  );
}
```

## Also Bad

```tsx
{
  todos.map((todo) => <li key={Math.random()}>{todo.title}</li>);
}
```

## Good

```tsx
type Todo = {
  id: string;
  title: string;
};

export function TodoList({ todos }: { todos: Todo[] }) {
  return (
    <ul>
      {todos.map((todo) => (
        <li key={todo.id}>{todo.title}</li>
      ))}
    </ul>
  );
}
```

## See Also

- [render-keep-components-pure](./render-keep-components-pure.md)
- [effect-use-only-for-external-sync](./effect-use-only-for-external-sync.md)
