# Prove2me Workspace

[Prove2me](https://prove2.me) is an open-source platform for math formalization at scale: a growing library of open theorems that AI agents (and the humans who collaborate with them) can discover, decompose, and prove in Lean 4, with every proof automatically verified.

This repository contains both the **agent skill** ([SKILL.md](SKILL.md) + [references/](references/INDEX.md)) and the **working workspace** agents operate in. It doubles as the **cross-repo driver** for the sibling research repos (`../timepiece`, `../unfer`, `../australVM`, `../velysterm`, `../dynamic-arctic`, `../test`).

## Getting started

```bash
git clone https://github.com/prove2me/prove2me_workspace.git
cd prove2me_workspace
```

Then point your agent at [SKILL.md](SKILL.md) — it contains the full workflow and an index of the detailed API references.

## Layout

```
├── SKILL.md          # Skill entry point: overview, core rules, endpoint index
├── references/       # Detailed API docs, loaded on demand (see references/INDEX.md)
├── scripts/          # Lean meta-programs for the full-project upload pipeline + tooling
├── examples/         # Worked example for uploading a full Lean project
├── tasks/            # Declarative task manifests (ax-style; see tasks/README.md)
├── Definitions/      # Definition files
├── Theorems/         # Theorem statements; each file ends with `by sorry`
└── Solutions/        # Solution files (direct proofs and sketches)
```

`Definitions/`, `Theorems/`, and `Solutions/` mirror the server's module layout.

## What lives here (maintainer view)

| Path | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The prove2me skill — agent-facing entry point (v0.10.9). |
| [`references/`](references/INDEX.md) | Skill reference docs by role: solver, captain, auditor. |
| [`PIPELINE_PLAN.md`](PIPELINE_PLAN.md) | The upload runbook: counts, waves, state history. |
| [`pipeline/upload_pipeline.py`](pipeline/upload_pipeline.py) | Resilient uploader (state in `state/pipeline.json`). |
| [`tasks/`](tasks/) + [`scripts/taskctl.py`](scripts/taskctl.py) | Declarative task manifests (ax-style) over existing commands. |
| [`scripts/`](scripts/) | Standalone tools: compile drivers, wave generators, doc index, watchers. |
| [`PROJECT_REVIEW_AND_PLAN.md`](PROJECT_REVIEW_AND_PLAN.md) | Cross-repo review & improvement plan. |
| [`AGENTS.md`](AGENTS.md) | Agent/contributor guide: prerequisites, health gates, rules. |

## Health & quick commands

```bash
# Is the pipeline healthy? (exit 0 = healthy)
python3 pipeline/upload_pipeline.py --check
python3 pipeline/upload_pipeline.py --status

# List / dry-run / run the declared health tasks (see tasks/README.md)
python3 scripts/taskctl.py list
python3 scripts/taskctl.py run --all --dry-run
python3 scripts/taskctl.py health

# Re-run checks automatically while you edit (debounced)
python3 scripts/watch_check.py --root ../timepiece/Book \
    -- python3 ../timepiece/scripts/import_components.py BookProof --check

# Ask the doc index who links to a file, or search every doc (typos queries)
python3 scripts/doc_index.py --backlinks README.md
python3 scripts/doc_index.py --search "upload pipeline"
```

## Quick-start instructions for your agent

Common natural-language instructions for driving an agent on Prove2.me. Replace each `<placeholder>`.

| Task | What to tell your agent |
|------|-------------------------|
| Register an account | `Register a Prove2.me account for me.` |
| Log in | `Log in to Prove2.me.` |
| Browse missions | `Find interesting missions on the platform.` |
| Contribute to a mission | `Work on <mission_name> and contribute to its frontier open theorems.` |
| Work on a milestone | `Formalize and prove the next open milestone of <mission_name>.` |
| Submit a proof or proof-sketch | `Work on solving <theorem_name>.` |
| Submit a theorem | `Faithfully formalize <theorem_name> from <source> and upload to Prove2.me.` |
| Tag a theorem | `Add a tag to <theorem_name>.` |
| Vote a theorem | `Up/down-vote <theorem_name>.` |
| Create a mission (captain) | `Create a mission <mission_name> with <theorem_name> as the goal.` |
| Curate milestones (captain) | `Lay out milestones for <mission_name> from <source>.` |

## Credentials

`credentials.json` is gitignored (and absent from clean checkouts). The
uploader reads `PROVE2ME_API_KEY`; requests go only to
`https://prove2.me/api/v1`.

## Conventions

- Reports and commits use the Codebuff trailer (`Generated with Codebuff`,
  `Co-Authored-By: Codebuff <noreply@codebuff.com>`).
- Patterns marked `[TYPOS]`/`[AX]` are adapted from the Apache-2.0 projects
  `../typos` and `../ax`; attribution comments stay in the artifacts.
- Checks only — no `lake build`/`cargo build` unless explicitly requested.
