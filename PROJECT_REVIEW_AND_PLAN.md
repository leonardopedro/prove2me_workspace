# Cross-project review & improvement plan — 2026-09-26 (rev. 3, whole-project deep pass)

Scope: the six sibling repos of this workspace — `../unfer/`, `../australVM/`,
`../velysterm/`, `../timepiece`, `../dynamic-arctic`, `../test/` — plus this repo
(`prove2me_workspace`, the cross-repo driver). Studied for inspiration:
`../typos/` and `../ax/`, both **Apache-2.0**. Copyright policy (see §3): we
adapt *patterns*, never copy source files or license headers; every adapted
artifact carries an attribution comment naming the source project, file, and
license, and §3 is the register. No Lean 4 proof code is written here — that
stays with the LLM-Lean4-specialist (per `timepiece/CONSOLIDATED_PLAN.md`
§2026-09-24a); `lakefile.toml` / `COMPONENT_NAMES` truth also stays with that
specialist unless explicitly delegated.

**Rev. 3 (2026-09-26):** the whole tree was re-surveyed file-by-file (the repos
moved since rev. 2 — timepiece landed the *Aristotle wave* and a Book
deepening, `test/` landed the 2026-09-25 BookProof wave and the NS-Lagrangian
record, `unfer` landed the NS-Lagrangian suite), every gate in §1.2 was
**run**, not read, and the typos/ax sources were re-mined for patterns that
improve **existing** features (§1.4 → phases P8–P9). New in rev. 3:

- **Phase P7 (repairs)** — the survey found the health contract red *right
  now*: both doc-index gates fail and the timepiece CI `docs` job is red on
  HEAD. Repairs precede features because they are regressions of existing
  features, not new work.
- **Phases P8/P9 (typos/ax adaptations)** — nine items, all improvements of
  existing features (taskctl, doc index, import gate, health), each with the
  source pattern named.
- **Phase P10 (in-family)** — the `verify-invariants` pattern from
  `unfer`/`velysterm` (their PLAN_HARNESS H1 gate), justified below.
- **Rev. 2's completed work** is preserved as the record in §2 "Phases P0–P6
  (done)" and §4; the attribution register (§3) is cumulative.

