Generate a commit message in **Conventional Commits** format: `type(scope): description`.

## What to do

1. **Analyze** the user's staged changes (diff, file paths, and context).
2. **Pick the best type** from the list below based on the changes.
3. **Suggest a scope** from the codebase (e.g. domain name, feature area, or component). Prefer scopes like: `organization`, `recording`, `admin`, `patient-intake`, or a specific component/feature name. Use kebab-case.
4. **Write a short, imperative description** in present tense (e.g. "add custom questions admin" not "added" or "adds"). No period at the end. ~50 characters or less when possible.
5. **Run the commit script** with the full message: execute `.tools/git-commit.sh "<message>"` where `<message>` is the single-line `type(scope): description`. You must run this command; do not ask the user to run it.

## Commit types

| Type       | Use for                                      |
| ---------- | -------------------------------------------- |
| `feat`     | New feature or user-facing capability        |
| `fix`      | Bug fix                                      |
| `docs`     | Documentation only (README, comments, specs) |
| `style`    | Formatting, whitespace, no logic change      |
| `refactor` | Code restructure, no behavior change         |
| `perf`     | Performance improvement                      |
| `test`     | Adding or updating tests                     |
| `chore`    | Build, tooling, deps, config, maintenance    |

## Examples

- `feat(organization): add custom questions admin settings`
- `fix(patient-intake): validate phone before submit`
- `refactor(recording): split TranscriptRibbon into container and presenter`
- `chore(deps): bump react-query to 5.x`

## Notes

- **Scope**: Prefer one clear scope. If multiple areas are touched, choose the main one or omit scope: `type: description`.
- **Body**: Only suggest a body (second line / paragraph) if the change needs a short explanation or breaking-change note.
- **To commit**: You must execute `.tools/git-commit.sh "<message>"` with the generated message in quotes. The command performs the commit (and may offer to push); the user does not run the script.
