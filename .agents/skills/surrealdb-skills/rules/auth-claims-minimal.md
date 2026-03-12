# auth-claims-minimal

Keep auth payloads minimal and derived permissions explicit.

## Apply when

- Defining what authenticated sessions carry.

## Do

- Store only the claims needed to evaluate authorization safely.

## Avoid

- Overloading tokens with sprawling business state.
