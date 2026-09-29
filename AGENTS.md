# AGENTS.md — prove2me_workspace (driver repo)

Agent guide for this checkout. This repo is the **cross-repo driver**: the
Prove2me skill, the timepiece upload pipeline, and the shared tooling that
serves the sibling research repos (`../timepiece`, `../unfer`, `../australVM`,
`../velysterm`, `../dynamic-arctic`, `../test`). It spans them; it never
*contains* them — write only inside this repo.

Layout follows the structure recommended by `ax`'s development docs
(`../ax/docs/development.md`, Apache-2.0): what you need, how you build, how
you test, where things live.

## Prerequisites

- Python 3 (stdlib only for most tools; PyYAML 6.x is present and used by
  `scripts/taskctl.py`).
- Lean toolchain only for the upload pipeline's local compile gate
  (`lake env lean` / elan 4.33.1). Set `PROVE2ME_SKIP_LOCAL_COMPILE=1` to
  disable that gate on checkouts with no Lean toolchain — never fake a pass.
- Credentials: `credentials.json` is **gitignored and must stay that way**;
  `PROVE2ME_API_KEY` for the platform API. Never send keys anywhere except
  `https://prove2.me/api/v1`.

## Layout map

| Path | Purpose |
|---|---|
| `SKILL.md` | Skill entry point (versioned; bump `metadata.version` on change). |
| `references/` | Skill docs by role — see `references/INDEX.md` first. |
| `PIPELINE_PLAN.md` | The upload runbook (state counts, wave history). |
| `pipeline/upload_pipeline.py` | Resilient uploader; state in `state/pipeline.json`. |
| `tasks/` + `scripts/taskctl.py` | Declarative task manifests over existing commands. |
| `scripts/` | ~25 standalone tools (compile, wave, metadata, watchers). |
| `state/` | Logs, pids, JSON state — regenerable, never hand-edit. |
| `debug/` | One-off debug scripts; safe to delete stale ones. |
| `PROJECT_REVIEW_AND_PLAN.md` | Cross-repo review + improvement plan (read first). |

## Health / verify entry points (ax `/healthz` pattern — exit 0 = healthy)

```bash
python3 pipeline/upload_pipeline.py --check    # API access
python3 pipeline/upload_pipeline.py --status    # plan vs. state
python3 pipeline/upload_pipeline.py --sync      # reconcile with platform
python3 scripts/taskctl.py health               # all declared tasks
python3 scripts/watch_check.py --help           # debounced re-check on edit
```

Sibling-repo gates are run *from those repos* (e.g. timepiece
`scripts/health.sh`, `python3 scripts/import_components.py BookProof --check`).
**No `lake build` / `cargo build` as a matter of course** — checks only, unless
the user explicitly asks for a compile.

## Rules

1. Ownership: modify only files inside this repo; siblings are read-only
   except in explicitly cross-repo work.
2. Commit in meaningful stages; push only established sync targets
   (this repo, `../timepiece`, `../test`, `../unfer`).
3. Patterns adapted from `../typos` and `../ax` are Apache-2.0; keep the
   attribution comment in every adapted artifact.
