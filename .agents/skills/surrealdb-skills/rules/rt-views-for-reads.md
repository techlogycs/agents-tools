# rt-views-for-reads

> Use table views to materialize recurring read shapes and aggregations

## Why It Matters

The real-time guide treats table views as the right tool for predictable aggregated read models, especially when paired with temporal or predictable IDs. They let the database maintain the read shape instead of every caller re-deriving it.

## Bad

```surql
SELECT sensor, time::floor(ts, 1h) AS hour, math::avg(pressure)
FROM reading
GROUP BY sensor, hour;
```

## Good

```surql
DEFINE TABLE pressure_hourly AS
	SELECT
		id[0] AS sensor,
		time::format(time::floor(id[1], 1h), "%Y-%m-%dT%H:00:00Z") AS hour,
		math::avg(pressure) AS avg_pressure
	FROM reading
	GROUP BY sensor, hour;

SELECT * FROM pressure_hourly;
```

## See Also

- [schema-array-id-range](./schema-array-id-range.md)
- [perf-table-view-read-model](./perf-table-view-read-model.md)
