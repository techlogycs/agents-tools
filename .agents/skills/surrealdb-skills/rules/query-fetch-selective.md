# query-fetch-selective

Use `FETCH` selectively and only when link expansion is needed.

## Apply when

- A read path truly needs related records inline.

## Do

- Expand only the relationships required by the caller.

## Avoid

- Turning every read into a recursive object graph load.
