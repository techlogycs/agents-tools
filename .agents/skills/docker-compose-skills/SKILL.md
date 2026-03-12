---
name: docker-compose-skills
description: >
  Generic Docker Compose best practices for readiness, secrets, environment
  variables, and multi-file composition. Use when writing, reviewing, or
  refactoring Compose-based application definitions. Based on official Docker
  Compose documentation.
license: MIT
metadata:
  author: GitHub Copilot
  version: "1.0.0"
  sources:
    - Docker Compose docs
    - Compose file reference
---

# Docker Compose Best Practices

Generic guide for authoring maintainable and production-aware Compose files. This first edition focuses on 4 rules that Docker documents clearly because they affect reliability and security.

## When to Apply

Reference these guidelines when:

- Designing multi-service local or deployment environments
- Reviewing service readiness and dependency wiring
- Handling secrets and environment variables
- Splitting configuration across base and override files

## Rule Categories by Priority

| Priority | Category               | Impact   | Prefix    | Rules |
| -------- | ---------------------- | -------- | --------- | ----- |
| 1        | Service Readiness      | CRITICAL | `ready-`  | 1     |
| 2        | Secrets                | CRITICAL | `secret-` | 1     |
| 3        | Environment Variables  | HIGH     | `env-`    | 1     |
| 4        | Multi-file Composition | HIGH     | `merge-`  | 1     |

---

## Quick Reference

### 1. Service Readiness

- [ready-use-healthchecks-for-real-readiness](rules/ready-use-healthchecks-for-real-readiness.md) - Model startup readiness with health checks and conditional dependencies

### 2. Secrets

- [secret-use-compose-secrets-for-sensitive-data](rules/secret-use-compose-secrets-for-sensitive-data.md) - Use Compose secrets for sensitive values instead of plain environment variables

### 3. Environment Variables

- [env-use-env-vars-for-configuration-not-secrets](rules/env-use-env-vars-for-configuration-not-secrets.md) - Use environment variables for configuration, not secret material

### 4. Multi-file Composition

- [merge-validate-merged-compose-config](rules/merge-validate-merged-compose-config.md) - Design multi-file Compose setups around the merged output and validate it explicitly
