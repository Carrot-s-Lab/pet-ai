Create well-structured git commits that follow this repo's Lefthook-style convention, then push. Always split changes by type into separate commits. Handle `pubspec.yaml` version bumps as a special case (wording + optional tag).

## Convention summary

**Title format:** `type(scope)?: short summary`
- Summary must be ≥ 3 characters, lowercase, imperative mood.
- One commit per type — never join multiple types with `;` in one title.
- Allowed types: `feat | fix | hotfix | refactor | improvement | chore | docs | style | test | perf | ci | release | revert | build`.

**Body (always required when there are multiple tasks under a type):**
- One bullet per specific task done, each starting with a verb, lowercase.
- Even for a single task, include a body bullet if the title alone doesn't fully describe what changed.

**`pubspec.yaml` version-bump wording:**
- Build number `+1` (first build of a semver) → `build: new version X.Y.Z+1`
- Build number `+2` or higher → `build: bump version X.Y.Z+N`

## Step 1 — Read context

```bash
git status
git diff --staged
git diff
```

## Step 2 — Detect pubspec version change

```bash
git diff HEAD -- pubspec.yaml | grep -E '^[+-]version:'
```

If the `version:` line changed, parse the new `X.Y.Z+N` from `pubspec.yaml` and remember it for the wording + tag prompt.

## Step 3 — Group changes by type

Analyze all modified/added/deleted files and group logical changes by their commit type. Each group becomes one commit. Order: logic commits first (feat, fix, refactor, improvement, …), `build:` (pubspec version bump) last.

If a group's scope is ambiguous, pick the type that best describes the dominant intent.

## Step 4 — Compose each commit's title and body

For each group:
- Title: `type(scope)?: concise summary of all changes in this group`
- Body: bullet list of specific tasks, one per line, each starting with a verb:
  ```
  - add X to handle Y
  - update Z to use new API
  - remove deprecated W
  ```
- Append the `Co-Authored-By:` trailer.

### Examples

| Situation | Commit |
|---|---|
| One new feature | Title: `feat: add google login` <br>Body: `- add OAuth2 flow for Google sign-in` |
| Multiple fixes | Title: `fix(auth): resolve token and session issues` <br>Body: `- handle null token on refresh` / `- clear stale session on logout` |
| First build of 1.2.0 | Title: `build: new version 1.2.0+1` |
| Subsequent build | Title: `build: bump version 1.2.0+2` |
| Mixed feat + refactor | Two commits: `feat: ...` then `refactor: ...`, each with their own body |
| Mixed logic + version | Two commits: logic commit(s) first, then standalone `build: bump version X.Y.Z+N` |

## Step 5 — Show and confirm

Print all proposed commits (title + body) to the user in order. If `pubspec.yaml` version changed, also ask:

> Create git tag `X.Y.Z+N` and push to origin?

Wait for explicit approval before running any `git commit`.

## Step 6 — Commit and push

For each commit in order, stage only its relevant files (never `git add -A`), then commit:

```bash
git add <specific files for this commit>
git commit -m "$(cat <<'EOF'
<title>

- <task 1>
- <task 2>

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

After all commits are done:

```bash
git push
```

## Step 7 — Tag (only if approved)

```bash
git tag <X.Y.Z+N>
git push origin <X.Y.Z+N>
```

The tag name is the exact version string (no `v` prefix).
