# AGENTS.md

This repository stores project-scoped agent skills under `.agents/skills` and keeps supporting metadata in source control so both humans and AI agents can work the same way.

## Purpose

- Keep installable skills in the standard project path: `.agents/skills/<skill-name>`.
- Track upstream sources in `skills-lock.json`.
- Track risk assessments in `skills-audit.json`.
- Validate structure and audit state in CI before changes are merged.

## Repository Layout

- `.agents/skills/`: canonical project-scoped skills.
- `.github/scripts/add-skill.sh`: approved way to add a skill from an upstream source.
- `.github/scripts/update-skills.sh`: approved way to update installed skills.
- `.github/scripts/audit-skills.sh`: generates and verifies `skills-audit.json`.
- `.github/scripts/validate-skills.sh`: validates skill structure and markdown links.
- `.github/workflows/skills-ci.yml`: CI workflow for validation and audit verification.
- `skills-lock.json`: maps installed skills to upstream sources.
- `skills-audit.json`: committed audit report derived from the lockfile.

## Standard Workflow

### Add a skill

Use the wrapper instead of calling `npx skills add` directly:

```bash
make skills-add SOURCE=sveltejs/ai-tools SKILL=svelte-core-bestpractices
```

If you already have a full example command, you can paste it into the Make target:

```bash
make skills-add-command COMMAND="npx skills add https://github.com/sickn33/antigravity-awesome-skills --skill typescript-expert"
```

This does all of the following:

- installs only for GitHub Copilot
- keeps the skill under `.agents/skills`
- avoids agent-specific folders like `.windsurf`
- refreshes `skills-audit.json`

### Update skills

```bash
make skills-update
```

This updates installed skills and then regenerates both metadata files.

Note: `skills-lock.json` is not regenerated automatically by repository scripts.

### Refresh the audit report only

```bash
make skills-audit
```

### Validate locally

```bash
make skills-validate
./.github/scripts/audit-skills.sh --verify
```

## Rules For AI Agents

- Do not call raw `npx skills add` for normal repo changes unless you are intentionally testing the CLI itself.
- Use `make skills-add` or `.github/scripts/add-skill.sh` for new skills.
- Use `make skills-update` or `.github/scripts/update-skills.sh` for updates.
- Keep `.agents/skills`, `skills-lock.json`, and `skills-audit.json` in sync.
- Do not introduce agent-specific directories like `.windsurf`, `.cursor`, or similar as part of normal repository changes.
- If you modify installed skills or lockfile state, regenerate the audit file before finishing.

## Rules For Humans

- Review skill content under `.agents/skills` like normal source.
- Treat `skills-lock.json` as the source-of-truth for upstream provenance.
- Treat `skills-audit.json` as generated-but-committed metadata that must match the current lockfile.
- If CI says the audit file is stale, rerun the add/update/audit workflow and commit the regenerated file.

## CI Contract

CI currently enforces two independent checks:

- structural validation via `.github/scripts/validate-skills.sh`
- audit verification via `.github/scripts/audit-skills.sh --verify`

Audit verification fails when either of these is true:

- `skills-audit.json` is out of date relative to `skills-lock.json`
- a tracked skill has a `critical` audit result

Non-critical results are recorded in `skills-audit.json` but do not fail CI.

## Practical Notes

- The audit report is deterministic and committed on purpose so reviewers can see risk changes in diffs.
- The repository expects Node.js to be available because the workflow depends on `npx skills`.
- If a skill is installed manually outside the wrappers, normalize the repo afterward by regenerating lock and audit files and removing any non-standard agent folders.