# query-explicit-ordering

> Add deterministic ordering before pagination or first-row reads

## Why It Matters

Without explicit ordering, pagination and "first row" semantics are unstable as data volume, indexes, and write timing change.

## Bad

```surql
SELECT * FROM job LIMIT 20;
SELECT * FROM user WHERE active = true LIMIT 1;
```

## Good

```surql
SELECT * FROM job
ORDER BY created_at DESC, id DESC
LIMIT 20;

SELECT * FROM user
WHERE active = true
ORDER BY created_at ASC, id ASC
LIMIT 1;
```

## See Also

- [perf-pagination-stable](./perf-pagination-stable.md)
- [query-limit-intentional](./query-limit-intentional.md)
