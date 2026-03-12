# auth-bucket-permissions

> Define explicit bucket permissions instead of relying on the default FULL access.

## Why It Matters

Buckets expose a separate write and read surface from tables. If a bucket is left at the default permissions, callers can often `put`, `get`, `delete`, `copy`, `rename`, `exists`, or `list` files more broadly than intended. SurrealDB makes `$action`, `$file`, and `$target` available precisely so file access policy can be enforced at the database boundary.

## Bad

```surql
DEFINE BUCKET uploads BACKEND "memory";

-- Any principal with access to the bucket can write or read arbitrary files.
f"uploads:/private/payroll.csv".put("...");
<string>f"uploads:/private/payroll.csv".get();
```

## Good

```surql
DEFINE BUCKET uploads BACKEND "memory"
	PERMISSIONS
		FOR put WHERE $auth != NONE AND string::starts_with($file, "uploads:/users/" + <string>$auth.id + "/")
		FOR get WHERE $auth != NONE AND string::starts_with($file, "uploads:/users/" + <string>$auth.id + "/")
		FOR delete WHERE $auth != NONE AND string::starts_with($file, "uploads:/users/" + <string>$auth.id + "/")
		FOR copy WHERE $auth != NONE
			AND string::starts_with($file, "uploads:/users/" + <string>$auth.id + "/")
			AND string::starts_with($target, "uploads:/users/" + <string>$auth.id + "/")
		FOR rename WHERE $auth != NONE
			AND string::starts_with($file, "uploads:/users/" + <string>$auth.id + "/")
			AND string::starts_with($target, "uploads:/users/" + <string>$auth.id + "/")
		FOR exists WHERE $auth != NONE AND string::starts_with($file, "uploads:/users/" + <string>$auth.id + "/")
		FOR list WHERE $auth != NONE AND string::starts_with($file, "uploads:/users/" + <string>$auth.id + "/");
```

## Notes

- `$action` identifies which file operation is being attempted.
- `$file` is the source file pointer being accessed.
- `$target` is available for `copy` and `rename` operations and should be validated separately.
- `head`, `exists`, and `list` can leak metadata even when content reads are blocked, so treat them as sensitive operations.

## See Also

- [auth-least-privilege](./auth-least-privilege.md)
- [auth-table-permissions](./auth-table-permissions.md)
- [mig-bucket-backend-explicit](./mig-bucket-backend-explicit.md)
