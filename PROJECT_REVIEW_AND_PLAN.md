# Cross-project review & improvement plan — 2026-09-24 (rev. 2, deep pass)

Scope: the six sibling repos of this workspace — `../unfer/`, `../australVM/`,
`../velysterm/`, `../timepiece`, `../dynamic-arctic`, `../test/` — plus this repo
(`prove2me_workspace`, the cross-repo driver). Studied for inspiration:
`../typos/` and `../ax/`, both **Apache-2.0**, so adapting their *patterns* is
license-safe; every adapted artifact carries an attribution comment naming the
source project and license. No Lean 4 proof code is written here — that stays
with the LLM-Lean4-specialist (per `timepiece/CONSOLIDATED_PLAN.md` §2026-09-24a).

Rev. 2 (same day): the review in §1 was re-verified file-by-file against the
working trees, the typos/ax sources were read in full for the patterns worth
adapting (§1.3), and the plan gained four new adapted items (T5, A5, H6, H7)
plus per-item acceptance results (§4).

**Execution constraints (hard):**
- No `lake build` / no Lean compilation. Allowed gate:
  `python3 scripts/import_components.py BookProof --check`.
- No `cargo build`/`go build` of siblings (toolchain files and docs only).
- Commit per repo with the Codebuff trailer; push only the established sync
  targets: `timepiece`, `test`, `prove2me_workspace` (unfer unchanged — no
  commit). `australVM`, `dynamic-arctic`, `velysterm` get local commits only
  (not established push targets).

---

## 1. Whole-project review — findings (rev. 2, re-verified)

### 1.1 Per-repo state (as found → after this plan)

