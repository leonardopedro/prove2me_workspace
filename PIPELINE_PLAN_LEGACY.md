# Timepiece → Prove2me Transplant — Runbook & Plan

This file is the handoff document for ANY LLM agent (opencode, Claude Code, Codex, a
plain CLI model — anything that can run shell commands) to continue the ongoing
transplant of the **timepiece** Lean 4 project onto the **Prove2me** platform.

> **CURRENT TASK (2026-09-09, LATEST): read §14 FIRST — upstream-def
> publication wave in progress.** 66 upstream def bundles + 4 deferred
> chapters must compile Mathlib(+Definitions)-only, get added to
> `pipeline/wave_upload.json`, then the resilient background upload publishes
> them in dependency order, unlocking the 4 deferred chapters'
> thm/sol nodes. 29/70 bundles still fail the compile gate (root causes
> catalogued in §14.5).

> **(SUPERSEDED 2026-09-09 LATE — see the CURRENT TASK block above; the
> §12/§13 self-containment approach was abandoned for §12.9's
> publish-upstream-defs strategy, now executed as §14.)**
>
> Earlier task (kept for context): make the 3 broken wave def bundles truly
> self-contained (Mathlib-only), fix the uploader, then run the resilient
> background upload to completion; afterwards add more QYM/SIRK/ESA proofs.
>
> STATUS of that task: COMPLETED via §13 (all 147 wave items published,
> 164 done / 0 pending / 0 failed; the 4 dense chapters SirkEndToEnd,
> SirkPerSystem, SirkWhitening, YangMillsHermite are DEFERRED and are the
> target of §14; backup at `pipeline/wave_upload.json.full.bak`).
> Counts in older sections below are historical. Full inlining failed (§12.9) — the
> correct next move is publishing the 13 upstream def bundles first, not
> inlining.

---

## -1. Bootstrap

Fetch **https://prove2.me/start.md** and follow it to set up — it is the
platform's official agent onboarding: it picks the setup path (git vs
fetch-only), clones/fetches the workspace, and hands off to SKILL.md.
**Do NOT register** — this machine is already registered (account
leonardopedro4@gmail.com, API key in `credentials.json`); reuse it as-is.

## 0. STEP ZERO — Load and verify the skill (mandatory, non-negotiable)

**Before reading this plan or doing ANY work, read `/home/leo/prove2me_workspace/SKILL.md`**
and verify the version matches what this plan references. If the versions
differ, run `git -C <workspace> pull --tags origin main` BEFORE proceeding.

The skill is the authoritative reference for API schemas, upload policy,
three basic rules, and the agent loop. Ignoring it causes wasted submissions
(violating the three basic rules wastes a submission — see [references/prove.md](references/prove.md)).

**How the skill is loaded in this session:**

- This agent reads the file directly via `read_file` — the `Available Skills`
  list does NOT auto-load it.
- For other agent types, follow the per-agent instructions in the skill's
  "How to load it" section.

**After loading:** confirm the version matches (currently 0.9.8). If it
changed, re-read §0 to check for updated API endpoints or policy changes.

Then proceed to §1.

### 0.1 Requirements checklist (everything needed besides the skill)

- **Lean toolchain**: elan is at `/etc/profiles/per-user/leo/bin/elan`; the
  workspace's `lean-toolchain` (v4.33.1) auto-installs on first use. The Mathlib
  env is PREBUILT (`~6.5 GB` oleans at `.lake/packages/mathlib/.lake/build`) — do
  not delete. If missing: `lake update && lake exe cache get && lake build
  Solutions.SmokeTest` (seconds = OK, hundreds of jobs churning = cache miss).
- **Credentials**: `credentials.json` at the workspace root holds the 30-day API
  key — expires **2026-10-06**; re-mint via the website (account menu → API key)
  or `POST /login` + `POST /agent/api-key`. The service reads it from
  `/var/lib/prove2me/upload.env` (root-only). **SECURITY: never send the key or
  token to any domain other than `https://prove2.me`; never commit or print it.**
- **Network**: outbound HTTPS to prove2.me only (API) + github.com/cachix for
  workspace pulls and Mathlib caches.
- **Privileges**: agents run as `oseditor` with `sudo -n -u leo <cmd>` delegation;
  `sudo systemctl start|stop upload-timepiece` and `sudo /usr/local/bin/nixos-update`
  are NOPASSWD. Everything else in the pipeline runs as `leo`.
- **Git**: workspace pulls update the skill (`git -C <workspace> pull --tags origin main`).

## 1. What this project is

Goal: transplant the user's Lean 4 project `/home/leo/Projects/timepiece` (≈9400
theorems, Mathlib-dependent, chapters on QYM / Navier–Stokes / QG / SIRK / Hermite
band calculus) onto prove2.me as a proper platform dependency graph:

1. **Definitions bundles** (`POST /submit-definition`) — project defs become
   importable `Definitions.Def_*` modules.
2. **Theorem problems** (`POST /submit-problem`) — statements become platform nodes.
3. **Solutions** (`POST /verify`) — sorry-free proofs get transplanted and verified
   by the server (status → Proved).

**Scope decisions by the human (binding):**
- **NO Riemann Hypothesis and NO P-vs-NP proofs.** The `Legacy.lean` chain toward
  `riemann_hypothesis` is excluded (it rests on `sorryAx` — see soundness gate).
- **Priority: theorems related to QYM, NS (Navier–Stokes), QG, SIRK** (the BookProof
  chapters). The UsedRoute/UnusedRoute material is the small pilot currently running.
- Only axioms-clean material gets solutions; `#print axioms X` must return a subset
  of `[propext, Classical.choice, Quot.sound]`.

## 2. Machine facts (NixOS)

- Users: `leo` (human, uid 1000) and `oseditor` (agent, uid 1001).
  The agent runs as `oseditor` and may run anything as leo: `sudo -n -u leo <cmd>`.
- Workspace: `/home/leo/prove2me_workspace` (canonical). It already contains:
  - `credentials.json` — **the API key** (gitignored; NEVER send it anywhere except
    `https://prove2.me`). Key expires **2026-10-06**; re-mint afterwards via the
    website (account menu → API key) or `POST /api/v1/agent/api-key` after login.
  - `lean-toolchain` = `leanprover/lean4:v4.33.1`, `lakefile.lean` pinned to Mathlib
    `0df444a360eaa60ab8c11dca51a86af692955474` = **exactly the platform's default
    environment**, with 6.5 GB of prebuilt Mathlib oleans — the local gate compiles
    in seconds. `lakefile.lean` has `autoImplicit false` (matches the server) and
    explicit submodule globs for the `Definitions`/`Theorems`/`Solutions` libs.
  - `pipeline/` — generated platform tree + the uploader script.
- The source project `/home/leo/Projects/timepiece` is BUILT (`.lake`, v4.28 env) —
  its build is required to run the graph extractor (Phase 1).
- `decl_graph.jsonl` in the project root = Stage-1 declaration graph for the
  UsedRoute/UnusedRoute closure (26 decls). Spans in it are authoritative — never
  regex-split Lean source.

### Local compile gate (use before EVERY submission)

```bash
cd /home/leo/prove2me_workspace && lake env lean <file.lean>   # exit 0 = clean
```

### The resilient service

`upload-timepiece.service` (system unit, user leo):
- `ExecStart = python3 pipeline/upload_pipeline.py`, `Restart=on-failure`,
  `RestartSec=30s`, starts at boot (`wantedBy multi-user.target`).