**Execution constraints (hard):**
- No `lake build` / no Lean compilation, and **no Lean 4 source edits** (the
  specialist's lane). Allowed gate: `python3 scripts/import_components.py
  BookProof --check`. Markdown/YAML/Python/shell/toolchain files are in scope.
- No `cargo build`/`go build`/`dune build` of siblings (toolchain files and
  docs only).
- Commit per repo with the Codebuff trailer; push only the established sync
  targets: `timepiece`, `test`, `prove2me_workspace` (all three currently in
  sync with their origins — verify `git status -sb` before pushing).
  `australVM`, `dynamic-arctic`, `velysterm`, `unfer` get local commits only
  when a change is made (none planned in rev. 3).

---

## 1. Whole-project review — findings (rev. 3, re-verified 2026-09-26)

### 1.1 Per-repo state (as found today)

| Repo | What it is | CI | AGENTS.md | LICENSE | State as found today (rev. 3) |
|---|---|---|---|---|---|
| `timepiece` | Lean 4 proof tree (Book/ 48 modules, BookProof/ 879 files, CONSOLIDATED_PLAN 16.1k l) | `ci.yml` (incl. P6a `docs` job) | ✓ | Apache-2.0 | Aristotle wave (`65d3963`, +20 proof chapters) + Book deepening (`a68130e`) landed **without an index rebuild** → `doc_index.py --check` exits 1, **CI `docs` job red on HEAD**; index now covers 62 docs (0 cross-links, still); tree otherwise clean |
| `prove2me_workspace` (cwd) | Skill + upload pipeline (SKILL.md v0.10.9, PIPELINE_PLAN 4.8k l, ~25 scripts, 3 task manifests) | `lean_action_ci.yml` | ✓ | missing (owner decision) | `taskctl health` exit 1 (docs.index-check stale — caused by an **uncommitted edit to `DISK_CLEANUP_PLAN.md`**); PIPELINE_PLAN version banner stale (§1.3 F3); in sync with origin |
| `unfer` | Rust probability kernel + Cadabra modules + PLAN_HARNESS gates | `ci.yml` (`verify-invariants` H1, coverage H11) | ✓ | Apache-2.0 | healthy; NS-Lagrangian suite green (`5e1a572`); clean tree; `scripts/verify-invariants` is the family's best health pattern (→ P10-S1) |
| `australVM` | OCaml Austral compiler + Rust cranelift bridge | `build-and-test.yml`, `build-macos.yml` | ✓ | ✓ | H1 pin committed (`4fa732e4`); nothing new needed |
| `velysterm` | Rust editor/agent workspace | `rust.yml` + `scripts/verify-invariants` | ✓ | MIT/Apache-2.0 | still the in-family docs model (CHANGELOG 835 l, PROGRESS, docs/); untouched |
| `dynamic-arctic` | Rust Arctic threshold-signature crate | `ci.yml` (SHA-pinned) | ✓ (H4 committed `e242ef4`) | MIT (Ian Goldberg) | healthy; nothing new needed |
| `test` | GitBook-style docs site (SUMMARY.md) | `site-check.yml` | ✓ | missing (owner decision) | **grew to 59 pages / 279 internal links** (2026-09-25 wave: `ca9ac2a`, `c3996f6`); `check_site.py` exits 0 (SUMMARY consistent, 0 broken links) but reports **1 orphan + 16 dead-end pages**, and the new NS-Lagrangian/ESA prose is what blows the citation-drift baseline in timepiece's gate (§1.3 F2) |

### 1.2 Gate status measured today (commands run, exit codes read)

| Gate | Command | Result today |
|---|---|---|
| timepiece doc index | `python3 scripts/doc_index.py --check` | **exit 1** — `[stale]` both renders (was green at rev. 2) |
| timepiece health | `bash scripts/health.sh` | **exit 1** — `1 pass, 0 warn, 0 gap, 2 fail` (doc index; gitbook drift **82** lean misses vs baseline 11) |
| timepiece import gate | `python3 scripts/import_components.py BookProof --check` | pass at baseline (6 unnamed comps, 86 stale roots — unchanged) |
| timepiece CI | `.github/workflows/ci.yml` `docs` job runs the stale check | **red on HEAD** |
| cwd doc index | `python3 scripts/doc_index.py --check` | **exit 1** — stale (DISK_CLEANUP_PLAN.md edit) |
| cwd references index | `doc_index.py --check --scan references …` | `[fresh]` (17 docs, 52 links) |
| cwd task health | `python3 scripts/taskctl.py health` | **exit 1** — `docs.index-check` + `timepiece.health` fail; `docs.site-check` + `pipeline.status` pass |
| test site | `python3 scripts/check_site.py` | exit 0 — `59 pages, 279 internal links, 213 unique pairs`, 1 orphan, 16 dead-end |
| pipeline | `upload_pipeline.py --status` | exit 0 — plan 4059 items; state `3334 done / 574 pending / 151 failed (1822 orphans ignored)` |

### 1.3 New findings from the rev. 3 deep pass

- **F1 — doc-index staleness ×2 (regression, blocks CI).** The Aristotle wave
  and Book deepening changed timepiece's docs without rebuilding
  `DOC_INDEX.md`/`state/doc_index.json`; the cwd index is stale only because
  of the uncommitted `DISK_CLEANUP_PLAN.md` ledger edit. → **P7-R1/R2.**
- **F2 — GitBook citation drift blew its baseline (82 vs 11).** The 2026-09-25
  NS-Lagrangian/ESA pages in `test/` cite Lean identifiers that do not (yet)
  exist under those names — e.g. `det_deformation_corr`, `det_deformation_corr3`,
  `commForm_eq_leray_advect`, `add_right_imp`, `classical_series_converges_at_s0`,
  `conditional_convergence_is_null`, `BookProof.ChapterEuler`,
  `ChapterQgFockComparisonEsa.lean`. Either the prose cites planned/renamed
  decls or the Aristotle wave renamed them. **Gate red is correct** — these
  citations really are wrong today. Truth about decl names is the
  specialist's; citation fixes are docs edits. → **P7-R4** (triage list first,
  then owner/specialist decision per class).
- **F3 — version-banner drift in `PIPELINE_PLAN.md`.** Line 12 still says
  "Current skill/platform versions: 0.10.8 / 0.10.8 (updated 2026-09-22)"
  while `SKILL.md` is **0.10.9** (`d49883a`, 2026-09-23). §-notes at lines
  3965/4704/4787 are historical session records and stay as history; the
  banner and the "current" note must track `SKILL.md`. → **P7-R3**, and
  P10-S1 makes the equality a machine check so it cannot rot again.
- **F4 — `test/` orphan + dead-end pages.** 1 page with no incoming links, 16
  with no outgoing. Consistent with rev. 2's stance: we do **not** force
  links (content decision for the maintainers); `check_site.py` already
  reports them each run. → **flagged (P7-R5)**, not executed.
- **F5 — pipeline runbook banner vs live state.** PIPELINE_PLAN "Live state,
  2026-09-22" banner (`3336 done / 2087 pending`) no longer matches `--status`
  (`3334 done / 574 pending / 151 failed, 1822 orphans ignored`); the runbook
  itself says the live backlog *is* `--status`, so this is documentation
  staleness only. → **P7-R6** (docs-only banner refresh, or a pointer).
- **F6 — workspace hygiene backlog unchanged.** Root `build_*.sh`/`start_*.sh`
  helpers, `scripts/*.bak`, `Definitions.backup_20260918_154238/`, and the
  `DISK_CLEANUP_PLAN.md` ledger's uncommitted edit all remain owner-call
  items (rev. 2 §1.4). The ledger edit itself looks like the owner's own
  "PARTIALLY EXECUTED" update — **committing it is the owner's call**, and it
  is the trigger for R2. One stale vim swap file (`timepiece/.prompts.swp`,
  untracked editor noise) was removed during the survey.
- **F7 — timepiece still has zero cross-links** (62 docs, 0 links). Rev. 2's
  finding holds after the new wave; the index will pick links up whenever the
  maintainers add them. T8 below makes renames safe so that future linking
  does not immediately orphan.

### 1.4 What `../typos` and `../ax` offer at rev. 3 — new adaptations vs. still-not-adapted

Already adapted in rev. 2 (kept, see §3): index rebuild/incremental/dedup/
versioned JSON (`index.rs`), backlinks + search (`query.rs`), watch debounce
(`watch.rs`), changelog discipline, `/healthz` single-probe contract, manifest
subset + `apply`-style CLI, docs split + SHA-pinned actions.

**New in rev. 3 — every one improves an EXISTING feature (the brief's
priority rule); new-from-scratch items are marked and justified:**

| Source pattern | Adapted as | Improves |
|---|---|---|
| typos `compiler.rs`: subprocess compile with a hard timeout (`wait_timeout::ChildExt`, 10 s) | P8-T6 `taskctl` per-step `timeout` + process-group kill; `watch_check.py --timeout` | taskctl / watch_check |
| typos `graph.rs`: `graph_data()` → serializable `{nodes, edges}` | P8-T7 `doc_index.py --graph` JSON export (deterministic order) | doc index |
| typos `note.rs`: `rename_note()` — rename **and rewrite all references** (incl. children) | P8-T8 `doc_index.py --rename OLD NEW` (dry-run → `--apply`), Markdown references only | doc index (read-only today) |
| typos `sync.rs` + `csv_registry.rs`: registry↔filesystem reconciliation reporting `(added, removed)` then reindex | P8-T9 reconciliation **report** on the existing import gate (report-only; `lakefile.toml`/`COMPONENT_NAMES` edits stay with the specialist) | import_components gate |
| ax `describe` + `status.conditions` (TYPE/STATUS/REASON/MESSAGE, `Ready`/`WorkspaceReady`) | P9-A6 per-run status JSON in `state/tasks/` + `taskctl describe` + last-run column in `list` | taskctl |
| ax `watch`: stream condition **transitions** as they happen | P9-A7 `taskctl watch` — interval re-run of health steps printing only transitions (+ `--max-iter` for bounded use) | taskctl health |
| ax `/healthz` (liveness) vs `/readyz` (readiness) split | P9-A8 `taskctl health` (warn-at-baseline = live) vs `taskctl health --strict` / `health.sh --strict` (warn promotes to fail = ready to commit/push) | health contract |
| ax server-side manifest validation + `applyOutcome` (created/updated/unchanged) | P9-A9 `taskctl validate` — schema check over `tasks/*.yaml` ("documented, not validated yet" → validated), wired as a health step | task manifests |
| (in-family) `unfer`/`velysterm` `scripts/verify-invariants` — AGENTS.md checklist as machine checks, `[pass]/[FAIL]/[gap]` discipline | P10-S1 `scripts/verify_invariants.py` over THIS workspace's own rules (credentials never tracked, no build commands in manifests, attribution comments present, version equality, tracked index JSONs) | taskctl health / AGENTS.md rules |

**Not adapted — with justification (kept from rev. 2; nobody should
re-propose them):**

- *ax* control plane (CRDs, Redis/streams, Gateway/egress, Workspace/Model
  kinds, `ax ssh`, task-runner contract, tunnel): infrastructure these repos
  don't have. `taskctl.py` stays a small wrapper.
- *ax* Makefile: `taskctl list|run|health` is already the single entry layer;
  a Makefile would be a second layer over the same commands.
- *ax* `examples/` dir + CONTRIBUTING/CLA: `tasks/README.md` already carries a
  worked example and the schema; AGENTS.md covers contribution rules for
  agents. Revisit only if external contributors appear.
- *typos* Typst AST / `vault.typ` typed metadata / note-type registry: our
  corpora are Markdown; regex extraction at index time is sufficient and
  dependency-free.
- *typos* CSV registry as the source of truth (as opposed to the reconciliation
  *report* in T9): our "registry" *is* the filesystem; `--check` detects drift
  with fewer moving parts.
- *typos* graph visualization / Tauri app / LSP integration: no web UI or
  editor exists in these repos; JSON export (T7) + rendered tables cover the
  need.

---

## 2. The plan (ordered, with acceptance criteria and status)

Priority rule from the brief: **adapt/improve existing features inspired by
typos/ax first; new-from-scratch only with justification.** Items marked
[TYPOS]/[AX] carry attribution comments in the artifact itself (§3).
Legend: ✅ done & accepted · 🔄 in progress · ⏳ planned (rev. 3) · ⛔ flagged,
deliberately not executed (owner/specialist call).

### Phases P0–P6 (done in rev. 2 — record kept, details in §4)

- ✅ **P0** plan rev. 2; **P1-H1..H7** hygiene (australVM toolchain pin, cwd
  AGENTS/README, dynamic-arctic AGENTS, test AGENTS+gitignore, versioned
  index tracking + bytecode hygiene); **P2-T1..T5** typos adaptations
  (doc_index ×2, references INDEX, CHANGELOGs, watch_check, `--backlinks`/
  `--search`); **P3-A1..A5** ax adaptations (timepiece health.sh, test
  check_site+CI, cwd taskctl+manifests+schema docs, pipeline health docs);
  **P4** verification battery; **P5** per-repo commits + pushes to sync
  targets (verified: all four repos in sync with origin today); **P6a**
  doc-index freshness wired into timepiece CI; **P6b** test `node_modules`
  untracked (owner call). ⛔ **H5** LICENSE decisions remain owner-only.

### Phase P7 — repair the red gates (regressions found today)

- ⏳ **R1 [timepiece]** Rebuild the doc index and commit it together with the
  regenerated `state/doc_index.json` (62 docs, 0 links; render only — no Lean
  file is touched). *Accept:* `python3 scripts/doc_index.py --check` exits 0;
  the CI `docs` job green on the next push; two rebuilds byte-identical.
- ⏳ **R2 [cwd]** Once the owner's `DISK_CLEANUP_PLAN.md` ledger edit is
  committed (owner call — F6), rebuild both indexes (`DOC_INDEX.md` +
  `state/doc_index.json`, `references/INDEX.md` + `state/references_index.json`)
  and commit. This plan file itself re-stales the index, so R2 runs **after**
  this document lands. *Accept:* `taskctl health`'s `docs.index-check` step
  green; `--check` exit 0 for both scans.
- ⏳ **R3 [cwd]** Fix the stale version banner in `PIPELINE_PLAN.md` (line 12
  and the "current" note at line ~4787: 0.10.8 → **0.10.9**, date 2026-09-23);
  historical session sections (lines ~3965/4704) stay as history. *Accept:*
  banner == `SKILL.md` `metadata.version`; no other PIPELINE_PLAN edits.
- ⏳ **R4 [test ↔ timepiece]** Citation-drift triage (F2). (a) Produce the
  grouped miss list from `scripts/check-gitbook-drift` (identifier class →
  page → candidate real decl) — output appended to this plan's §4 or a short
  `test/` note; (b) **owner/specialist decision** per class: fix the prose
  citation (docs edit, in scope) vs. the decl lands later (then the baseline
  stays 11 and the gate stays red — correct); a temporary baseline raise is
  only acceptable with a documented expiry note in `health.sh`. *Accept:*
  triage list complete; either drift ≤ 11 again or an explicit, dated owner
  decision recorded. ⛔ the actual citation fixes are **not** executed here
  without that decision (they assert mathematical naming truth).
- ⛔ **R5 [test]** Orphan/dead-end pages (F4) — content review by the
  maintainers; `check_site.py` keeps reporting them. Not executed.
- ⏳ **R6 [cwd]** Refresh or replace the PIPELINE_PLAN "Live state" banner
  (F5): either re-run `--status` into the banner or replace the numbers with
  "live backlog = `python3 pipeline/upload_pipeline.py --status`" so it can
  never rot again (preferred). *Accept:* banner no longer contradicts
  `--status`.

### Phase P8 — [TYPOS] improvements to existing features

- ⏳ **T6** Step timeouts in `scripts/taskctl.py` (from typos `compiler.rs`
  `COMPILE_TIMEOUT` + `wait_timeout`): new `spec.steps[].timeout` field
  (seconds; default 300; `0` = unlimited), enforced by running the step in
  its own session and killing the **process group** on expiry; the step
  reports `[timeout]` in its log and fails. Same default added to
  `watch_check.py` re-checks (`--timeout`). *Justification (improvement, not
  new):* `health` must always answer (the `/healthz` contract A1 adopted);
  today a wedged step (e.g. the imports gate on a huge diff) hangs
  `taskctl health` forever. *Accept:* a manifest with `run: sleep 1000` and
  `timeout: 2` fails in ~2 s with no surviving `sleep`; the real health
  battery behaves exactly as before; `tasks/README.md` documents the field.
- ⏳ **T7** Graph export in `scripts/doc_index.py` (from typos `graph.rs`
  `graph_data()`): `--graph OUT.json` emits
  `{version, generated_at, nodes:[{id,label,kind}], edges:[{source,target}]}`
  with deterministic ordering, from the already-deduped link set; the same
  shape from `test/scripts/check_site.py --graph` for the site graph.
  *Justification:* the graph already exists as rendered tables; downstream
  tooling (and the future T8 dry-run) needs a machine-readable form — a
  ~30-line addition to an existing feature. *Accept:* output parses
  (`json.load`), nodes == indexed docs, edges == unique pairs (213 for test/);
  `--check` still passes (render untouched); two runs byte-identical.
- ⏳ **T8** Reference-safe rename in `scripts/doc_index.py` (from typos
  `note.rs::rename_note`, "rename and update all references"):
  `--rename OLD NEW [--apply]` — after a doc has been `git mv`'d, report every
  remaining Markdown reference to OLD (link targets incl. `#anchors`,
  case-sensitive, exact-path) as `file:line` hits (dry-run default); `--apply`
  rewrites them and rebuilds the index. Refuses if NEW already exists in the
  index; exits 0 with "no inbound references" when nothing points at OLD.
  Markdown only — never touches Lean files. *Justification:* docs are renamed
  between waves and today that silently orphans backlinks (test/ already has
  1 orphan); the link graph makes the rewrites precise instead of
  regex-guessing. *Accept:* dry-run lists exactly the (file,line) hits
  `--backlinks` would predict; `--apply` on a scratch copy rewrites only those
  hits; `--check` passes afterwards; works in both cwd and timepiece copies.
- ⏳ **T9** Reconciliation report on the existing import gate (from typos
  `sync.rs` `(added, removed)` + reindex semantics): a report-only mode on
  `timepiece/scripts/import_components.py` (e.g. `--reconcile`) printing the
  drift as three buckets — `missing_name` (module on disk without a
  COMPONENT_NAMES entry), `stale_root` (lakefile root with no module),
  `orphan_module` (module not referenced by any root) — with counts and a
  `--json` form, surfaced as one line in `health.sh`'s import-gate summary.
  *Justification:* health.sh currently *baselines away* 6+86 known drifts;
  a reconciliation view is what lets the split-wave owners burn those
  baselines down incrementally (the typos sync story: report diff → fix →
  rebuild). **Report only** — editing `lakefile.toml`/`COMPONENT_NAMES` is
  the specialist's. *Accept:* counts match the current gate's (6, 86, +0);
  exit 0 always (report); `health.sh` unchanged verdicts; JSON parses.

### Phase P9 — [AX] improvements to existing features

- ⏳ **A6** Run status + conditions in `scripts/taskctl.py` (from ax
  `describe` + `status.conditions`): after every `run`/`health`, write
  `state/tasks/<task>.json` — `{task, phase: pass|fail, finished_at, steps:
  [{name, status, reason, duration_s, log}]}` (regenerable state, not
  committed — consistent with H7); add `taskctl describe NAME` printing the
  manifest summary plus a TYPE/STATUS/REASON condition table of the last run,
  and a last-run column in `taskctl list`. *Justification:* today runs leave
  only per-step logs; the conditions model is ax's answer to "what happened
  last time" without log archaeology. *Accept:* run → describe agrees with
  the observed exit codes; JSON parses; `list` shows last-run; existing
  subcommands' behavior unchanged.
- ⏳ **A7** `taskctl watch [--interval 60] [--max-iter N] [--strict]` (from ax
  `watch` condition-transition streaming): re-runs the health steps on an
  interval and prints **only transitions** (`docs.index-check pass→fail`,
  …), plus one heartbeat line per iteration; bounded runs exit 0 at
  `--max-iter` (the chunked-runbook discipline). *Justification:* the
  PIPELINE_PLAN workflow leaves an operator polling gates between upload
  chunks; a transition feed is the missing watch surface over A6's status
  JSON — it reuses health steps + A6, nothing new underneath. *Accept:* on a
  stable tree every iteration prints "no change"; a deliberately flipped step
  prints exactly one transition block; `--max-iter 2 --interval 1` returns
  deterministically in ~2 s.
- ⏳ **A8** Liveness/readiness split (from ax `/healthz` vs `/readyz`):
  `taskctl health --strict` and `bash scripts/health.sh --strict` promote
  `warn` (baseline notices) to `fail`; the plain commands keep today's
  semantics exactly. Document in `tasks/README.md` + AGENTS.md as the "ready
  to commit/push" gate; CI may adopt `--strict` once the baselines are
  cleared (post-R4). *Accept:* plain `health` output byte-identical to today;
  `--strict` fails on this tree while baselines exist (asserted, then
  documented); `bash -n` clean.
- ⏳ **A9** `taskctl validate` (from ax server-side manifest validation +
  `applyOutcome`): schema-check every `tasks/*.yaml` against the documented
  fields (`apiVersion`, `kind: Task`, unique `metadata.name`,
  `spec.steps[].run`, known keys only — unknown keys warn), reporting
  `ok/skip/error` per file and a summary line; wired as a new `docs` task
  step `manifests-validate` (`health: true`). *Justification:* `tasks/README`
  currently says "documented, not validated yet" — validation is the
  improvement of the existing manifest feature that ax pairs with apply.
  *Accept:* current 3 manifests pass; a deliberately broken copy fails with a
  precise message naming file + field; `health` stays green.

### Phase P10 — in-family patterns & cross-cutting (priority 2, justified)

- ⏳ **S1 [cwd]** `scripts/verify_invariants.py` (from `unfer`/
  `velysterm` `scripts/verify-invariants`, their PLAN_HARNESS H1 — in-family,
  same organization, no third-party license involved; still note the origin
  in the header): turn THIS repo's own AGENTS.md/plan promises into
  machine checks with `[pass]/[FAIL]/[gap]` output — (1) `credentials.json`
  gitignored **and** untracked; (2) no `lake build`/`cargo build` in
  `tasks/*.yaml`; (3) attribution comment present in every artifact listed in
  §3; (4) `state/` ignore negations intact (the two index JSONs tracked);
  (5) version equality: `SKILL.md` `metadata.version` == newest CHANGELOG
  release == PIPELINE_PLAN banner (the F3 class, made un-regressable);
  (6) doc-index freshness for both scans. One new `workspace` task manifest
  step, `health: true`. *Justification (in-family over typos/ax):* the
  pattern is the family's established health idiom and it *improves* the
  existing health surface rather than inventing a parallel one; typos/ax have
  nothing comparable to adapt. *Accept:* green on the tree after P7; each
  check demonstrably fails when its rule is deliberately broken (spot-test
  3 of the 6); `py_compile` clean.
- ⛔ **S2** LICENSE decisions for `prove2me_workspace` and `test` — owner
  only (carried over, unchanged). Until then, adapted Apache-2.0 *patterns*
  are fine (§3), but do not copy any source file text verbatim.

### Phase P11 — verification & sync (no compilation anywhere)

- ⏳ `python3 -m py_compile` on every new/modified `.py`.
- ⏳ `doc_index.py` twice in cwd and timepiece → byte-identical; `--check`
  exit 0 in both after R1/R2; `--graph` outputs parse and are stable.
- ⏳ `taskctl` battery: `list`, `describe`, `validate`, `run --all --dry-run`,
  real `health`, `health --strict` (expected fail while baselines exist),
  `watch --max-iter 2`; T6 timeout test with a `sleep` step.
- ⏳ `bash -n timepiece/scripts/health.sh` (incl. `--strict`); real run →
  exit 0 with warnings at baseline after R4's outcome.
- ⏳ `check_site.py` (+ `--graph`) exit 0; workflow YAMLs still parse.
- ⏳ Gate `python3 scripts/import_components.py BookProof --check` still the
  only Lean-side command used, inside `health.sh` (warn-at-baseline).
- ⏳ Commit per repo (Codebuff trailer): `prove2me_workspace` (this plan,
  taskctl/doc_index/watch_check updates, verify_invariants, task manifests,
  README/AGENTS touch-ups, CHANGELOG), `timepiece` (index rebuild R1,
  health.sh `--strict` + T9 surface), `test` (check_site `--graph`, any R4a
  triage note). Push only `prove2me_workspace`, `timepiece`, `test`, after
  `git status -sb` confirms the sync targets.

---

## 3. Attribution & copyright register (cumulative)

**Policy:** `../typos` and `../ax` are Apache-2.0. We adapt *patterns and
semantics* (file roles, CLI shapes, contracts), never copy source files,
identifiers wholesale, or the "Copyright 2026 Google LLC" headers from `ax`.
Every adapted artifact opens with a comment naming the source project, the
source file/doc, and the license (e.g. `# Pattern adapted from ../typos
notes-core/src/watch.rs (Apache-2.0)`). This register is the central record;
P10-S1 check 3 verifies the per-artifact comments stay in place.

| Artifact | Adapted pattern | Source (license) |
|---|---|---|
| `prove2me_workspace/scripts/doc_index.py`, `timepiece/scripts/doc_index.py` | index rebuild, incremental update, link dedup, versioned JSON; `--backlinks/--search`; **(rev. 3)** `--graph` export, `--rename` reference rewrite | `typos` notes-core `index.rs`, `query.rs`, `graph.rs`, `note.rs` (Apache-2.0) |
| `prove2me_workspace/DOC_INDEX.md`, `timepiece/DOC_INDEX.md`, `references/INDEX.md` | rendered TOC + backlink tables | `typos` index/graph render ideas (Apache-2.0) |
| `prove2me_workspace/scripts/watch_check.py` | debounce window, extension filter, re-run on settle, initial run before watch; **(rev. 3)** check timeout | `typos` notes-core `watch.rs`, `compiler.rs` (Apache-2.0) |
| `prove2me_workspace/CHANGELOG.md`, `timepiece/CHANGELOG.md` | changelog discipline | `typos` README "Recent changes" practice / velysterm (Apache-2.0) |
| `timepiece/scripts/health.sh` | single health endpoint over existing checks, exit-0 contract; **(rev. 3)** `--strict` readiness mode | `ax` `/healthz` + `/readyz` split (Apache-2.0) |
| `timepiece/scripts/import_components.py --reconcile` **(rev. 3)** | registry↔filesystem reconciliation report `(added, removed)` | `typos` `sync.rs` (Apache-2.0) |
| `test/scripts/check_site.py` + `.github/workflows/site-check.yml` | health check as CI, SHA-pinned action, drift/status reporting + backlink graph; **(rev. 3)** `--graph` export | `ax` health/CI (Apache-2.0) + `typos` index/graph |
| `prove2me_workspace/tasks/*.yaml`, `scripts/taskctl.py`, `tasks/README.md` | declarative Task manifests, list/run/health CLI, schema docs; **(rev. 3)** per-step timeout, run conditions + describe, watch transitions, validate | `ax` manifests, `ax apply`/`describe`/`watch` CLI, `docs/manifests.md`, runner timeout posture (Apache-2.0) |
| `prove2me_workspace/AGENTS.md`, `README.md`, `test/AGENTS.md`, `dynamic-arctic/AGENTS.md` | development docs structure (prereqs / commands / layout) | `ax` `docs/development.md`, `README.md` (Apache-2.0) |
| `prove2me_workspace/scripts/verify_invariants.py` **(rev. 3)** | AGENTS.md checklist → machine-checkable invariants, `[pass]/[FAIL]/[gap]` discipline | in-family: `unfer`/`velysterm` `scripts/verify-invariants` (PLAN_HARNESS H1) |

---

## 4. Execution log

Each entry: item → files touched → acceptance result.

**Rev. 2 (2026-09-24) — completed and accepted (record kept):** P0 plan
rev. 2 · H1 `australVM/rust-toolchain.toml` (1.97.1) · H2 cwd `AGENTS.md` ·
H3 cwd `README.md` · H4 `dynamic-arctic/AGENTS.md` · H6 `test/AGENTS.md` +
`.gitignore` · H7 versioned-index tracking (cwd `state/*` + negations,
timepiece `state/doc_index.json`, `__pycache__/` ignored) · T1 timepiece
`doc_index.py`+`DOC_INDEX.md` · T2 `references/INDEX.md` · T3 CHANGELOGs ·
T4 `watch_check.py` · T5 `--backlinks/--search` · A1 timepiece `health.sh`
(then `1 pass, 2 warn, 0 fail`) · A2 `check_site.py` + `site-check.yml`
(then `50 pages, 178 links`) · A3 `tasks/*.yaml` + `taskctl.py` · A4
pipeline health docs (`--status` 4059 items) · A5 `tasks/README.md` · P4
verification battery all green · P5 per-repo commits + pushes (all four
targets in sync — re-verified today) · P6a doc-index freshness in timepiece
CI · P6b test `node_modules` untracked (owner call).

**Rev. 3 (2026-09-26) — survey actions:**
- Ran every gate in §1.2; results recorded there (two red gates found: F1,
  F2-class drift found: 82 vs 11).
- Rebuilt timepiece's index in a scratch check to count the corpus (62 docs,
  0 links) and **restored the tree afterwards** (`git checkout -- DOC_INDEX.md
  state/doc_index.json`) so the repair stays an explicit, reviewable commit
  (R1).
- Removed one stale untracked editor artifact (`timepiece/.prompts.swp`).
- No repo-modifying action taken: R1–R4, R6, T6–T9, A6–A9, S1 are **planned
  (⏳)** and will be logged here on execution.

**Open owner/specialist decisions carried into rev. 3:** H5/S2 licenses ·
F6 `DISK_CLEANUP_PLAN.md` ledger commit + root-clutter tiers · R4 citation
truth (specialist names vs. prose) · R5 test/ link content.