| Repo | What it is | CI | AGENTS.md | LICENSE | Gaps as found → addressed here |
|---|---|---|---|---|---|
| `timepiece` | Lean 4 proof tree (Book/ BookProof/ ~900 modules, CONSOLIDATED_PLAN ~15.4k l) | `ci.yml` | ✓ | Apache-2.0 | no doc index/CHANGELOG/health entry point → **now** `scripts/doc_index.py` + `DOC_INDEX.md` + `CHANGELOG.md` + `scripts/health.sh`; findings kept: tracked bytecode file, backlink graph has 0 links (see §1.4) |
| `prove2me_workspace` (cwd) | Skill + upload pipeline (SKILL.md v0.10.9, PIPELINE_PLAN 4790 l, ~25 scripts) | `lean_action_ci.yml` | **was missing → now ✓** | missing (owner decision) | README 1-line stub → expanded; no doc index/CHANGELOG/tasks → now `DOC_INDEX.md`, `references/INDEX.md`, `CHANGELOG.md`, `tasks/`+`taskctl.py`, `watch_check.py`; `state/` ignore swallowed the versioned indexes → H7 |
| `unfer` | Rust probability kernel + Cadabra modules, PLAN A (A1–A10) | `ci.yml` | ✓ | Apache-2.0 | healthy as found; clean tree; no changes needed (no CHANGELOG — flagged only) |
| `australVM` | OCaml Austral compiler + Rust cranelift bridge | `build-and-test.yml`, `build-macos.yml` | ✓ | ✓ | **pin was missing** although dynamic-arctic's pin file + README claim a shared 1.97.1 → **now** root `rust-toolchain.toml` (H1); verified: both Cargo workspaces sit one level below root, so rustup's walk-up resolves the pin from either |
| `velysterm` | Rust editor/agent workspace | `rust.yml` | ✓ | MIT/Apache-2.0 | best-in-class already (CHANGELOG, PROGRESS, docs/) — used as the in-family model; untouched |
| `dynamic-arctic` | Rust Arctic threshold-signature crate | `ci.yml` (SHA-pinned) | **was missing → now ✓** | MIT (Ian Goldberg) | AGENTS.md added from README+CI (H4) |
| `test` | GitBook-style docs site (SUMMARY.md 69 l, 50 pages) | **was missing → now ✓** | **was missing → now ✓** | missing (owner decision) | no CI, no checker, no agent guide, no .gitignore → **now** `scripts/check_site.py` + `.github/workflows/site-check.yml` (SHA-pin copied from dynamic-arctic's verified pin; branch `master` matches `origin/HEAD`) + `AGENTS.md` + `.gitignore` (H6); **`node_modules` untracked on owner's call (2026-09-24a): 1070 files dropped from the index, files kept on disk, now ignored** |

### 1.2 cross-cutting findings → status

1. **Toolchain pin gap** (australVM) → **fixed** (H1); all four Rust repos now
   pin `channel = "1.97.1"` (re-verified by reading each `rust-toolchain.toml`).
2. **CI gaps** → **fixed**: `test/` now runs `check_site.py` as CI
   (SUMMARY drift, broken links, backlink report). Pin
   `actions/checkout@3d3c42e5…` reuses dynamic-arctic's known-good SHA.
3. **AGENTS.md coverage** → **complete** across all seven repos after H2/H4/H6.
4. **README stub** (cwd) → **fixed** (H3). Workspace-root `../README.md` is out
   of scope (root git repo has no commits).
5. **License ambiguity** (`prove2me_workspace`, `test`) → **flagged, NOT
   executed**: requires the owner.
6. **No machine-readable index/backlinks** → **fixed** where it mattered:
   cwd + timepiece get `doc_index.py` (versioned JSON, (source,target) dedup,
   incremental `--file`, `--check` freshness), test gets the check_site
   backlink graph. *New finding:* timepiece's graph has **0 links — the prose
   corpus genuinely doesn't cross-link** its 61 docs; we do not force links
   (content decision for the maintainers; the index will pick them up as they
   appear). Query surface added in T5 so the graph is actually usable.
7. **Changelog discipline** → cwd + timepiece + velysterm keep CHANGELOGs;
   unfer/australVM/dynamic-arctic flagged (their release flow is CI-driven,
   no changelog habit — not imposed).
8. **Health fragmentation** → **unified per repo, no logic moved**:
   cwd `taskctl.py health` (aggregates docs/pipeline/timepiece steps),
   timepiece `scripts/health.sh` (doc index + imports + gitbook drift with
   recorded baselines), test `check_site.py` (also CI). unfer / dynamic-arctic
   / australVM / velysterm keep their native cargo gates as their health
   surface — *justified*: duplicating `cargo test` wrappers adds nothing.

### 1.3 What `../typos` and `../ax` offer — adapted vs. deliberately not adapted

**Adapted (implemented, attribution in each artifact):**

| Source pattern | Where it landed |
|---|---|
| typos `index.rs`: full rebuild + per-file incremental update + dedup by (source,target) + versioned JSON with `generated_at` | `doc_index.py` (cwd + timepiece), `check_site.py` graph |
| typos `graph.rs`/`query.rs`: backlink graph, `backlinks()` / `search()` queries | DOC_INDEX backlink tables, `check_site.py --backlinks`, **new in rev. 2:** `doc_index.py --backlinks/--search` (T5) |
| typos `watch.rs`: extension filter, 200 ms settle/drain, compile-once-per-settle, initial run before watch | `scripts/watch_check.py` (stdlib polling, same semantics, no new deps) |
| typos changelog practice (README "Recent changes" + Keep-a-Changelog) | `CHANGELOG.md` in cwd + timepiece |
| ax `/healthz`: one plain probe, one exit code | `timepiece/scripts/health.sh`, `taskctl.py health`, `check_site.py` |
| ax manifests: `apiVersion/kind/metadata/spec` YAML applied by a small CLI | `tasks/*.yaml` + `scripts/taskctl.py` (**new docs in rev. 2:** A5) |
| ax docs split (README/development/manifests) + SHA-pinned actions | `AGENTS.md`, `README.md`, test workflow pin |

**Not adapted — with justification (recorded so nobody re-proposes them):**

- *ax* control plane (CRDs, Redis, streams, Gateway/egress, Workspace/Model
  kinds, `ax ssh`): infrastructure these repos don't have. `taskctl.py` is
  deliberately a ~200-line wrapper; the manifest subset is enough.
- *ax* Makefile: `taskctl list|run|health` already is the single entry layer;
  a Makefile would be a second entry layer over the same commands.
- *typos* Typst AST / `vault.typ` typed metadata: our corpora are Markdown;
  regex extraction at index time is sufficient and dependency-free.
- *typos* CSV registry + `sync.rs` reconciliation: our "registry" *is* the
  filesystem; `--check` (stored index vs. fresh rebuild) detects drift with
  fewer moving parts than maintaining a path registry.
- *typos* graph visualization / Tauri app: no web UI exists in these repos;
  rendered tables + `--backlinks` queries cover the need.

### 1.4 New findings from the rev. 2 deep pass

- `test/` tracked **1070 `node_modules` files** — was flagged in rev. 2;
  **untracked 2026-09-24b on the owner's explicit call** (`git rm -r
  --cached node_modules`): files remain on disk for local GitBook builds,
  now git-ignored; `test/AGENTS.md` rule 4 updated to match.
- `timepiece` tracks a **compiled bytecode file**
  (`scripts/__pycache__/import_components.cpython-312.pyc`) — flagged, not
  removed (pre-existing; `__pycache__/` now ignored so no *new* ones land).
- cwd root clutter: 8 one-off `build_*.sh`/`start_*.sh`, several `.bak`
  files, `Definitions.backup_20260918_154238/` — **not deleted**: the backup
  dir contains Lean sources (specialist/owner decides) and the shell helpers
  are referenced by PIPELINE_PLAN sessions.
- cwd `state/` is ignored wholesale, which would have hidden the versioned
  doc-index JSON → H7 keeps logs ignored but tracks the two index JSONs, so
  `doc_index.py --check` works on a fresh clone (typos versioned-index
  discipline). timepiece's `state/doc_index.json` is committed for the same
  reason (its health gate must not fail right after clone).
- timepiece has a local uncommitted edit to `prompts` (the operator's prompt
  log) — **left untouched and not committed** (not our change to make).

---

## 2. The plan (ordered, with acceptance criteria and status)

Priority rule from the brief: **adapt/improve existing features inspired by
typos/ax first; new-from-scratch only with justification.** Items marked
[TYPOS] and [AX] carry attribution comments in the artifact itself.

Legend: ✅ done & accepted · 🔄 in progress · ⛔ flagged, deliberately not executed.

### Phase P0 — plan (this document)
- ✅ **P0** `PROJECT_REVIEW_AND_PLAN.md` — rev. 2 (this file), execution log
  in §4.

### Phase P1 — cross-repo hygiene (existing gaps)
- ✅ **H1 [australVM]** Root `rust-toolchain.toml` pinning `1.97.1`.
  *Accept:* file exists with `channel = "1.97.1"`; rustup walk-up verified
  against both workspace dirs; no build run.
- ✅ **H2 [cwd]** `AGENTS.md` — ax `docs/development.md` shape (prereqs,
  layout map, health entry points, rules). *Accept:* covers layout + gates +
  health; ≤ ~120 lines (60 l).
- ✅ **H3 [cwd]** `README.md` expanded (ax README shape). *Accept:* ≥ ~40 l,
  no secrets (49 l; credentials section names only the gitignored file).
- ✅ **H4 [dynamic-arctic]** Compact `AGENTS.md` derived from README + CI.
  *Accept:* ≤ ~60 l, accurate vs. `ci.yml` (40 l; commands match `ci.yml`).
- ✅ **H6 [test]** *(rev. 2)* `AGENTS.md` — layout, SUMMARY discipline, checker
  + CI commands, license/pin notes; plus `.gitignore` for Python bytecode.
  *Accept:* ≤ ~60 l, commands run as written; no tracked-file changes.
- ✅ **H7 [cwd, timepiece, test]** *(rev. 2)* versioned-index tracking +
  bytecode hygiene: cwd `state/` ignore converted to `state/*` + negations
  for the two doc-index JSONs; timepiece `state/doc_index.json` committed and
  `__pycache__/` ignored; test `.gitignore` (with H6).
  *Accept:* fresh-clone `--check` paths documented; `git status` shows no
  `__pycache__` noise after a compile check.
- ⛔ **H5** LICENSE decisions for `prove2me_workspace` and `test` — owner only.

### Phase P2 — typos-inspired adaptations to EXISTING features
- ✅ **T1 [timepiece]** `scripts/doc_index.py` + `DOC_INDEX.md` (typos
  `index.rs` semantics: rebuild, `--file` incremental, (source,target) dedup,
  versioned `state/doc_index.json`, `--check` freshness).
  *Accept:* runs in-repo; twice → byte-identical; no Lean files edited.
- ✅ **T2 [cwd]** `references/INDEX.md` via the same generator
  (`--scan references`). *Accept:* every `references/*.md` appears; links
  resolve (17 docs, 52 links).
- ✅ **T3 [cwd, timepiece]** `CHANGELOG.md` seeded from `git log`.
  *Accept:* newest entries match git log head (`a22cd81` / `8901a58`).
- ✅ **T4 [cwd]** `scripts/watch_check.py` (typos `watch.rs` debounce).
  *Accept:* `--help` works; a burst of 6 rapid changes fires **once** after
  the settle window (measured: initial run + 1 settle fire under `--max-fires 2`).
- ✅ **T5 [cwd, timepiece]** *(rev. 2)* query surface on the index —
  `doc_index.py --backlinks PATH` and `--search TEXT`, adapted from typos
  `query.rs` (`backlinks()` = incoming edges; `search()` = title → id/path →
  headings → content, case-insensitive). *Justification:* the index already
  exists but had no way to *ask* it anything except by reading DOC_INDEX.md.
  *Accept:* `--backlinks README.md` lists incoming/outgoing; `--search health`
  ranks content matches; `--check` still passes afterwards (render unchanged).

### Phase P3 — ax-inspired adaptations to EXISTING features
- ✅ **A1 [timepiece]** `scripts/health.sh` — one command over the *existing*
  checks (doc index freshness, import gate, gitbook drift) with recorded
  baselines; exit 0 iff healthy; never runs `lake build`.
  *Accept:* runs from repo root; this tree → `1 pass, 2 warn, 0 fail`, exit 0;
  `bash -n` clean.
- ✅ **A2 [test]** `scripts/check_site.py` + `.github/workflows/site-check.yml`
  (SUMMARY drift, broken links, backlink report; SHA-pinned checkout).
  *Accept:* exits 0 on the current tree (`50 pages, 178 internal links`);
  workflow YAML parses; `branches: [master]` matches the repo's default branch.
- ✅ **A3 [cwd]** `tasks/*.yaml` + `scripts/taskctl.py` — ax-style manifest
  subset (`apiVersion/kind/metadata/spec.steps[]` with `run/cwd/health`),
  `list` / `run --dry-run` / `health`, logs under `state/tasks/`.
  *Justification (new-from-scratch):* the existing "feature" was a 4790-line
  prose runbook plus ~25 undiscoverable scripts — no runnable entry point to
  improve. Manifests only *wrap* existing commands.
  *Accept:* `list` shows 3 tasks; `run --all --dry-run` prints exact commands;
  real `health` runs all health steps end-to-end, exit 0.
- ✅ **A4 [cwd]** pipeline `--status/--check/--sync` documented as the
  pipeline's health endpoint (README/AGENTS). *Accept:* `--status` runs
  (4059 plan items, exit 0); no behavior change.
- ✅ **A5 [cwd]** *(rev. 2)* `tasks/README.md` — the manifest schema documented
  the way ax documents its kinds (`docs/manifests.md`): fields, `health`
  semantics, exit-code contract, worked example. *Justification:* manifests
  without schema docs rot; ax's docs-set is the pattern to copy, not invent.
  *Accept:* every field `taskctl.py` actually reads is documented; example
  YAML parses.

### Phase P4 — verification (no compilation anywhere)
- ✅ `python3 -m py_compile` on every new/modified `.py` (7 files: doc_index ×2,
  taskctl, watch_check, check_site — plus import gate untouched).
- ✅ `doc_index.py` run twice in cwd **and** timepiece → byte-identical
  (idempotent); `--check` exits 0 in both.
- ✅ `taskctl.py list` / `run --all --dry-run` / real `health` → exit 0.
- ✅ `watch_check.py --help`; debounce burst test fires once per settle.
- ✅ `bash -n timepiece/scripts/health.sh`; real run → exit 0 (baselines warn).
- ✅ `check_site.py` → exit 0; workflow YAML parses (`yaml.safe_load`).
- ✅ Gate `python3 scripts/import_components.py BookProof --check` still
  runs inside health.sh (warn-at-baseline, exit 0).
- ✅ Task manifests parse (PyYAML 6.0.1); `bash -n` on new shell scripts (none
  beyond health.sh, pre-existing).
- ✅ `taskctl health` after rev.-2 edits → all steps pass, exit 0.

### Phase P5 — commit & sync
- ⏳ Per-repo commits (Codebuff trailer) for: `prove2me_workspace` (all cwd
  artifacts), `timepiece` (doc index + health + changelog + index JSON +
  gitignore), `test` (checker + CI + AGENTS + gitignore), `dynamic-arctic`
  (AGENTS), `australVM` (rust-toolchain). No commit: `unfer`, `velysterm`
  (untouched).
- ⏳ Push only established sync targets: `prove2me_workspace`, `timepiece`,
  `test`. `australVM` / `dynamic-arctic` stay local-only (per constraint).

---

## 3. Attribution register

| Artifact | Adapted pattern | Source (license) |
|---|---|---|
| `prove2me_workspace/scripts/doc_index.py`, `timepiece/scripts/doc_index.py` | index rebuild, incremental update, link dedup, versioned JSON; `--backlinks/--search` queries | `typos` notes-core `index.rs`, `query.rs` (Apache-2.0) |
| `prove2me_workspace/DOC_INDEX.md`, `timepiece/DOC_INDEX.md`, `references/INDEX.md` | rendered TOC + backlink tables | `typos` index/graph render ideas (Apache-2.0) |
| `prove2me_workspace/scripts/watch_check.py` | debounce window, extension filter, re-run on settle, initial run before watch | `typos` notes-core `watch.rs` (Apache-2.0) |
| `prove2me_workspace/CHANGELOG.md`, `timepiece/CHANGELOG.md` | changelog discipline | `typos` README "Recent changes" practice / velysterm |
| `timepiece/scripts/health.sh` | single health endpoint over existing checks, exit-0 contract | `ax` `/healthz` (Apache-2.0) |
| `test/scripts/check_site.py` + `.github/workflows/site-check.yml` | health check as CI, SHA-pinned action, drift/status reporting + backlink graph | `ax` health/CI (Apache-2.0) + `typos` index/graph |
| `prove2me_workspace/tasks/*.yaml`, `scripts/taskctl.py` | declarative Task manifests, list/run/health CLI | `ax` manifests + `ax apply` CLI (Apache-2.0) |
| `prove2me_workspace/tasks/README.md` | manifest schema reference docs | `ax` `docs/manifests.md` (Apache-2.0) |
| `prove2me_workspace/AGENTS.md`, `README.md`, `test/AGENTS.md`, `dynamic-arctic/AGENTS.md` | development docs structure (prereqs / commands / layout) | `ax` `docs/development.md`, `README.md` (Apache-2.0) |

---

## 4. Execution log

Each entry: item → files touched → acceptance result.

- **P0** — plan written; rev. 2 replaces it same day after the deep pass. ✓
- **H1** — `australVM/rust-toolchain.toml` (new, 10 l) → `channel = "1.97.1"`;
  both workspace dirs verified one level deep (rustup resolves). ✓
- **H2** — `AGENTS.md` (new, 60 l) → layout/gates/rules covered. ✓
- **H3** — `README.md` (1 → 49 l) → what/why, quickstart, docs links, no
  secrets. ✓
- **H4** — `dynamic-arctic/AGENTS.md` (new, 40 l) → commands match `ci.yml`. ✓
- **H6** — `test/AGENTS.md` (new) + `test/.gitignore` (new) → checker/CI
  commands run as written; bytecode ignored. ✓
- **H7** — cwd `.gitignore` (`state/` → `state/*` + `!state/doc_index.json`,
  `!state/references_index.json`); timepiece `state/doc_index.json` added,
  timepiece `.gitignore` += `__pycache__/` → `--check` works on fresh clones,
  no bytecode noise. ✓
- **T1** — `timepiece/scripts/doc_index.py`, `DOC_INDEX.md`,
  `state/doc_index.json` → 61 docs indexed; two runs byte-identical;
  `--check` exit 0. ✓
- **T2** — `references/INDEX.md` → 17 docs, 52 links, all targets resolve. ✓
- **T3** — `CHANGELOG.md` (cwd, timepiece) → newest entries match `git log`. ✓
- **T4** — `scripts/watch_check.py` → `--help` OK; burst test: 6 rapid edits →
  exactly 1 settle-fire (plus the documented initial run). ✓
- **T5** — `scripts/doc_index.py` + timepiece copy: `--backlinks PATH`,
  `--search TEXT` query modes → README backlinks print incoming+outgoing;
  content search matches; `--check` still fresh (render untouched). ✓
- **A1** — `timepiece/scripts/health.sh` → real run: `1 pass, 2 warn, 0 fail`,
  exit 0; `bash -n` clean; baselines (6/86/11) hold against HEAD 8901a58. ✓
- **A2** — `test/scripts/check_site.py`, `test/.github/workflows/site-check.yml`
  → exit 0 (`50 pages, 178 links, 149 unique pairs`); YAML parses; branch
  `master` correct; checkout SHA identical to dynamic-arctic's verified pin. ✓
- **A3** — `tasks/{docs,pipeline,timepiece}.yaml`, `scripts/taskctl.py` →
  `list` (3 tasks), `run --all --dry-run` (exact commands), real `health`
  runs all 4 health steps end-to-end, exit 0. ✓
- **A4** — README + AGENTS document `--status/--check/--sync`; `--status`
  runs exit 0 (4059 items / 3334 done). ✓
- **A5** — `tasks/README.md` → schema fields ↔ `taskctl.py` reader match;
  example YAML parses. ✓
- **P4** — full verification battery (listed in §2 Phase P4) — all green. ✓
- **P5** — commits per repo; pushes limited to established sync targets. ✓
- **P6a (owner request, 2026-09-24b)** — doc-index freshness wired into
  `timepiece/.github/workflows/ci.yml` as a third `docs` job (plain probe,
  Python stdlib, SHA-pinned checkout, same shape as test's site-check). ✓
- **P6b (owner request, 2026-09-24b)** — `test` `node_modules` untracked from
  the index (1070 deletions recorded), kept on disk, added to `.gitignore`,
  AGENTS rule updated. ✓
