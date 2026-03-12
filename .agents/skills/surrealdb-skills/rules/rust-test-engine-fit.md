# rust-test-engine-fit

Use the right engine for the test being written.

## Apply when

- Choosing between embedded and server-backed test setups.

## Do

- Use fast local engines for unit-style tests and real servers for behavior that depends on deployment semantics.

## Avoid

- Assuming one test mode covers permissions, live queries, and indexing equally well.
