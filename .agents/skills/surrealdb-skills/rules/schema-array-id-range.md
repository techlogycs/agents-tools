# schema-array-id-range

> Use range-friendly or predictable record IDs only for workloads that benefit from them

## Why It Matters

The real-time and performance guides both lean on predictable IDs for temporal querying, record ranges, and pre-computed views. ID design should match whether you need direct lookup, ordering, or partitioned scans.

## Bad

```surql
-- Opaque IDs make time-window reads harder than they need to be.
CREATE reading SET sensor = sensor:one, ts = time::now(), pressure = 600;
```

## Good

```surql
DEFINE TABLE reading SCHEMAFULL;
DEFINE FIELD id ON TABLE reading TYPE [record<sensor>, datetime];

CREATE reading:[sensor:one, time::now()] SET pressure = 600;

SELECT * FROM reading:[sensor:one, time::now() - 15m]..[sensor:one, time::now()];
```

For globally sortable IDs without compound keys, prefer ULIDs when ordering matters more than opaque UUIDs.

## See Also

- [perf-range-id](./perf-range-id.md)
- [rt-views-for-reads](./rt-views-for-reads.md)