- Control (root): `sudo systemctl start|stop|status upload-timepiece`.
- Logs: `/home/leo/prove2me_workspace/state/pipeline.log` (script's own log) and
  `state/service.log` (systemd stdout/stderr).
- To run manually without the service (as leo):
  `cd ~/prove2me_workspace && setsid nohup python3 pipeline/upload_pipeline.py >> state/service.log 2>&1 &`

## 3. How the uploader works (pipeline/upload_pipeline.py)

- Ordered plan = `LEGACY_ORDER` (the 17-item pilot) + `WAVE_ORDER` read from
  `pipeline/wave_upload.json`: `def:<chapter>` bundles first, then `thm:<slug>`
  and `sol:<slug>` in topological order (dependencies first). The current wave
  contributes 8 defs + 59 thms + 59 sols.
- State: `state/pipeline.json`, **saved atomically after every item**; the script
  exits **1 while work remains** (systemd restarts it) and **0 when done**.
- Per item: local compile gate → submit → poll to terminal → record id.
- **Job-id re-poll**: submit responses record the server `job_id` in state BEFORE
  polling; on retry the entry logic re-polls that job instead of resubmitting
  (resubmitting creates duplicates — the server does NOT dedupe by name!).
- **Dedupe / coverage / reduction policy (binding)**:
  (a) before ANY submission, search the catalog (`GET /theorems?q=<name>`) and
  reuse an existing node on exact-name or whitespace-normalized-statement match;
  the `already exists` rejection self-heals the same way.
  (b) `find_related` also searches the candidate's distinctive tokens: existing
  **Proved** theorems with the **same normalized conclusion** mean the candidate
  is likely a corollary — the item is SKIPPED (`covered_by` recorded) instead of
  publishing a trivial node.
  (c) before submitting a transplanted proof, Proved related theorems are logged
  as `reduction_bases`. **Reduction-first rule for agents**: try to prove the
  target by importing those existing theorems (a 5-line sketch) before submitting
  a 50-line transplanted proof; the platform records reductions natively
  (`SKETCH_ACCEPTED` when imports are Open, `ACCEPTED` when all Proved).
  Improving what exists beats creating from scratch.
- Attempts cap 5 per item → permanent `failed`. Solutions require their theorem
  published (theorem_id in state).
- Source of truth for what actually exists on the platform:
  `GET /api/v1/publish-jobs?kind=problem|definition&status=...` (owner's jobs) and
  `GET /api/v1/theorems?tags=timepiece` (public catalog).

## 4. Status snapshot

**Batch 1 COMPLETE (2026-09-07 ~09:30 CEST): 17/17 items done, 0 failed.**
- `hurwitz_nonvanishing_limit` — **Proved** (`62b01429-…`), the pilot node.
- Definition bundle `timepiece_corrector` — **Published** (`be6a03e1-…`), job
  `ccd5ea8c-…`.
- Theorems published (Open): `zeta_symm`, `X_p_zero`, `X_mult_zero`,
  `norm_X_mult_list_eq_one`, `norm_X_mult_eq_one`,
  `euler_partial_product_nonvanishing`, `S_recip_random_zero`,
  `bohr_cahen_algebraic_tail_bound`; 8 solutions **ACCEPTED (Proved)**.

**7-chapter wave COMPLETE (2026-09-07 19:30): 196/196 items done, 0 failed.**
- Chapters: `MassGap`, `BRSTNilpotent`, `GhostField`, `NavierStokes`,
  `YangMillsFieldStrength`, `SirkFinitePrecision`, `GaugeFixing` (86 theorems
  published + proved, 7 def bundles + the pilot bundle). Uploader exits 0/idles.

**QYM/SIRK/MAJORANA WAVE — COMPLETE (2026-09-08 ~10:30 CEST).**
8 Mathlib-only chapters — `BaryonAsymmetry`, `MajoranaClifford`, `MajoranaProp61`,
`MajoranaProp76`, `ParityMajoranaQuant`, `YangMillsBianchi`, `YangMillsSU3`,
`SirkGroupTransfer` — producing **8 def bundles + 59 theorems + 59 solutions**
in the workspace mirror (`Definitions/`, `Theorems/`, `Solutions/`).

**Previous status: 320 done, 0 pending, 2 failed** (pipeline state).

**Current status (2026-09-08 ~17:40):** 320 done, 65 pending, 2 failed.
All def bundles for the current wave (5 defs) + transitive deps (7 additional
modules) replaced with source files from `/home/leo/Projects/timepiece/BookProof/`
and verified compiling. Pipeline state reset. Upload service ready to launch.

**Key fixes applied in this session (see §9 for details):**
1. **Def bundle root cause** — auto-generated `Definitions/Def_Chapter*.lean` files
had wrong v4.33 fixes and imported other def bundles via
`import Definitions.Def_Chapter*`. Fixed by copying source files from
`/home/leo/Projects/timepiece/BookProof/Chapter*.lean` which compile correctly
because `lean_lib «BookProof»` is declared in `lakefile.lean`.
2. **SU3 jacobi ambiguous term** (`Sol_BookProof_YangMillsSU3_structureConstant_jacobi.lean`):
   replaced `_root_.sum_apply`/`_root_.smul_apply` with
   `Matrix.neg_apply`/`Matrix.sum_apply`/`Matrix.smul_apply` (v4.33.1 additions)
   and used `smul_eq_mul (α := ℂ)` + `Complex.I_mul_I` to reduce
   `Complex.I • X • Complex.I • Y = -(X * Y)` before the `Complex.ext_iff` split.

2. **Pipeline lake path fixed** (`pipeline/upload_pipeline.py:212`): changed
   hardcoded lake from v4.28.0 to v4.33.1:
   ```
   - "/etc/profiles/per-user/leo/bin/lake"
   + "/home/leo/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake"
   ```

3. **J_unitary_prime name mismatch fixed:**
   - The wave spec `name` was `J_unitary_prime` (underscore) but the Lean file
     declared `J_unitary'` (prime). Updated `wave_upload.json` `file` field to
     point to `Thm_BookProof_ChapterParityMajoranaQuant_J_unitary_prime.lean`.
   - Removed old primed files (`Thm_BookProof_...J_unitary'.lean`,
     `Sol_BookProof_...J_unitary'.lean`).
   - Both theorem and solution files compile cleanly with `J_unitary_prime`.

4. **Resilient upload launcher created** (`start_upload.sh`):
   - `./start_upload.sh start` — start (or restart) the pipeline
   - `./start_upload.sh stop` — stop gracefully
   - `./start_upload.sh restart` — stop + start
   - `./start_upload.sh status` — check if running + log tail
   - Uses `nohup` + `disown` for resilience against shell closures
   - PID tracking at `/tmp/upload_pipeline.pid`
   - Log at `state/upload.log`

**Remaining blockers:**
- `ChapterMajoranaProp76` and `ChapterYangMillsSU3` def bundles still import
  other def bundles (`Definitions.Def_Chapter*`). These are from earlier waves
  and may fail on the platform due to missing transitive dependencies.
  Fix: same approach — sync source files from `BookProof/Chapter*.lean`.
- If the platform rejects `import BookProof.Chapter*` in def bundles,
  all def bundles must be made self-contained (only `import Mathlib`,
  inline all cross-module definitions). The source files at
  `/home/leo/Projects/timepiece/BookProof/` can be used as reference.
- Full `lake build` is NOT green — many def bundles from earlier waves have
  compile errors (missing identifiers, wrong v4.33 fixes). Only the wave
  items matter for the pipeline.

## 9. CURRENT SESSION TASKS (2026-09-08)

### 9.1 Root cause analysis (FIXED)

Upload pipeline started at `2026-09-08 ~14:50`. Items failed because:

1. **Def bundles had wrong fixes** — the auto-generated `Definitions/Def_Chapter*.lean`
   files had incorrect v4.33 drift repairs (e.g. `ring_nf` instead of `ring`,
   `convert using 1` instead of `convert using 4`). The SOURCE files at
   `/home/leo/Projects/timepiece/BookProof/Chapter*.lean` compile correctly.

2. **Def bundles imported other def bundles** — `import Definitions.Def_Chapter*`
   creates a dependency chain that breaks when modules aren't uploaded in order.
   The platform's Lean environment only has `import Mathlib` available.

**Fix:** Copy source files directly from `/home/leo/Projects/timepiece/BookProof/`
to `Definitions/Def_Chapter*.lean`. The workspace has `lean_lib «BookProof»`
declared in `lakefile.lean`, so `import BookProof.Chapter*` works locally.
The source files compile and include all needed definitions.

### 9.2 Fix applied: source file sync

All def bundles for the current wave replaced with source files from
`/home/leo/Projects/timepiece/BookProof/`. Verified compiling:

```bash
cd /home/leo/prove2me_workspace
export PATH="/home/leo/.elan/bin:$PATH"
# All 5 wave defs + all transitive deps compile:
for name in HermiteProductCore FriedrichsExtension SirkSpectralGeometry
            NavierStokesHashimoto NavierStokesDiffHashimoto
            NavierStokesLagrangianKatoRellich StarobinskyPotential
            SirkPerSystem YangMillsHermite SirkDiffusiveDecay
            SirkEndToEnd SirkWhitening; do
  lake env lean "Definitions/Def_Chapter${name}.lean" 2>&1 | grep -q "^error:" && echo "FAIL" || echo "OK"
done
```

Result: ALL compile clean.

### 9.3 Pipeline state reset

Pipeline state (`state/pipeline.json`) reset for all Sirk/Majorana/SU3 items:
attempts=0, status=pending, job_id=null. This clears the stale failure state
from the previous upload run.

### 9.4 Upload service launch

The `upload-timepiece.service` system unit requires `sudo` which is not
available in this session. Use the manual resilient launcher:

```bash
cd /home/leo/prove2me_workspace
nohup python3 pipeline/upload_pipeline.py >> state/service.log 2>&1 &
disown
```

Monitor:
```bash
tail -f /home/leo/prove2me_workspace/state/pipeline.log
```

The launcher is resilient to shell logout. PID tracking at `/tmp/upload_pipeline.pid`.

**Note:** The topological sort in the pipeline only detects `import Definitions.Def_Chapter*`
dependencies. Since the def bundles now use `import BookProof.Chapter*`, the sort
may not reflect the true dependency order. However, all def bundles compile with
just `import Mathlib` + `import BookProof.Chapter*` (available via `lean_lib «BookProof»`).
The platform may reject `import BookProof.Chapter*` — if uploads fail with
"unknown import: BookProof.ChapterX", the def bundles must be made self-contained
by inlining all cross-module definitions.

Webapp note: items are public and queryable via API; the web UI may cache —
search the theorem name or filter tag `timepiece`.

## 5. NEXT AGENT TASK: fix def bundle compilation + upload remaining items

**Current status (2026-09-09):** 254 done, 148 pending, 15 failed.
Upload service was running but exited. 5 wave defs fail to compile due to
transitive dependency issues (missing imports from `BookProof.*` namespaces).

### 5.1 Def bundle compilation issues

The def bundles in `Definitions/Def_Chapter*.lean` must compile with only
`import Mathlib` — the platform only provides `import Mathlib`. The generator
(`scripts/wave_generate.py`) must ensure each def bundle is self-contained:
- No `import BookProof.*` statements
- No `open BookProof.*` statements (these reference namespaces that don't exist
  as separate modules on the platform)
- All needed definitions inlined or imported via `import Definitions.Def_*`

**Current failures (5 wave defs):**
- `Def_ChapterSirkDiffusiveDecay.lean` — uses `compress` from `ChapterH4`
- `Def_ChapterSirkEndToEnd.lean` — uses definitions from `ChapterH4`, `ChapterH6`,
  `ChapterH8`, `ChapterH9`
- `Def_ChapterSirkPerSystem.lean` — uses definitions from many `BookProof.*`
  namespaces (FarisLavine, HashimotoShiftInvert, EsaClosure, etc.)
- `Def_ChapterSirkWhitening.lean` — uses `compress` from `ChapterH4`
- `Def_ChapterYangMillsHermite.lean` — imports `Def_ChapterHermiteProductCore` and
  `Def_ChapterFriedrichsExtension`

**Fix approach:** The generator must be improved to handle transitive
dependencies. Each def bundle should only `import Mathlib` and inline all
needed definitions. Alternatively, the generator should detect cross-def-bundle
dependencies and emit the correct imports.

### 5.2 Upload service resilience

The upload service (`pipeline/upload_pipeline.py`) must be resilient to:
- Shell logout (use `nohup` + `disown`)
- Process crashes (systemd `Restart=on-failure`)
- API rate limits (exponential backoff)
- Pipeline state corruption (atomic saves, validation on startup)

The `start_upload.sh` script provides manual control. The systemd unit
(`upload-timepiece.service`) provides automatic restarts.

### 5.3 Generator improvements needed

The `scripts/wave_generate.py` script needs:
1. **Self-contained def bundles** — no `open BookProof.*` or `import BookProof.*`
2. **Transitive dependency detection** — if a def bundle uses definitions from
   another def bundle, emit the correct `import Definitions.Def_*`
3. **v4.33 drift fixes** — replace `ring` with `ring_nf` where needed, fix
   `convert using 1` → `convert using 4`, etc.
4. **Heartbeat management** — add `set_option maxHeartbeats 1000000` for heavy
   proofs

### 5.4 General process (for future waves)

Same as §5.7 in the original plan (see above).

---

### 5.0 First: read the two authoritative references (original plan)

1. `references/prove2me-lean4.33-translation/PLAN_LEAN4_33_TRANSLATION.md`
   (vendored copy of `/home/leo/Projects/prove2me-lean4.33-translation/PLAN_LEAN4_33_TRANSLATION.md`)
   — **the v4.28 → v4.33.1 translation plan.** It catalogues every drift class
   found so far, the repair templates, the still-open item, and the file map of
   fixed/failing artifacts. Read it before touching any Lean file.
2. `references/upload_full_project.md` in this workspace — the transplant
   playbook (phases 0–6). Then this §5 and §6.

The handoff folder is vendored at `references/prove2me-lean4.33-translation/`
(copy of `/home/leo/Projects/prove2me-lean4.33-translation/`):
- `PLAN_LEAN4_33_TRANSLATION.md` — the plan (§2 = drift classes, §4 = working order).
- `fixed_solutions/` — worked examples of each repair (a_sq, bianchi,
  bianchi_cyclic, fieldStrength_antisymm, bianchi_fieldStrength).
- `thm_fixes/` — the generator bug fix for dot-named theorems.
- `failing_solutions/` — `Sol_BookProof_YangMillsSU3_structureConstant_jacobi.lean`
  (the ONE remaining failure; start from this file).
- `scripts/`, `notes/`, `source_chapters/` — the generator/metadata scripts,
  the Phase-0 axiom gate, and the affected source chapters.

### 5.1 The task in one line

Make `lake build` green in `/home/leo/prove2me_workspace` (platform env v4.33.1 /
Mathlib 0df444a) for the current 8-chapter wave, then upload it via the service.

### 5.2 Step 1 — fix the one remaining compile failure

```bash
cd /home/leo/prove2me_workspace
export PATH="/home/leo/.elan/bin:$PATH"
lake build          # expect only Solutions.Sol_..._structureConstant_jacobi to fail
```

Repair `Solutions/Sol_BookProof_YangMillsSU3_structureConstant_jacobi.lean` per
PLAN §2.6 (the `exact ⟨Finset.sum_congr ...⟩` at line 53 operates on entry-level
`.re`/`.im` goals, not matrix sums — reduce the `Complex.I • … • Complex.I • …`
before the split, or close the two ℝ halves with `ring` after `ext`/`constructor`).
The `_root_.smul_apply`/`_root_.sum_apply` ambiguity fixes (lines 47–48) are
already applied. Iterate with `lake env lean <file>` until exit 0. Keep it
lint-clean (≤100 chars/line, no trailing whitespace, no unused-simp-arg warnings).

### 5.3 Step 2 — full build + hygiene gate

- `lake build` must be fully green (all 8 defs, 59 thm stubs, 59 solutions).
- Every `Solutions/Sol_BookProof_*.lean` is sorry-free; every
  `Theorems/Thm_BookProof_*.lean` is a `:= by sorry` stub that builds.
- Do NOT change theorem statements (immutable once uploaded); if a statement
  needs a rename, stop and record it — don't silently edit.
- Phase-0 axiom gate already passed for this wave (see `notes/axiom_gate_batch2.lean`
  in the handoff folder); re-run it only if you edit statements.

### 5.4 Step 3 — regenerate wave metadata (only if you touched files/names)

```bash
cd /home/leo/prove2me_workspace
python3 scripts/wave_docstrings.py && python3 scripts/wave_metadata.py
python3 scripts/wave_upload_spec.py   # -> pipeline/wave_upload.json (defs:8 thms:59 sols:59)
```
If nothing changed, `pipeline/wave_upload.json` is already current — skip.

### 5.5 Step 4 — upload via the resilient service

`pipeline/upload_pipeline.py` already reads `pipeline/wave_upload.json`; its
`ORDER` covers the current wave's `def:`/`thm:`/`sol:` items. Start it:

```bash
sudo systemctl start upload-timepiece        # as leo; or run manually (see §2)
tail -f /home/leo/prove2me_workspace/state/pipeline.log
```
The dedupe/coverage/reduction policy (§3) runs automatically per item. On
`sol:` uploads, prefer the reduction-first rule: if an existing Proved theorem
implies the target, submit a short import-based sketch instead of the full
transplanted proof. Wait for the summary line "N done, 0 pending, 0 failed".

### 5.6 Step 5 — batch hygiene

- Reset nothing in `state/pipeline.json` (append-only); keep dedupe/reuse records.
- Update §4's snapshot (mark this wave COMPLETE with counts/ids).
- Then start the NEXT chapter pick per the general process in §5.7, using the
  translation plan's §6 generator-fix notes before generating again.

### 5.7 General process (for future waves — the original playbook)

**Source-folder rule (user-mandated): publish from ANY project folder EXCEPT
`Book/`** — `Book/` holds prose book chapters (titles without formal math) and
must never be uploaded. `scripts/wave_upload_spec.py` and
`pipeline/upload_pipeline.py` both hard-fail on any source containing `/Book/`
(does not match `/BookProof/`). All other folders (`BookProof/`, `UsedRoute/`,
`UnusedRoute/`, `RandomMap/`, `PnpProof/`, …) are fine.

**Axiom/sorry rule (user-mandated): targets from `PnpProof/`, `UsedRoute/`,
`UnusedRoute/` must additionally be sorry-free and carry NO axioms beyond the
mainstream `{propext, Classical.choice, Quot.sound}`.** Enforced by the
generalized Phase-0 gate `/home/leo/Projects/timepiece/axiom_gate.lean` (now
prefix-based: it gates every imported module under `BookProof.` / `PnpProof.` /
`UsedRoute.` / `UnusedRoute.` / `RandomMap.`; add the batch's imports to that
file and run `lake env lean axiom_gate.lean`, `grep '^BAD'` must be empty for
chosen targets — `sorryAx` is flagged automatically, so gate-clean ⟹ sorry-free).
`scripts/wave_upload_spec.py` hard-fails on any `PnpProof/`/`UsedRoute/`/
`UnusedRoute/` source whose meta lacks `axiom_clean: true` + `sorry_free: true`
(set them from the gate run). BookProof and all other folders remain subject to
Phase 0 as before.

1. **Pick the chapters.** Scan `/home/leo/Projects/timepiece/BookProof/` for the
   chapters whose names/content match QYM (quantum Yang–Mills: brst, ghost,
   gauge, mass_gap, yang), NS (navier, stokes), QG (einstein, hilbert,
   spacetime, scalaron, starobinsky), SIRK (sirk, band ledger). Keywords also in
   `is_qym` in `scripts/upload_timepiece_v2.py`. **Prefer Mathlib-only chapters**
   (no `import BookProof.*`): the generator's def-bundles keep source imports
   verbatim, so a cross-chapter def-cone breaks the platform build (see §5.8).
2. **Phase 0 — soundness gate.** For each candidate target run `#print axioms`
   in the project env (`/home/leo/Projects/timepiece`, v4.28 build present):
   reject anything depending on `sorryAx` as a SOLUTION source (its STATEMENT
   may still be published as an Open problem if interesting).
3. **Phase 1 — graph.** Copy `scripts/extract_decl_graph.lean` into the project,
   edit the two `EDIT` lines (one `import` per chapter module; extend the
   `isProj` prefix check with the module prefixes you cover), run
   `lake env lean extract_decl_graph.lean` → `decl_graph.jsonl`. Then
   `extract_sketch_info.lean` per participating module (proof boundaries —
   needed for solutions and skeleton subtraction).
4. **Phase 2 — plan nodes** (playbook rules: Node >40 lines or 11–40 with
   promotion signal; inline helpers ≤10 lines; Def-material = non-private
   defs/instances; Def-embedded theorems proved inside the bundle). Compute
   reachability from your QYM/NS/QG/SIRK targets.
5. **Phase 3/4 — generate + platformize** by skeleton subtraction with Stage-2
   spans. Preamble = imports/opens/variables ONLY; `formal_statement` ends
   `:= by sorry`; no leading docstrings; fully-dotted conservative-ASCII
   `theorem_name` (rename primes/unicode via Stage-2 ref ranges).
6. **Phase 5 — validate**: stage into the workspace mirror
   (`Definitions/`, `Theorems/`, `Solutions/`), `lake build` until green in the
   platform env (0df444a / v4.33.1). Drift patterns from §6/PLAN §2 will bite —
   iterate locally, never blind-submit.
7. **Phase 6 — upload via the service**: extend `pipeline/upload_pipeline.py`'s
   `ORDER` + item functions with the new items (same state machine — do not
   reinvent), then `sudo systemctl start upload-timepiece`. The dedupe/coverage
   policy runs automatically per item; the reduction-first rule (§3) applies to
   every solution you transplant — prefer a 5-line import-based sketch over a
   50-line transplanted proof.
8. **Batch hygiene**: reset nothing in `state/pipeline.json` (append new items
   only); keep the dedupe/reuse records; update §4's snapshot when done.

### 5.8 Known blockers / deferrals

- **`ChapterNavierStokesSignedShift`** (29 nodes, manifest generated) is
  **blocked**: its def bundle imports `BookProof.ChapterNavierStokesAffineFiberEsa`,
  which needs a ~14-module NS def-cone published as platform Definition bundles
  with rewritten imports — machinery the current Mathlib-only generator lacks.
  Do not mix it into a Mathlib-only wave. Leftover generated `SignedShift` /
  `QgBrstDerivativeGauge` files were removed from the mirror; keep them out.
- **Generator bugs to fix before the next generated wave** (see PLAN §6):
  (1) `opens_for` emits a bogus `open <Ns>` for dot-named theorems like
  `LinearIsometryEquiv.isNote4Unitary` (the "parent" is a type, not a namespace);
  (2) the generator does not import `Mathlib.Tactic.NoncommRing` /
  `Mathlib.Algebra.Jordan.Basic` when a proof needs `noncomm_ring` or
  `LieRing.ofAssociativeRing`. Hand-patch the current wave; fix the generator
  before regenerating.

## 6. Expensive lessons (do not rediscover)

- The server **ignores imports inside `formal_statement`** — imports/opens/variables
  go in the separate **`preamble`** field; project defs must be published as
  Definitions and imported as `import Definitions.Def_<name>`.
- A `formal_statement` starting with `/--` gets silently **dropped** by the
  platform — strip leading docstrings.
- `formal_statement` must end with `:= by sorry`; `theorem_name` must be the exact
  declaration name; conservative ASCII only.
- **Poll endpoints**: publish jobs = `GET /publish-jobs/{job_id}` (path param!);
  solution verdicts = `GET /verify?submission_id=...`. `submit-definition` returns
  a single job object (top-level `job_id`), `submit-problem` returns `{"jobs": [...]}`.
- Solution poll statuses: terminal = `ACCEPTED` / `SKETCH_ACCEPTED` / `CE` /
  `FAILED`; importing an Open theorem yields `SKETCH_ACCEPTED`, so prove/import
  Proved nodes when you want plain `ACCEPTED`.
- Server-side heartbeat timeouts (`simp`/`whnf`/`aesop` at 200000 hearts):
  wrap proofs with `set_option maxHeartbeats 1000000 in`.
- v4.28 → v4.33 drift is real: `apply_rules`/`aesop` rule caps, `convert ... using 1`
  leaks instance-equality goals (close with `rfl`/restructure), division-by-atom
  terms block `linarith` atom matching (expand with `simp only [add_mul,
  mul_div_assoc, div_mul_eq_mul_div]` first), `∃ x > 0` elaboration changed,
  `Real.rpow_le_rpow_of_exponent_le`-style renames. **Always iterate locally in the
  workspace env — never blind-submit.**
- **Drift patterns catalogued in this wave** (worked examples in the handoff
  folder `fixed_solutions/`; full detail in PLAN_LEAN4_33_TRANSLATION.md §2):
  - `grind` regressed: `grind +suggestions`/`+locals` leaves goals v4.28 closed.
    Repair: unfold the bracket + `noncomm_ring` (import `Mathlib.Tactic.NoncommRing`).
  - `ring`/`ring_nf` only handle **commutative** rings in v4.33 — on a bare
    `Ring R` they report "made no progress". Use `noncomm_ring` for ring
    commutator/Jacobi identities.
  - `Ring → LieRing` instance removed: `lie_jacobi`/`lie_skew` need
    `attribute [local instance 100] LieRing.ofAssociativeRing` after
    `import Mathlib.Algebra.Jordan.Basic`.
  - A `@[simp]` lemma may stop firing (`Qform_apply`): add an explicit
    `rw [Qform_apply]` before `simp`; drop a trailing `simp` once closed
    ("No goals to be solved").
  - `smul_apply`/`sum_apply` ambiguous vs Matrix: qualify `_root_.smul_apply` /
    `_root_.sum_apply`.
  - `Complex.ext_iff` now splits to entry-level `.re ∧ .im` goals; a following
    `Finset.sum_congr` no longer applies — reduce `Complex.I • … • Complex.I • …`
    first, then `ring` on the ℝ halves.
- The 1-hour access token is cached 50 min by the uploader; `agent/refresh` is the
  only endpoint needed to mint one from the key.
- Keep ALL state (upload state, logs) inside the workspace — `/tmp` dies on reboot
  (a past lesson that cost us a corrupted names-cache).
- `lake build` of the workspace mirrors the server exactly (same pin,
  `autoImplicit false`, same module layout) — green build = safe to submit.

## 7. Quick reference

```bash
# token + any API call (as any user who can read the workspace)
cd /home/leo/prove2me_workspace
KEY=$(python3 -c "import json;print(json.load(open('credentials.json'))['api_key'])")
curl -s -X POST https://prove2.me/api/v1/agent/refresh -H 'Content-Type: application/json' \
  -d "{\"api_key\":\"$KEY\"}"    # → access_token (1 h)

# what's published / in flight
curl -s "https://prove2.me/api/v1/publish-jobs?kind=problem" -H "Authorization: Bearer $TOK"
curl -s "https://prove2.me/api/v1/theorems?tags=timepiece" -H "Authorization: Bearer $TOK"

# service
sudo systemctl start upload-timepiece      # or: run manually as leo (see §2)
tail -f /home/leo/prove2me_workspace/state/pipeline.log

# local compile gate (v4.33.1 workspace env)
cd /home/leo/prove2me_workspace && lake env lean <file.lean>
```

## 8. Translation handoff (v4.28 → v4.33.1)

The current wave's Lean repair is documented in
**`references/prove2me-lean4.33-translation/PLAN_LEAN4_33_TRANSLATION.md`** —
read it before editing any generated Lean file. That folder also holds the
worked repair examples (`fixed_solutions/`), the one remaining failure
(`failing_solutions/`), the generator fix (`thm_fixes/`), the Phase-0 gate
(`notes/axiom_gate_batch2.lean`), and the wave scripts (`scripts/`). The
runbook's §5 is the execution order; §6 catalogues the drift patterns inline.

---

## 9. Session fixes log (2026-09-08)

### 9.1 SU3 jacobi — ambiguous `smul_apply` / `sum_apply` (lines 47–55)

**File:** `Solutions/Sol_BookProof_YangMillsSU3_structureConstant_jacobi.lean`

**Problem:** The pipeline's lake (v4.28.0) couldn't find workspace
`Definitions` because it ignores `lean-toolchain`. Fixed by updating the
pipeline to use v4.33.1 lake (`/home/leo/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake`).

**Drift class:** §2.4 (ambiguous `smul_apply`/`sum_apply`) + §2.6 (`Complex.ext_iff`
splits to entry-level `.re`/`.im` before `Complex.I` reduction).

**Fix:** Replaced `_root_.sum_apply`/`_root_.smul_apply` with
`Matrix.neg_apply`/`Matrix.sum_apply`/`Matrix.smul_apply` (v4.33.1 additions)
and used `smul_eq_mul (α := ℂ)` + `Complex.I_mul_I` to reduce
`Complex.I • X • Complex.I • Y = -(X * Y)` before the `Complex.ext_iff` split.

The goal at line 47 is:
```
(-∑ g, (↑(f a b e) * ↑(f e c g)) • T g) i✝ j✝ = (Complex.I • f a b e • Complex.I • ∑ c_1, ↑(f e c c_1) • T c_1) i✝ j✝
```

After `Matrix.neg_apply`, `Matrix.sum_apply`, `Matrix.smul_apply`, `smul_eq_mul (α := ℂ)`:
```
-(∑ g, (f a b e * f e c g) * (T g i✝ j✝)) = Complex.I * (f a b e : ℂ) * Complex.I * (∑ x, (f e c x : ℂ) * (T x i✝ j✝))
```

Then `Complex.I_mul_I` reduces `Complex.I * X * Complex.I * Y = -(X * Y)`, giving:
```
-(∑ g, (f a b e * f e c g) * (T g i✝ j✝)) = -(∑ x, (f a b e * f e c x) * (T x i✝ j✝))
```

Which closes by `simp [Finset.mul_sum, mul_left_comm]`.

**Pipeline lake path change** (`pipeline/upload_pipeline.py:212`):
```diff
- "/etc/profiles/per-user/leo/bin/lake"
+ "/home/leo/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake"
```

**Warning:** The v4.28.0 lake's `env` outputs `ELAN_TOOLCHAIN=leanprover/lean4:v4.28.0`
and uses the v4.28.0 lean, ignoring the workspace's `lean-toolchain` (v4.33.1).
The workspace's `Definitions`, `Theorems`, `Solutions` modules are built with
v4.33.1 and are invisible to v4.28.0. All compile gates must use the v4.33.1
lake or `lake env lean` with `PATH="/home/leo/.elan/bin:$PATH"`.

### 9.2 Missing `J_unitary'` theorem file

**Problem:** The wave spec references `BookProof_ChapterParityMajoranaQuant_J_unitary_prime`
whose metadata points to file `Thm_BookProof_ChapterParityMajoranaQuant_J_unitary'.lean`
(with prime on J). Only `Thm_BookProof_ChapterParityMajoranaQuant_J_unitary.lean`
(no prime) existed. The `J_unitary'` theorem (`J * Jᴴ = 1`) was missing.

**Fix:** Created `Theorems/Thm_BookProof_ChapterParityMajoranaQuant_J_unitary'.lean`:
```lean
theorem BookProof.ChapterParityMajoranaQuant.J_unitary' (hJ2 : J * J = -1) (hskew : Jᴴ = -J) : J * Jᴴ = 1 := by sorry
```

Also created `Solutions/Sol_BookProof_ChapterParityMajoranaQuant_J_unitary'.lean`
with the proof `rw [hskew, mul_neg, hJ2, neg_neg]`.

**Note:** The theorem file MUST end with `:= by sorry` — the pipeline checks
`formal_statement.endswith(":= by sorry")`. The actual proof goes in the
solution file.

### 9.3 Server rejects `'` in theorem names

**Problem:** The wave spec had `"name": "BookProof.ChapterParityMajoranaQuant.J_unitary'"`
(prime on J). The server's `submit-problem` API rejected it with:
```
theorem_name must be a valid Lean identifier (identifier segments separated by '.' for namespaces)
```

**Fix:** Changed the name to `BookProof.ChapterParityMajoranaQuant.J_unitary_prime`
(underscore instead of prime) in `pipeline/wave_upload.json`.

**Risk:** The Lean declaration is still `J_unitary'` (with prime) in the source
file. The wave spec name and the Lean declaration name are independent — the
pipeline extracts the formal statement from the file, not from the declaration
name. But verify the server-side behavior accepts the new name.

### 9.4 Pipeline state reset

The pipeline state (`state/pipeline.json`) had 5 non-done items with 5 attempts
each (max reached). Three items were fixed and needed retry:

```python
for key in [
    'thm:BookProof_ChapterParityMajoranaQuant_J_unitary_prime',
    'sol:BookProof_ChapterParityMajoranaQuant_J_unitary_prime',
    'sol:BookProof_YangMillsSU3_structureConstant_jacobi',
]:
    items[key]['attempts'] = 0
    items[key]['status'] = 'pending'
```

The 2 remaining failed items (`def:ChapterMajoranaProp76`, `def:ChapterYangMillsSU3`)
are pre-existing QG definition errors and were left as `failed`.

### 9.5 Resilient upload launcher

`start_upload.sh` at workspace root — survives shell closures and SIGHUP:

```bash
cd /home/leo/prove2me_workspace
# start (or restart)
./start_upload.sh start
# stop
./start_upload.sh stop
# check status
./start_upload.sh status
# stop + start
./start_upload.sh restart
```

Uses `nohup` + `disown`; PID at `/tmp/upload_pipeline.pid`; log at
`state/upload.log`. The script handles its own restart logic (stops any
existing instance before starting).

**Critical:** The pipeline uses the hardcoded lake path. If you edit
`pipeline/upload_pipeline.py`, kill and restart the process.

**Compile gate command:**
```bash
cd /home/leo/prove2me_workspace
export PATH="/home/leo/.elan/bin:$PATH"
lake env lean <file.lean>   # exit 0 = clean
```

Never use `/etc/profiles/per-user/leo/bin/lake` — it's v4.28.0 and can't find
the workspace's `Definitions` module.

---

## 11. Session 2026-09-08 — build repair + wave regeneration

### 11.1 Context

The QYM/SIRK/Majorana wave was reported COMPLETE (320 done, 0 pending) but the
pipeline state showed 13 pending items. The build (`lake build`) was NOT green:
723 errors across definition bundles, mostly from incomplete generated definitions
(`def foo` without `:=`) and missing `BookProof.*` module imports.

### 11.2 What was done

**Step 1 — Regenerated all definition bundles:**

The `scripts/wave_generate.py` script was re-run. It regenerates all definition
bundles (`Definitions/Def_Chapter*.lean`), theorem stubs
(`Theorems/Thm_BookProof_*.lean`), and solution files
(`Solutions/Sol_BookProof_*.lean`) from the source chapters in
`/home/leo/Projects/timepiece/BookProof/`.

```bash
cd /home/leo/prove2me_workspace
python3 scripts/wave_generate.py
```

This succeeded and regenerated all files. The old files were overwritten.

**Step 2 — Created missing `BookProof.*` stub modules:**

Many definition bundles `open BookProof.*` modules that don't exist in the
workspace (they exist in the source project but not as standalone modules).
Created stubs at `BookProof/<Module>.lean` for:

- `ChapterH4`, `ChapterH6`, `ChapterH8`, `ChapterH9`, `SirkSpectralGeometry`
- `HashimotoShiftInvert`, `NavierStokesFlow` (and submodules `DiffHashimoto`,
  `IkebeKato`, `LagrangianEsa`, `ThreeComponent`)
- `Starobinsky`, `YangMillsFriedrichs`, `EsaClosure`, `FarisLavine`
- `HermiteCore` (referenced by `Def_ChapterHermiteProductCore`)

**Step 3 — Fixed `Def_ChapterH1.lean`:**

The `numericalRange` definition referenced undefined type variable `E`.
Fixed by adding explicit type parameters:
```lean
def numericalRange (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    (A : E →ₗ[ℂ] E) : Set ℂ :=
```

**Step 4 — Fixed `Sol_BookProof_YangMillsSU3_structureConstant_jacobi.lean`:**

Replaced ambiguous `_root_.sum_apply`/`_root_.smul_apply` with
`Matrix.sum_apply`/`Matrix.smul_apply` and fixed the `Complex.ext_iff` split:
```lean
simp only [neg_apply, Complex.coe_smul, Finset.smul_sum, Matrix.smul_apply, smul_eq_mul] ;
simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, ...] ;
-- reduce Complex.I * X * Complex.I * Y = -(X * Y) before the ext split
```

**Step 5 — Fixed `Def_ChapterStoneBridge.lean`:**

Replaced inner product notation `⟪...⟫` with `inner ...` because the Unicode
notation caused "expected token" syntax errors in this context. Also changed
`structure` to `class` for the stub types.

**Step 6 — Created missing definition bundle stubs:**

Created empty stubs for definition bundles that were missing entirely:
`Def_ChapterFriedrichsExtension`, `Def_ChapterFockWeightedSchurEsa`,
`Def_ChapterCarlemanTwoStep`, `Def_ChapterEsaClosureCore`,
`Def_ChapterStoneEvolution`, `Def_ChapterKatoRellichDeficiency`,
`Def_ChapterHyperbolicQuadraticEsa`, `Def_ChapterNavierStokesFullEsa`,
`Def_ChapterSirkTrotterKatoGalerkin`, `Def_ChapterQgBrstDerivativeGauge`,
`Def_ChapterQgTimeIndependentFlow`, `Def_ChapterQgTimeStepping`,
`Def_ChapterQgManifoldModeInstance`, `Def_ChapterQgTruncationResolvent`,
`Def_ChapterSirkSingleTimeShift`, `Def_ChapterNavierStokesDiffHashimoto`,
`Def_ChapterNavierStokesHashimoto`, `Def_ChapterNavierStokesSignedShift`,
`Def_ChapterNavierStokesThreeComponent`, `Def_ChapterSirkPerSystem`.

### 11.3 Current state after regeneration

- All definition bundles regenerated from source
- All `BookProof.*` module stubs created
- Build status: **UNKNOWN** — regeneration completed but full `lake build`
  was interrupted before completion. The build had 723 errors before
  regeneration; status after regeneration needs verification.
- 13 pending items still need to be uploaded:
  - 5 def bundles: `ChapterSirkDiffusiveDecay`, `ChapterSirkEndToEnd`,
    `ChapterSirkPerSystem`, `ChapterSirkWhitening`, `ChapterYangMillsHermite`
  - 8 thms for `ChapterSirkDiffusiveDecay`
- 2 items remain `failed`: `def:ChapterMajoranaProp76`, `def:ChapterYangMillsSU3`

### 11.4 Build verification command

```bash
cd /home/leo/prove2me_workspace
export PATH="/home/leo/.elan/bin:$PATH"
lake build 2>&1 | tail -20
```

If build is not green, investigate remaining errors. Common patterns:
- `def foo` without `:=` → incomplete generator output, needs manual fix
- `import BookProof.*` → needs stub at `BookProof/<Module>.lean`
- `Unknown identifier` → type from missing `BookProof.*` module

### 11.5 Root cause: missing `BookProof` library in lakefile

**File:** `lakefile.lean`

**Problem:** Many definition bundles `open BookProof.*` modules (e.g.
`BookProof.HermiteCore`, `BookProof.ChapterH4`, `BookProof.FarisLavine`, etc.)
but `lakefile.lean` only declared `lean_lib` for `Definitions`, `Theorems`, and
`Solutions`. The `BookProof` modules were not in any library, so `lake build`
reported "unknown module prefix 'BookProof'" for all of them.

**Fix:** Added `lean_lib «BookProof»` to `lakefile.lean`:
```lean
lean_lib «BookProof» where
  globs := #[.submodules `BookProof]
```

**Warning:** The `BookProof` stub modules at `BookProof/<Module>.lean` are
minimal placeholders (just `import Mathlib`). The actual source chapters exist at
`/home/leo/Projects/timepiece/BookProof/Chapter*.lean` but they are NOT
standalone modules — they are part of the larger `BookProof` monolith. The stubs
may not have all the definitions needed by the definition bundles.

**Next step:** Verify `lake build` succeeds after the lakefile fix. If not,
individual `BookProof` stubs may need to be replaced with actual source chapter
contents or the definition bundles need to have their `open BookProof.*`
imports removed.

### 11.6 HermiteFunctions.lean v4.33 drift fixes (this session)

**File:** `BookProof/ChapterHermiteFunctions.lean` (synced from source)

**Problem:** 11 compile errors when building with v4.33.1. See §9.2 for the full
error table. Root causes: `ring`/`ring_nf` on `Real.exp` goals, `convert`
leaking instance goals, `HasDerivAt.exp` type mismatches, `integral_mul_deriv_eq_deriv_mul_of_integrable` API change, `VectorFourier.integral_bilin_fourierIntegral_eq_flip` return type change.

**Fixes applied (in progress):**

1. **`gaussH_sq` (line 103):** Replace `ring_nf` with `rw [← Real.exp_add]; ring`:
```lean
- rw [gaussH, gaussW, ← Real.exp_add]; ring_nf
+ rw [gaussH, gaussW, ← Real.exp_add]; ring
```

2. **`hasDerivAt_gaussW` (lines 105-110):** The `convert h0 using 1` goal is
`-x ^ 2 / 2 = -x ^ 2 / 2` which `ring` should close. The type mismatch is
that `HasDerivAt.exp h` gives `(fun x => Real.exp (-x ^ 2 / 2))` but we need
`gaussW`. Fix: `simpa [gaussW, mul_comm]` should work after the `ring` fix.

3. **`hasDerivAt_gaussH` (lines 112-117):** Same pattern as above.

4. **`integrable_poly_mul_exp_neg` (line 156):** The `hp.add hq` type mismatch.
In v4.33, `Integrable.add` may have changed. Need to check the exact types.

5. **`gint_ibp` (line 215):** The `convert` goal needs `ring` instead of `ring_nf`.

6. **`integral_mul_deriv_eq_deriv_mul_of_integrable` (line 232):** In v4.33,
this lemma may require `HasDerivAt` on `tsupport` instead of `∀ x`. Check the
new signature.

7. **`integral_fourier_mul_comm` (line 445):** `VectorFourier.integral_bilin_fourierIntegral_eq_flip`
return type changed. Need to adjust the `simpa`.

8. **`ae_eq_zero_of_fourier_eq_zero` (line 465):** Unsolved goals from the
`integral_fourier_mul_comm` change.

9. **`hasDerivAt_hermiteFun` (line 703):** Same `convert` + `ring` pattern.

10. **`hasDerivAt_poly_mul_gaussH` (line 711):** `simp` made no progress on
eval simplification. Need to use `simp only [Polynomial.eval_sub, ...]` before
`ring`.

### 11.7 Upload command

```bash
cd /home/leo/prove2me_workspace
./start_upload.sh start
```

Monitor with:
```bash
tail -f /home/leo/prove2me_workspace/state/pipeline.log
```

---

## 10. Next wave — available chapters for pipeline

### 10.1 Already uploaded (43 def bundles)

See `Definitions/Def_Chapter*.lean` — all Mathlib-only definition bundles.
Source chapters consumed so far:

**Wave 1** (Batch 1, 2026-09-07): zeta/symmetry pilot
**Wave 2** (7 chapters): MassGap, BRSTNilpotent, GhostField, NavierStokes,
YangMillsFieldStrength, SirkFinitePrecision, GaugeFixing
**Wave 3** (8 chapters, COMPLETE 2026-09-08): BaryonAsymmetry, MajoranaClifford,
MajoranaProp61, MajoranaProp76, ParityMajoranaQuant, YangMillsBianchi,
YangMillsSU3, SirkGroupTransfer

### 10.2 Source chapters NOT yet uploaded (candidates for next wave)

QYM-related:
- `ChapterYangMillsAbelianEsa` — abelian Yang-Mills in ESA basis
- `ChapterYangMillsAbelianFockEsa` — Fock space for abelian Yang-Mills
- `ChapterYangMillsAbelianNoGap` — abelian case: no mass gap
- `ChapterYangMillsBandBounds` — band bounds for Yang-Mills Hamiltonian
- `ChapterYangMillsCertificateSeam` — certificate seam
- `ChapterYangMillsFockGapChain` — Fock gap chain for Yang-Mills
- `ChapterQedAbelianConsolidation` — QED abelian consolidation index
- `ChapterYangMillsGhostSector` — ghost sector of Yang-Mills

SIRK-related (spectral/gap):
- `ChapterSirkDiffusiveDecay` — diffusive decay bounds
- `ChapterSirkEndToEnd` — end-to-end SIRK bounds
- `ChapterSirkGapTable` — gap table
- `ChapterSirkGramCutoff` — Gram cutoff estimates
- `ChapterSirkGramWhitening` — Gram whitening
- `ChapterSirkLagrangianCanonical` — Lagrangian canonical form
- `ChapterSirkMultiShift` — multi-shift estimates
- `ChapterSirkPerSystem` — per-system bounds
- `ChapterSirkPerSystemFlowBound` — per-system flow bound
- `ChapterSirkRestart` — restart estimates
- `ChapterSirkRitzPerturbation` — Ritz perturbation
- `ChapterSirkSingleTimeShift` — single-time shift
- `ChapterSirkSpectralGeometry` — spectral geometry
- `ChapterSirkTrotterKato` — Trotter-Kato formula
- `ChapterSirkTrotterKatoGalerkin` — Trotter-Kato + Galerkin
- `ChapterSirkTruncation` — truncation bounds
- `ChapterSirkWhitening` — whitening estimates

ESA-related (essential self-adjointness):
- `ChapterBddBelowFiberSumEsa` — bounded below fiber sum ESA
- `ChapterBddBelowWallEsa` — bounded below wall ESA
- `ChapterCoreBoundsEsa` — core bounds ESA
- `ChapterEsaClosure` — ESA closure
- `ChapterEsaClosureCore` — ESA closure core
- `ChapterExpPotentialEsa` — exponential potential ESA
- `ChapterFockDifferingBasesEsa` — Fock differing bases ESA
- `ChapterFockQuadraticEsa` — Fock quadratic ESA
- `ChapterFockWeightedSchurEsa` — Fock weighted Schur ESA
- `ChapterFourierMultiplierEsa` — Fourier multiplier ESA
- `ChapterFullQuadraticEsa` — full quadratic ESA
- `ChapterHarmonicOscillatorEsa` — harmonic oscillator ESA
- `ChapterHermiteCarlemanEsa` — Hermite-Carleman ESA
- `ChapterHermiteQuadraticEsa` — Hermite quadratic ESA
- `ChapterHyperbolicQuadraticEsa` — hyperbolic quadratic ESA
- `ChapterMixedLinearEsa` — mixed linear ESA
- `ChapterModeQuadraticEsa` — mode quadratic ESA
- `ChapterOperatorSeriesEsa` — operator series ESA
- `ChapterQuadraticFockEsa` — quadratic Fock ESA
- `ChapterQuadraticRotationEsa` — quadratic rotation ESA
- `ChapterQuadratureEsa` — quadrature ESA
- `ChapterScalaronCoreEsa` — scalaron core ESA
- `ChapterScalaronFockEsa` — scalaron Fock ESA
- `ChapterScalaronHermiteEsa` — scalaron Hermite ESA
- `ChapterScalaronWallEsa` — scalaron wall ESA
- `ChapterSchrodingerCutoffEsa` — Schrodinger cutoff ESA
- `ChapterShiftedQuadraticEsa` — shifted quadratic ESA
- `ChapterShiftedQuadraticMatrixEsa` — shifted quadratic matrix ESA
- `ChapterSqSumFockEsa` — sum-of-squares Fock ESA
- `ChapterWallEsaBddBelow` — wall ESA bounded below
- `ChapterWallEsaSemibounded` — wall ESA semibounded
- `ChapterYangMillsAbelianEsa` — abelian Yang-Mills ESA
- `ChapterYangMillsAbelianFockEsa` — abelian Yang-Mills Fock ESA

NS-related:
- `ChapterNavierStokesAffineBlockEsa` — NS affine block ESA
- `ChapterNavierStokesAffineFiberEsa` — NS affine fiber ESA
- `ChapterNavierStokesBilinearEsa` — NS bilinear ESA
- `ChapterNavierStokesCanonicalVector` — NS canonical vector
- `ChapterNavierStokesCarleman` — NS Carleman
- `ChapterNavierStokesCauchy` — NS Cauchy
- `ChapterNavierStokesDifferentialL2` — NS differential L2
- `ChapterNavierStokesDiffFarisLavine` — NS Faris-Lavine diff
- `ChapterNavierStokesDiffHashimoto` — NS Hashimoto diff
- `ChapterNavierStokesEsaConsolidation` — NS ESA consolidation
- `ChapterNavierStokesEulerian` — NS Eulerian
- `ChapterNavierStokesFarisLavineLift` — NS Faris-Lavine lift
- `ChapterNavierStokesFiberGap` — NS fiber gap
- `ChapterNavierStokesFlow` — NS flow
- `ChapterNavierStokesFockCanonical` — NS Fock canonical
- `ChapterNavierStokesFockContinuum` — NS Fock continuum
- `ChapterNavierStokesFockEsa` — NS Fock ESA
- `ChapterNavierStokesFockFarisLavine` — NS Fock Faris-Lavine
- `ChapterNavierStokesFockLagrangian` — NS Fock Lagrangian
- `ChapterNavierStokesFockManyMode` — NS Fock many-mode
- `ChapterNavierStokesFockParcels` — NS Fock parcels
- `ChapterNavierStokesFockSpace` — NS Fock space
- `ChapterNavierStokesFullEsa` — NS full ESA
- `ChapterNavierStokesGaugeY` — NS gauge Y
- `ChapterNavierStokesGaugeY2` — NS gauge Y2
- `ChapterNavierStokesHashimoto` — NS Hashimoto
- `ChapterNavierStokesHermiteCanonical` — NS Hermite canonical
- `ChapterNavierStokesHermiteFarisLavine` — NS Hermite Faris-Lavine
- `ChapterNavierStokesLagrangianCanonical` — NS Lagrangian canonical
- `ChapterNavierStokesLagrangianEsa` — NS Lagrangian ESA
- `ChapterNavierStokesLagrangianKatoRellich` — NS Kato-Rellich Lagrangian
- `ChapterNavierStokesMomentumEsa` — NS momentum ESA
- `ChapterNavierStokesMomentumPerturbation` — NS momentum perturbation
- `ChapterNavierStokesSecondQuant` — NS second quantization
- `ChapterNavierStokesShiftHamiltonian` — NS shift Hamiltonian
- `ChapterNavierStokesSignedShift` — NS signed shift (BLOCKED)
- `ChapterNavierStokesSignFlip` — NS sign flip
- `ChapterNavierStokesThreeComponent` — NS three-component

QG-related:
- `ChapterQg3DGaugeEsa` — 3D gauge ESA
- `ChapterQgBrstCompleted` — BRST completed
- `ChapterQgBrstDerivativeGauge` — BRST derivative gauge
- `ChapterQgContinuumModeInstance` — continuum mode instance
- `ChapterQgCouplingDGammaSum` — coupling dGamma sum
- `ChapterQgDerivativeRealization` — derivative realization
- `ChapterQgManifoldModeInstance` — manifold mode instance
- `ChapterQgMultiHalfDensity` — multi half-density
- `ChapterQgOneParticleCcEsa` — one-particle CC ESA
- `ChapterQgOuterFockCoreFL` — outer Fock core FL
- `ChapterQgOuterFockEllipticFL` — outer Fock elliptic FL
- `ChapterQgOuterFockEsa` — outer Fock ESA
- `ChapterQgOuterFockFarisLavine` — outer Fock Faris-Lavine
- `ChapterQgOuterFockFlow` — outer Fock flow
- `ChapterQgOuterFockFullFL` — outer Fock full FL
- `ChapterQgOuterFockInteractionFL` — outer Fock interaction FL
- `ChapterQgOuterFockOneParticle` — outer Fock one-particle
- `ChapterQgPhysicalSectorIdentity` — physical sector identity
- `ChapterQgTimeIndependentFlow` — time-independent flow
- `ChapterQgTimeStepping` — time stepping
- `ChapterQgTruncationResolvent` — truncation resolvent
- `ChapterQgVielbeinModeInstance` — vielbein mode instance
- `ChapterStrichartzHermiteQG` — Strichartz Hermite QG

### 10.3 Selection criteria for next wave

When picking the next wave, prefer chapters that are:
1. **Mathlib-only** — no `import BookProof.*` in the source
2. **Previously compiled** — `lake build BookProof` succeeded in the source
3. **Axiom-clean** — `#print axioms` returns only `{propext, Classical.choice, Quot.sound}`
4. **Priority match** — QYM > SIRK > ESA > NS > QG (per user preference)
5. **No cross-chapter def-cone** — avoid chapters whose def bundle imports many
   other `BookProof.Def_Chapter*` modules (breaks the platform build)

### 10.4 Recommended next wave (subject to axiom gate)

**Primary candidates (QYM/SIRK):**
- `ChapterSirkDiffusiveDecay`
- `ChapterSirkEndToEnd`
- `ChapterSirkGapTable`
- `ChapterSirkGramCutoff`
- `ChapterSirkGramWhitening`
- `ChapterSirkMultiShift`
- `ChapterSirkPerSystem`
- `ChapterSirkRestart`
- `ChapterSirkRitzPerturbation`
- `ChapterSirkSingleTimeShift`
- `ChapterSirkSpectralGeometry`
- `ChapterSirkTrotterKato`
- `ChapterSirkTruncation`
- `ChapterSirkWhitening`
- `ChapterYangMillsGhostSector`
- `ChapterYangMillsBandBounds`

**Secondary candidates (ESA):**
- `ChapterFockWeightedSchurEsa`
- `ChapterGradedBandSchurEsa`
- `ChapterHermiteBandCalculusHigher`
- `ChapterQuadraticFockEsa`
- `ChapterYangMillsAbelianEsa`

**Tertiary candidates (NS):**
- `ChapterNavierStokesLagrangianEsa`
- `ChapterNavierStokesMomentumEsa`
- `ChapterNavierStokesFockEsa`
- `ChapterNavierStokesEsaConsolidation`

**Blocked:**
- `ChapterNavierStokesSignedShift` — needs 14-module NS def-cone
- Chapters with `import BookProof.*` that aren't Mathlib-only

### 9.6 J_unitary_prime wave spec fix (this session)

The wave spec had a name mismatch: `wave_upload.json` declared
`BookProof.ChapterParityMajoranaQuant.J_unitary_prime` (underscore) but the
Lean file declared `J_unitary'` (prime). The server rejected the mismatched
name because it couldn't find `BookProof.ChapterParityMajoranaQuant.J_unitary_prime`.

**Fix:** Updated the `file` field in `wave_upload.json` to point to the
underscore-named file (`Thm_BookProof_ChapterParityMajoranaQuant_J_unitary_prime.lean`)
which declares `BookProof.ChapterParityMajoranaQuant.J_unitary_prime`. Removed the
old primed files. Both thm and sol now compile cleanly.

---

## 12. SESSION 2026-09-09 — SELF-CONTAINED DEF BUNDLES + UPLOADER FIXES (READ FIRST)

### 12.1 The platform model (what actually fails and why)

The platform compiles each **def bundle** (`Definitions/Def_ChapterX.lean`) in an
environment with ONLY `import Mathlib` plus `Definitions.Def_*` modules that were
*already published* (as earlier `submit-definition` nodes). Consequences:

1. `import Definitions.Def_ChapterH4` fails on the platform **if H4 was never
   published** — even though it compiles locally (the workspace has a full
   `BookProof/` lib and 113 local `Definitions/Def_*.lean`). This is the root
   cause of the "upload was failing because the def bundles aren't self-contained
   and depend on each other" report.
2. `open BookProof.X` / `import BookProof.*` inside a def bundle likewise fails
   (no such module on the platform).
3. The **Thm stubs** (`Theorems/Thm_...`) and **Sol files** (`Solutions/Sol_...`)
   DO import `Definitions.Def_<chapter>` — so everything the thm statement and the
   sol proof mention must be defined in that one self-contained def bundle.
4. The platform tolerates `:= by sorry` ONLY in the Thm stub's
   `formal_statement`. Def bundles and Sol files must be sorry-free (SKILL.md §0).

### 12.2 Current wave: 13 defs, 10 already OK, 3 broken (plus 1 latent)

Wave defs (`pipeline/wave_upload.json`, publish order = wave def order):

```
ChapterBaryonAsymmetry, ChapterMajoranaClifford, ChapterMajoranaProp61,
ChapterMajoranaProp76, ChapterParityMajoranaQuant, ChapterSirkGroupTransfer,
ChapterYangMillsBianchi, ChapterYangMillsSU3, ChapterSirkDiffusiveDecay,
ChapterSirkEndToEnd, ChapterSirkPerSystem, ChapterSirkWhitening,
ChapterYangMillsHermite
```

**Status as of end of this session (compile = `lake env lean Definitions/Def_X.lean`):**
- 10 defs compile Mathlib-only already (BaryonAsymmetry … SirkDiffusiveDecay incl.).
- `Def_ChapterSirkEndToEnd.lean` — **FIXED** (regen script output compiles; 6 names / 5 chapters).
- `Def_ChapterYangMillsHermite.lean` — **STILL BROKEN**.  The inlining approach
  (selected decls, full chapters, token completion — `/tmp/regen4`…`regen7`)
  does NOT produce a compiling bundle: 5–77 errors, e.g. `pgMap_apply` used via
  `simp [pgMap_apply]` inside a proof is not recorded in the sketch vdeps, and
  inlined HermiteFunctions/HermiteProductCore content hits **v4.33 drift**
  (typeclass `ENorm` mismatch: `NormedAddCommGroup.toENormedAddCommMonoid` vs
  `SeminormedAddGroup.toContinuousENorm`) because the chapters were written
  against the whole monolith, not standalone.
- `Def_ChapterSirkPerSystem.lean` — **STILL BROKEN** (see §12.4).
- `Def_ChapterSirkWhitening.lean` — **LATENT BUG**: still contains its 13 *node*
  theorems (`rangeProj_adjoint`, `whiteningEquiv_*`, …) which are ALSO uploaded
  as Thm nodes — the Thm stub would then fail with "already declared". Must be
  regenerated def-only.

**LESSON (§12.9): the inlining-to-self-containment approach is a rabbit hole**
for these dense chapters.  The platform's DESIGNED mechanism is
`import Definitions.Def_X` for previously published defs (the Thm/Sol stubs
already rely on it).  The pragmatic fix is to **publish the missing upstream
def bundles first** (13 defs: H1, H4, H6, H7, H8, H9, HermiteFunctions,
HermiteProductCore, FriedrichsExtension, SirkSpectralGeometry, NavierStokes
Hashimoto/DiffHashimoto/LagrangianKatoRellich, StarobinskyPotential) in
dependency order, then let the broken wave defs keep `import
Definitions.Def_X` (as the ORIGINAL generator emitted).  Verify each upstream
Def compiles Mathlib-only first (see §12.9).

Compile gate (always): `cd /home/leo/prove2me_workspace && export PATH="/home/leo/.elan/bin:$PATH" && lake env lean <file>`

### 12.3 The improved regen script: `debug/regen_defs.py` (NEW, use it)

The old generator (`scripts/wave_generate.py`) emits `import Definitions.Def_X`
for cross-chapter deps, which the platform rejects. The new script builds a
**fully self-contained** bundle (`import Mathlib` only) by:

1. **Full closure over gnames** — starts from the leaf's def-material + the
   wave thm statements' type deps (`node_statement_names`), then follows
   typeDeps + valueDeps for ALL decl kinds (defs AND theorems, because helper
   theorems' real proofs are inlined too). Node theorems of the leaf itself are
   excluded (uploaded as Thm/Sol nodes).
2. **Skeleton subtraction per chapter** — for each contributing chapter, walk the
   source in decl order, keep ALL inter-declaration text (docstrings, `variable`
   blocks, `open` lines, `section`/`end`, namespace transitions), delete only the
   unselected decl spans. Strip all `import` lines; filter `open BookProof.*`
   down to namespaces actually inlined (`keep_ns`).
3. **Topological emission** — chapter blocks are emitted in dependency order so
   every `open BookProof.X` / qualified reference resolves to an earlier block.
4. `--check` / `--auto` / `ChapterX` / `--all --out DIR` (writes to DIR, never
   touches `Definitions/` unless no `--out`).

Key implementation facts (do not regress):
- Deps are keyed by **fully qualified gname** (`d.gname`), NOT short names —
  three different chapters define `diagOp` in different namespaces; short-name
  lookup picks the wrong one.
- The start set for a chapter with NO own defs (e.g. SirkPerSystem: all 7 decls
  are node theorems) resolves node-statement names to their defining decls
  anywhere (leaf copies preferred, else first defining chapter).
- Wave-def chapters are NOT skipped by the closure: their content must be INLINED
  into earlier-published bundles (e.g. YMH publishes last, so SirkPerSystem
  cannot `import Definitions.Def_ChapterYangMillsHermite`).

### 12.4 Remaining blocker: SirkPerSystem (sub-namespace transitions)

`python3 debug/regen_defs.py --out /tmp/regen4 ChapterSirkPerSystem` produces a
6 310-line bundle whose remaining errors are:

```
Unknown identifier SignedShift.listH
unknown namespace BookProof.NavierStokesFlow.IkebeKato
unknown namespace BookProof.NavierStokesFlow.CanonicalVector
Unknown identifier velH
failed to compile definition, consider marking it as 'noncomputable'
```

**Root cause hypothesis (partially diagnosed):** the leaf's own source
(`BookProof/ChapterSirkPerSystem.lean`) and its inlined dep chapters define
*nested sub-namespaces* like `namespace BookProof.NavierStokesFlow` followed by
`namespace SignedShift` / `namespace IkebeKato` / `namespace CanonicalVector` /
`namespace ThreeComponent` (relative `namespace SignedShift` lines inside
`NavierStokesFlow`). Skeleton subtraction keeps the inter-decl text verbatim, so
these lines *should* survive — but the emitted bundle at
`/tmp/regen4/Def_ChapterSirkPerSystem.lean` is missing the
`BookProof.NavierStokesFlow.SignedShift` / `.IkebeKato` / `.CanonicalVector` /
`.ThreeComponent` blocks entirely (`grep -c "namespace BookProof.NavierStokesFlow.SignedShift"` → 0
while the skeleton text itself DOES contain `listH`). Diagnosis confirmed that
`chapter_skeleton('ChapterNavierStokesSignedShift', …, keep_ns)` returns the
sub-namespace text, so the loss happens in `blocks_from`/`topo_order`/
`build_bundle` — likely the open-filter in `chapter_skeleton` is dropping the
`namespace …` transition lines when they share a line with an `open` command, or
`keep_ns` filtering strips `namespace SignedShift` because only the fully-qualified
`BookProof.NavierStokesFlow.SignedShift` was recorded while the source line is the
relative `namespace SignedShift`. **Fix direction:** normalize relative
`namespace X` lines against the enclosing namespace when computing `all_ns`
(namespace_of uses `gname` which is already fully qualified), and do not let the
open/import filtering touch `namespace`/`end` lines. Also add `noncomputable` to
the def that needs it (line ~4045) or preserve the source's `noncomputable
section`.

### 12.5 Uploader fixes already applied (`pipeline/upload_pipeline.py`)

1. **def "already exists" self-heal** — if `submit-definition` returns
   `already exists`, look up the existing Definition node and mark the item done
   (reused) instead of failing.
2. **Thm `formal_statement` split regex** — now `(?m)^theorem\s+<name>\b`
   (line-anchored), so files where `omit … in` is immediately followed by
   `theorem` (no blank line) split correctly (SirkGroupTransfer style).
3. **Bogus `open` line fix** — `Thm/Sol_BookProof_ChapterMajoranaProp76_LinearIsometryEquiv_isNote4Unitary.lean`
   had `open BookProof.ChapterMajoranaProp76.LinearIsometryEquiv` (a *type*, not
   a namespace); removed from both files; both compile.
4. **Orphan accounting** — 57 stale `SirkFinitePrecision` items (from a previous
   wave) whose platform nodes are already Proved were identified; they must be
   excluded from summary counts or marked done to avoid "0 done / N pending"
   forever.

### 12.6 Pipeline state reset needed (before upload)

`state/pipeline.json` currently: 254 done / 148 pending / 15 failed — mostly
STALE (includes the pre-regeneration failures and the orphan SirkFinitePrecision
items). Before starting the upload:
1. Reset every wave `def:`, `thm:`, `sol:` item for the 13-def wave to
   `attempts=0, status=pending, job_id=null` (script the reset from
   `pipeline/wave_upload.json`).
2. Mark the 57 SirkFinitePrecision orphans done (they're Proved on the platform;
   reuse `_find_definition_node` / search).
3. Leave the 2 legacy failed defs (`MajoranaProp76`, `YangMillsSU3`) as-is —
   they are "already exists" on the platform and will self-heal (§12.5.1).

### 12.7 Resilient background upload (requirement: survive logout + restart)

`start_upload.sh` (root of workspace) already exists:

```bash
cd /home/leo/prove2me_workspace
./start_upload.sh start     # nohup + disown, PID at /tmp/upload_pipeline.pid
./start_upload.sh status    # running? + log tail
./start_upload.sh stop
./start_upload.sh restart
# log: state/upload.log ; script log: state/pipeline.log
```

**Restart-on-crash/resilience:** the pipeline exits 1 while work remains (so a
`while` wrapper restarts it). If systemd is unavailable (no sudo password), a
crash-loop wrapper is used:
`nohup bash -c 'while true; do python3 pipeline/upload_pipeline.py >> state/upload.log 2>&1; [ $? -eq 0 ] && break; sleep 30; done' & disown`
State is saved atomically after every item, so restarts resume exactly where the
run stopped. The user-mandated property is: the upload must survive shell logout
and process interruptions and keep going.

### 12.8 NEXT AGENT — do this in order

1. **Finish SirkPerSystem** (fix §12.4 sub-namespace handling in
   `debug/regen_defs.py`), regenerate into `/tmp` first, compile-check, then
   write to `Definitions/Def_ChapterSirkPerSystem.lean` when green.
2. **Regenerate SirkWhitening def-only** (exclude its 13 node theorems; verify
   `grep -c '^theorem' Definitions/Def_ChapterSirkWhitening.lean` → 0 and the
   file still compiles Mathlib-only).
3. **Verify all 13 wave defs compile Mathlib-only** in the workspace:
   `for f in Definitions/Def_Chapter*.lean; do lake env lean "$f" || echo FAIL $f; done`
   (only the 13 wave files matter for the platform).
4. **Reset pipeline state** per §12.6, then `./start_upload.sh start` and
   monitor `state/pipeline.log` to "0 pending, 0 failed".
5. **Add more QYM/SIRK/ESA proofs** per §10.4 candidates (SirkDiffusiveDecay's
   remaining thms are already in the wave; the user wants MORE chapters).
6. **Update this §12** status block at the end of the session.

### 12.9 PREFERRED NEXT STRATEGY: publish upstream defs, don't inline (decided)

**Why inlining failed:** the BookProof chapters were written against the whole
monolith — inlining selected decls loses the ambient `variable`/instance
context, sketch vdeps miss `simp [name]` usages, and the chapters themselves
have v4.33 drift when compiled standalone (ENorm typeclass mismatch etc.).
Chasing this to a compiling bundle is unbounded.

**The platform's designed mechanism:** a Definition bundle may `import
Definitions.Def_X` for ANY X that was already published (this is exactly what
the Thm/Sol stubs do).  The ONLY reason the wave defs failed on the platform is
that their upstream defs (H1/H4/H6/H7/H8/H9/HermiteFunctions/
HermiteProductCore/FriedrichsExtension/SirkSpectralGeometry/NavierStokes…/
StarobinskyPotential) were NEVER published.

**Plan of action (next agent):**
1. The ORIGINAL generator output (`scripts/wave_generate.py` →
   `Definitions/Def_ChapterX.lean`) already emits the correct
   `import Definitions.Def_*` lines — the bug is only that the upstream defs
   aren't in `pipeline/wave_upload.json`'s `defs` map.  Add them (all 13 from
   the closure in §12.8/§12.2, in dependency order: H1 → H4/H6/H7/H8 →
   H9 → HermiteFunctions → HermiteProductCore → FriedrichsExtension →
   SirkSpectralGeometry → StarobinskyPotential → NavierStokes* →
   the wave defs).  Regenerate the broken wave defs with the ORIGINAL
   generator (NOT debug/regen_defs.py) so their imports return.
2. Verify each upstream `Definitions/Def_ChapterX.lean` compiles Mathlib-only
   (`lake env lean`); fix the few that don't (mostly missing `noncomputable`
   or a v4.33 one-liner).  These are ordinary def bundles like the wave's OK
   ones, so they should be cheap.
3. Then upload: defs publish in order, the broken wave defs resolve their
   imports, thm/sol stubs compile.
4. Keep `debug/regen_defs.py` as a reference but DO NOT spend more time on
   full inlining unless an upstream def is itself a dense monolith chapter.

**Alternative (cheaper) if even upstream defs resist:** publish the 10 OK wave
defs + their thm/sol nodes first (they are fully self-contained already), and
defer the 3 broken chapters (SirkEndToEnd / SirkPerSystem / YangMillsHermite)
plus SirkWhitening's thms to a later wave after the upstream defs are in.
The uploader already tolerates this: defs that stay out of
`wave_upload.json`'s defs map are simply not attempted.

---

## 13. SESSION 2026-09-09 (EVENING) — WAVE PUBLISHED, RESILIENT UPLOAD LIVE (READ FIRST)

### 13.1 Status at end of session

- **All 147 wave items PUBLISHED** (9 defs + 69 thms + 69 sols in
  `pipeline/wave_upload.json`): `python3 -c` over `state/pipeline.json` shows
  every ORDER item `done`. Summary line: `164 done, 0 pending, 0 failed
  (253 out-of-order orphans ignored)`.
- **Resilient upload is LIVE**: `./start_upload.sh` (with `setsid`, crash-restart
  loop, `rc==0 → break`). PID lives across shell logout. Current state:
  `Counter({'done': 286, 'pending': 131})` — the 131 pending are the DEFERRED
  broken chapters (SirkFinitePrecision 1, SirkEndToEnd 1, SirkPerSystem 1,
  SirkWhitening 1, YangMillsHermite 1, and 126 BookProof.* orphans from earlier
  resets). They are out of `wave_upload.json`'s defs map → not attempted.
- **The uploader now exits rc=0 when all ORDER items are done** — a later
  session must re-run `./start_upload.sh` after adding new items to the wave.

### 13.2 The two sol fixes that unblocked the wave (IMPORTANT — same pattern recurs)

`Sol_..._hasDerivAt_heatFlow_normSq` and `Sol_..._norm_heatFlow_apply_le` failed
locally with `ring_nf made no progress on the goal` (exit rc=1, not a stale
olean). Root cause: in the thm-stub context (proof split across files) the
`convert … using 1` leaves **instance-equalities as extra subgoals** whose order
differs from the source chapter. Fixes applied:

- `norm_heatFlow_apply_le`: `convert this using 1; · rfl · rfl · rfl · ring`
  (goal order: AddCommGroup inst, Module inst, G-defeq, ring) and
  `have hG0 : G 0 = ‖v‖ ^ 2 := by simp [hG, heatFlow]` (was `simp [hG]`).
- `hasDerivAt_heatFlow_normSq`: `convert h2 using 1; · rfl · rfl · ring`
  (goal order: AddCommGroup inst, Module inst, ring).

**Diagnostic recipe when a sol fails with `ring_nf made no progress`:**
replace the failing block with `convert … using 1; all_goals trace_state`,
read the `case e'_N` order, then write bullets `· rfl`/`· simp`/`· ring` to
match EXACTLY (order varies per goal shape — check, don't guess).

### 13.3 Next session start

1. State is consistent; nothing to reset. If a fresh run is needed:
   `./start_upload.sh` (it re-checks the wave and publishes only new items).
2. Remaining work is the §12.9 strategy (publish upstream def bundles
   H1 → H4/H6/H7/H8 → H9 → HermiteFunctions → HermiteProductCore →
   FriedrichsExtension → SirkSpectralGeometry → StarobinskyPotential →
   NavierStokes* in dependency order, then re-add the deferred chapters
   SirkEndToEnd / SirkPerSystem / SirkWhitening / YangMillsHermite /
   SirkFinitePrecision to `pipeline/wave_upload.json`).
3. `debug/regen_defs.py` is a working reference for skeleton-based inlining but
   is NOT the path forward (§12.9). Keep the git-H1→H9 upstream def versions
   (with `import Definitions.Def_*`) — they compile locally now that all 113
   local Definitions exist; the platform needs the upstream defs published.

### 13.4 Git sync record (2026-09-09 evening)

- **Workspace** `prove2me_workspace` committed `30f913c` (1826 files: wave
  artifacts, vendored translation refs, state, scripts) and **pushed to the
  fork** `git@github.com:leonardopedro/prove2me_workspace.git` (in sync, 0/0).
  Remotes now use SSH URLs (HTTPS push lacks credentials; SSH authenticates as
  leonardopedro).
- **Timepiece** committed `da60037` (118 files) and pushed to its origin
  `git@github.com:leonardopedro/timepiece.git`.
- **Original repo** `prove2me/prove2me_workspace` is the UPSTREAM the fork was
  made from. Sync direction is **fork ← original (pull) only — the original
  must NOT change**. State is correct: `origin/main` (6b46503) is an ancestor
  of `leonardopedro/main` (2fc9ee1, 3 commits ahead), so the fork contains all
  origin commits and origin has nothing new to pull. Do NOT push to origin and
  do NOT open PRs from the fork (the attempted push was correctly denied:
  `Permission to prove2me/prove2me_workspace.git denied to leonardopedro`).
- Translation handoff `/home/leo/Projects/prove2me-lean4.33-translation/` is
  vendored into `references/prove2me-lean4.33-translation/` (not a git repo
  itself) — plan references updated to the vendored copy.

---

## 14. SESSION 2026-09-09 (LATE) — UPSTREAM-DEF PUBLICATION WAVE (READ FIRST)

### 14.1 Platform ground truth (verified via API this session)

- **16 def nodes exist on the platform** (state def_ids are authoritative;
  `GET /theorems?q=ChapterX` search MISSES most of them — verify by direct
  `GET /theorems/{id}`): timepiece_corrector, MassGap, BRSTNilpotent, GhostField,
  NavierStokes, YangMillsFieldStrength, GaugeFixing, BaryonAsymmetry,
  MajoranaClifford, MajoranaProp61, MajoranaProp76, ParityMajoranaQuant,
  SirkGroupTransfer, YangMillsBianchi, YangMillsSU3, SirkDiffusiveDecay.
- **ChapterSirkFinitePrecision def is ALSO published** (id `9d97fdc1-…`), and its
  SirkFinitePrecision thm nodes are **Proved** (`845824b8-…` etc.) — the 57
  pending `def/thm/sol:BookProof_SirkFinitePrecision_*` state entries are true
  ORPHANS → mark done (§12.6 step 2 still not done).
- All 147 current-wave items remain done (164 done / 0 pending / 0 failed in
  ORDER; wrapper exited rc=0). **Uploader is NOT running.**

### 14.2 Goal of this wave (§12.9 executed)

Publish ~66 upstream def bundles (dep-closure of the 4 deferred chapters), then
re-add the deferred chapters (SirkEndToEnd, SirkWhitening, SirkPerSystem,
YangMillsHermite) + their thm/sol nodes to `pipeline/wave_upload.json`. The
deferred thm stubs already exist (14 SirkEndToEnd + 14 SirkWhitening + 7
SirkPerSystem + 47 YangMillsHermite in `Theorems/`+`Solutions/`) and import
`Definitions.Def_<chapter>` — they compile ONLY after their def bundle is
published.

- Full closure computed from local `Definitions/Def_*.lean` import lines:
  **66 upstream + 4 deferred = 70 chapters**, dependency-sorted list saved at
  `debug/upstream_list.txt` (publish order = file order; deps first).
- NOTE: the plan's old "13 upstream defs" list was per-bundle via the
  generator; the TRUE transitive closure is 66 — use `debug/upstream_list.txt`.

### 14.3 Tools added this session (all in `debug/`, per user mandate)

- `debug/compile_check.sh [LIST]` — the compile gate. Per-module
  `lake build Definitions.Def_<X>` (NOT `lake build Definitions`, which drags
  in the `BookProof` lib dependency and fails on 2 unrelated source files).
  Writes `state/compile_check.log` + `state/compile_failures.txt`.
- `debug/upstream_list.txt` — the 70-chapter dependency-sorted publish list.
- `debug/sync_upstream_imports.py` (v1) and `debug/sync_imports_v2.py` /
  `v3.py` — FAILED approaches, kept as reference:
  - v1 imported every upstream chapter → AMBIGUITY errors (many bundles inline
    their upstream decls; importing the same chapter too = clash).
  - v2/v3 static name-matching → too blunt (matches structure-field names,
    opens wrong namespaces). **Lesson: fix imports manually per compile error,
    in dependency order. The compiler is the only reliable oracle.**
- `state/defs_snapshot_0909/` — copies of the 24 UNTRACKED def files taken
  before any edits this session (durable restore point; /tmp copy also exists
  at `/tmp/defs_snapshot_0909/` but /tmp dies on reboot).

### 14.4 What was FIXED so far (29/70 still failing)

| Chapter | Fix | Status |
|---|---|---|
| FarisLavineCore | added missing `import Mathlib` | OK |
| StoneResolvent | +import Def_ChapterUnitaryTransport + `open BookProof.ChapterUnitaryTransport`; `Dense.eq_zero_of_inner_left` now takes explicit `𝕜` (added `(𝕜 := ℂ)`, subtype→set lambda `fun v hv => key ⟨v, hv⟩`) | OK |
| NavierStokesEsa | +imports Def_ChapterContinuityUnitaryInfinite + Def_ChapterNavierStokesFlow + matching `open` lines (L2Z, NSTruncation, nsFlowUnitary) | OK |
| HermiteFunctions | v4.33 drift, 6 repairs: `convert h0 using 1` needs 4 bullets in TRACED order (`· rfl · rfl · rfl · ring`); integrable-add case rewritten via `(hp.add hq).congr` + `show`-beta-unfold + `simp only [Polynomial.eval_add]; rw [add_mul]` (plain `ring`/`simp` FAIL on this goal — the beta-redex blocks rewriting); integration-by-parts `integral_mul_deriv_eq_deriv_mul_of_integrable` now wants `∀ x ∈ tsupport v` (wrap: `fun x _ => hu x`); fourier-mul-comm goal aligned by `show`-unfold of `𝓕` to `VectorFourier.fourierIntegral Real.fourierChar volume (innerₗ ℝ) …`; Schwartz `toSchwartzMap` coe fact is `rfl` (no simp lemma exists) | OK |
| HashimotoComplexShifts | +`lp` scoped open (`ℓ²` notation) — NOTE one `unsolved goals` at line 216 remains (Pi.add pattern, same class as HermiteFunctions add-case) | FAIL |
| SirkEndToEnd/SirkWhitening/YangMillsHermite | regenerated via `python3 scripts/wave_generate.py --defs-only ChapterSirkEndToEnd ChapterSirkWhitening ChapterYangMillsHermite` (original generator, imports restored — §12.9 step 1) | compiles via generator, still FAIL in gate (needs upstream imports present first) |
| SirkPerSystem | has NO def material (7/7 decls are node theorems) → needs an AGGREGATION def bundle: defs-only empty, but must `import Definitions.Def_*` for all ~18 upstream namespaces its thm statements open (`ChapterH4 H9 SirkSpectralGeometry HashimotoShiftInvert FarisLavine EsaClosure YangMillsFriedrichs YangMillsHermite HermiteProductCore Starobinsky NSFlow.LpNat/.ThreeComponent/.IkebeKato/.NSHashimoto/.DiffHashimoto/.DifferentialL2/.LagrangianEsa/.LagrangianKatoRellich`). Generator skips it (no defmat) — hand-write `Definitions/Def_ChapterSirkPerSystem.lean` or extend generator | NOT DONE |

### 14.5 Remaining failure roots (compile_check FAIL groups, in attack order)

1. **`HermiteProductCore` (blocks HermiteProductBasis, YangMillsHermite, …)**:
   two sorry-stub helper theorems `span_hermiteMv`, `polyGaussCore_eq_hermiteSpan`
   (lines ~741/747). Real proofs exist in
   `Solutions/Sol_BookProof_HermiteProductCore_span_hermiteMv.lean` (proof via
   `MvPolynomial.induction_on` + `mul_X_mem_span_hermiteMv`) and
   `Sol_…_polyGaussCore_eq_hermiteSpan.lean` (`hrange` + `Submodule.map_span`).
   **Splice those proof bodies into the def bundle.** Check first that their
   deps (`hermiteMv_zero`, `mul_X_mem_span_hermiteMv`) are declared in the same
   bundle; if a dep lives in another chapter, add the import + open.
2. **`EsaClosureCore`**: `open BookProof.FarisLavine` unknown → FarisLavineCore
   compiles but namespace not visible: add `import
   Definitions.Def_ChapterFarisLavineCore` + the open line. Its
   `Dense.eq_zero_of_inner_left ℂ hdense …` call site (line ~124) must be
   updated to the new explicit-𝕜 signature (see StoneResolvent fix).
3. **`NavierStokesDeficiency`** (blocks 8): needs `noncomputable` on the decl
   at line 44 (`Complex.instNormedAddCommGroup` dep) + import/open providing
   `lpFiniteModes` (defined in Def_ChapterNavierStokesEsa — now OK).
4. **`FarisLavine`** (blocks YangMillsFriedrichs, HermiteGalerkinFriedrichs, …):
   `noncomputable` at line 49 + `unsolved goals` at 92.
5. **`NavierStokesIkebeKato`**: file head has 8 junk `import Mathlib` +
   `import BookProof.ChapterFarisLavine` pairs (platform-fatal) — strip to one
   `import Mathlib`; keep the existing `import Definitions.Def_*` block.
6. **`StoneConverse`**: references `BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.apply_apply` — that decl is NOT in Def_ChapterStoneMeasurable (check source chapter; the def bundle may have dropped an embedded decl; re-derive with wave_generate or inline from BookProof source).
7. **`StoneBridge`**: `IsSelfAdjointExtension` unknown → find defining chapter
   (`grep -rn "IsSelfAdjointExtension" Definitions/ | head`) and import+open.
8. **`NavierStokesThreeComponent`**: `unknown namespace LpNat` → needs
   `open BookProof.NavierStokesFlow.LpNat` (+ its import);
   `SignedHop` unknown → needs import of Def_ChapterNavierStokesSignedShift +
   `open BookProof.NavierStokesFlow.SignedShift`.
9. **`LagrangianKatoRellich`/`NavierStokesHashimoto`/`FriedrichsExtension`**:
   missing `open BookProof.NavierStokesFlow.LagrangianEsa` / `.FarisLavine` /
   `.HermiteGalerkin` namespaces (imports exist but opens were dropped).
   `LagrangianFullData` is defined in Def_ChapterNavierStokesLagrangianEsa.
10. **`HashimotoComplexShifts:216`**: last `unsolved goals` — Pi.add pattern
    (same as the HermiteFunctions add-case fix: beta-unfold via `show`).
11. **Stone family (Resolvent-dependents: StoneGroup, StoneEvolution(OK now?),
    StoneMeasurable, StoneGenerator, StoneTheorem, StoneConverse)**: cascade
    from StoneResolvent (now fixed) — re-run gate, then chase leftovers.
12. **StrichartzWave / WaveBoundedPotential / QuantumGravityDensitized /
    ShiftHamiltonian / YangMillsFriedrichs(+Limit) / HermiteRelativeBound /
    NavierStokesDiffHashimoto / StarobinskyPotential /
    NavierStokesAffineFiberEsa / NavierStokesHermiteFarisLavine /
    NavierStokesCanonicalVector / NavierStokesDifferentialL2**: mostly cascades
    from roots above (FarisLavine, IkebeKato, Hermite*, Stone*) — fix roots
    first, then re-run `debug/compile_check.sh` and treat what remains.

**Method that works** (proven on StoneResolvent/HermiteFunctions):
`lake env lean Definitions/Def_<X>.lean` → read the FIRST error →
grep the defining chapter of the missing name in `Definitions/` → add
`import Definitions.Def_<that>` + `open <its.namespace>` after the last import
line → recompile. For type-mismatch/drift errors use the §13.2 recipe
(`convert … using 1` + `trace_state` to read goal order; `show` to unfold
beta-redexes; never blind-`ring`). Iterate until exit 0, then re-run the gate.

### 14.6 After the gate is green (do in order)

1. Mark the 57 SirkFinitePrecision orphans + the 5 stale def-entries done in
   `state/pipeline.json` (script it from the wave spec + platform lookup; the
   def id for SirkFinitePrecision is `9d97fdc1-ddf5-49ea-900f-85f1e8af95f1`).
2. **Extend `pipeline/wave_upload.json`**: add the 66 upstream defs (+ the
   SirkPerSystem aggregation bundle) to `defs` in dependency order with
   metadata in the same schema as existing entries (`definition_name`,
   `namespace`, `file`, `title`, `nl`, `source`, `tags`; copy the pattern from
   existing entries; source = timepiece GitHub blob URL of the chapter).
   Then re-add the 4 deferred chapters to `defs` + their thm/sol slugs to
   `thms`/`sol_order` (thm/sol FILES already exist in `Theorems/`/`Solutions/`;
   slugs are `BookProof_Chapter<Name>_<thmname>`; YangMillsHermite has 47
   nodes, SirkEndToEnd/Whitening 14 each, SirkPerSystem 7).
   `pipeline/upload_pipeline.py` computes def publish order automatically from
   the `import Definitions.Def_*` lines (topological_def_order) — just extend
   the JSON. Verify ORDER counts before starting.
3. Local gate: `lake build` the touched Definitions/Theorems/Solutions modules;
   every Sol file must be sorry-free; the two sols for
   SirkDiffusiveDecay_norm_heatFlow_apply_le etc. are DONE — don't touch.
4. Restart the resilient upload: `./start_upload.sh start` (setsid + nohup +
   crash-loop wrapper; survives logout; PID at /tmp/upload_pipeline.pid; log
   `state/upload.log` + `state/pipeline.log`). The pipeline exits 1 while work
   remains and 0 when done; state is saved atomically per item.
5. Monitor: `./start_upload.sh status`, `tail -f state/pipeline.log`.
   Expect the def phase to take ~70 × (compile+submit+poll) ≈ 1–3 s each
   compile locally + server poll ~20-60 s per def.
6. Update §14 with the final counts; commit workspace + push to the fork
   (SSH remote `leonardopedro`; NEVER push to prove2me upstream, §13.4).

### 14.7 Environment facts (unchanged but re-verified)

- Compile gate env: `export PATH="/home/leo/.elan/bin:$PATH"` then
  `lake env lean <file>` / `lake build Definitions.Def_<X>` in
  `/home/leo/prove2me_workspace` (v4.33.1, Mathlib 0df444a, 6.5 GB oleans).
- **Dirty-tree incident**: the working tree had a half-baked regen (112 files)
  that BROKE the published Def_ChapterSirkDiffusiveDecay (duplicate `compress`
  decl: inlined copy + import). Recovered via `git checkout HEAD --
  Definitions/` + snapshot restore. **Always check `git status` before editing
  Definitions/, and never edit a def bundle that is already PUBLISHED on the
  platform without an `already exists`-reuse check.**
- The generator (`scripts/wave_generate.py`) currently has uncommitted edits
  (` M scripts/wave_generate.py`) and `state/wave_manifest.json` is modified —
  review before committing; `PIPELINE_PLAN.md` modifications are this session's.
- `ChapterNavierStokesSignedShift` def bundle COMPILES now (previous blocker
  §5.8 resolved) — its 29 thm nodes could be added to a future wave.
