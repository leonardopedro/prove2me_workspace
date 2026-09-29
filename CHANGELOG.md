# Changelog

All notable changes to the `prove2me_workspace` driver repo.
Changelog discipline adapted from `../typos` / `../velysterm` (Apache-2.0):
keep an `Unreleased` section at the top and append release/date entries;
history seeded from `git log --date=short`.

## [Unreleased]

- Cross-project review & plan rev. 2 (`PROJECT_REVIEW_AND_PLAN.md`), typos/ax-inspired
  tooling: doc index + backlinks (`scripts/doc_index.py`, incl. `--backlinks`/
  `--search` queries), debounced watcher (`scripts/watch_check.py`), ax-style task
  manifests (`tasks/`, `scripts/taskctl.py`, schema in `tasks/README.md`),
  `AGENTS.md`, expanded `README.md`, `references/INDEX.md`.
- Sibling-repo hygiene from the same plan: timepiece doc index + `health.sh` +
  CHANGELOG, test site checker + CI + AGENTS, dynamic-arctic AGENTS,
  australVM `rust-toolchain.toml` (1.97.1).

## Releases (skill version bumps)

- **0.10.9** (2026-09-23) — version-only release (`d49883a`).
- **0.10.8** (2026-09-22) — mission release API, captain principle 9,
  Mathlib-gap solver guidance (`d26f4af`).
- **0.10.7** (2026-09-20) — KEY principles of captain expanded to 8 numbered
  faithfulness principles (`37902ac`).
- **0.10.6** (2026-09-19) — version-only release (`32b7556`).
- **0.10.5** (2026-09-18) — moderator review loop: Changes-requested status,
  review reports, item flags (`a0677c0`).

## History (newest first, seeded from `git log`)

- 2026-09-24 `a22cd81` Merge remote-tracking branch 'upstream/main'
- 2026-09-23 `d49883a` Bump to 0.10.9: version-only release
- 2026-09-23 `0944693` Refresh the wave pipeline state and reuse theorems after the SM/BRST pass
- 2026-09-22 `d26f4af` Bump to 0.10.8: mission release API, captain principle 9, Mathlib-gap solver guidance
- 2026-09-21 `d38bc44` Ignore the Lean anonymous-name artefacts at the workspace root
- 2026-09-21 `d9a054c` Merge remote-tracking branch 'upstream/main'
- 2026-09-21 `91ef98e` Refresh the wave's solutions and register the reuse re-run for the new items
- 2026-09-21 `246ed0e` docs: update pipeline plan with session 37 — def generation, build status, next actions
- 2026-09-20 `37902ac` Bump to 0.10.7: KEY principles of captain expanded to 8 numbered faithfulness principles
- 2026-09-20 `6887366` fix: update def bundles, solutions, theorems, scripts, and lakefile for v4.33.1
- 2026-09-20 `36d7da7` docs: update pipeline plan with session 36 — def bundles self-contained, local build status, def generation results
- 2026-09-20 `ac14003` docs: update pipeline plan with session status and server compile analysis
- 2026-09-20 `863c53a` fix: add missing import for Def_ChapterScalaronWallEsa in ScalaronFiberFL
- 2026-09-20 `854457b` docs: update pipeline plan with session 35 status and server compile analysis
- 2026-09-20 `ddef652` Revert "chore: touch to force server cache refresh"
- 2026-09-20 `bdded11` chore: touch to force server cache refresh
- 2026-09-20 `9c96333` fix: make def bundles self-contained (import Mathlib + Definitions.Def_*), add missing theorems
- 2026-09-20 `6753bf3` fix: add missing theorem imports for ChapterScalaronFiberFL, update pipeline state and def bundles
- 2026-09-20 `ddb08aa` fix: update pipeline plan with session 19 status, local compilation verified, 4 target def bundles done
- 2026-09-20 `7c8622d` fix: apply def fixes and update pipeline plan
- 2026-09-19 `32b7556` Bump to 0.10.6: version-only release
- 2026-09-19 `8b3173f` fix: apply def fixes and update pipeline plan
- 2026-09-19 `4d56275` fix: add missing imports for def chain, update pipeline plan
- 2026-09-19 `4354d4b` Session 33: Compile all defs (v4.33.1), start upload, extend wave with timepiece sources
- 2026-09-19 `8805dcf` docs: update pipeline plan with session 32 status and git commit/push
- 2026-09-19 `e4206e3` docs: update with v4.33.1 compilation working (§1ze)
- 2026-09-19 `4c1a987` feat: migrate to Lean4 v4.33.1 for compilation
- 2026-09-19 `358085d` docs: update API base URL and Lean4 version separation strategy (§1zc)
- 2026-09-19 `1e9627c` docs: update pipeline plan and session summary with round 4 knowledge (§1zb)
- 2026-09-18 `ac74468` fix: regenerate def bundles, reset failed defs, update pipeline plan (§1zc)
- 2026-09-18 `fac0fc0` fix: update API status in pipeline plan (§1zb)
- 2026-09-18 `12fb7f6` fix: add missing import for NavierStokesDifferentialL2, regenerate def bundles, update lakefile
- 2026-09-18 `4d7c702` docs: update session summary and pipeline plan with round 3 knowledge
- 2026-09-18 `8d2a663` fix: namespace mismatch in QgOuterFockFlow, update build env and docs
- 2026-09-18 `b04ec88` Generate def bundles and thm/sol files for blocked chapters
- 2026-09-18 `1e9f2e5` Fix def bundles: regenerate from source, fix namespaces, add missing imports
- 2026-09-18 `e67d8af` Merge remote-tracking branch 'upstream/main'
- 2026-09-18 `4611adc` Fix the wave reuse check, which was comparing two different objects
- 2026-09-18 `a0677c0` Bump to 0.10.5: moderator review loop — Changes requested status, review reports, item flags
