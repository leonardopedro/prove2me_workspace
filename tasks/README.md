# Task manifests — schema reference

Declarative task manifests for `scripts/taskctl.py`. Pattern adapted from
`ax` (`../ax/docs/manifests.md`, Apache-2.0): k8s-style resources —
`apiVersion / kind / metadata / spec` — applied by a small CLI instead of
burying commands in prose. Manifests only **wrap** existing commands; no
logic lives here.

## File format

One YAML document per file under `tasks/` (`.yaml`/`.yml`). Every file must
declare `kind: Task` and a unique `metadata.name` — documents without either
are skipped with a warning.

```yaml
apiVersion: timepiece.dev/v1alpha1
kind: Task
metadata:
  name: docs                        # the name you pass to taskctl run
  description: one line shown by `taskctl list`
spec:
  steps:                            # executed in order, stop at first failure
    - name: index-check             # used in log file names; defaults to the index
      run: python3 scripts/doc_index.py --check
      health: true                  # included in `taskctl health` (default false)
    - name: rebuild
      run: python3 scripts/doc_index.py
      cwd: .                        # repo-relative working dir (default ".")
```

## Fields

| Field | Required | Meaning |
|---|---|---|
| `apiVersion` | yes | accepted value: `timepiece.dev/v1alpha1` (documented, not validated yet) |
| `kind` | yes | must be `Task`; other kinds are skipped |
| `metadata.name` | yes | task id for `taskctl run NAME` |
| `metadata.description` | no | one-line summary for `taskctl list` |
| `spec.steps[].run` | yes | command string (shlex-split, **no shell**) or a YAML list argv |
| `spec.steps[].name` | no | step label; defaults to the step index |
| `spec.steps[].cwd` | no | working directory relative to the repo root |
| `spec.steps[].health` | no | `true` ⇒ step runs under `taskctl health` |

## Semantics (the `/healthz` contract)

- `taskctl list` — show every declared task and step.
- `taskctl run NAME… [--dry-run]` — run steps in order; a non-zero exit stops
  that task (later tasks still run); exit 1 if any step failed.
- `taskctl health` — run **only** `health: true` steps across all tasks;
  exit 0 ⇔ every health step exited 0. This is the repo's single health
  entry point (pattern: ax `GET /healthz` → `200 OK`).
- Each step's combined stdout/stderr is tee'd to `state/tasks/<task>.<step>.log`.

## Declared tasks

| Task | File | What it wraps |
|---|---|---|
| `docs` | `docs.yaml` | doc-index freshness/rebuild, references index, `../test` site check |
| `pipeline` | `pipeline.yaml` | `upload_pipeline.py --status` (health), `--check`/`--sync` (on demand) |
| `timepiece` | `timepiece.yaml` | `../timepiece/scripts/health.sh`, import-components report |

Rules of thumb: keep commands as they are in their home repo (checks only —
never `lake build`/`cargo build`), mark a step `health: true` only if it is
local, deterministic, and safe to run on a clean checkout.
