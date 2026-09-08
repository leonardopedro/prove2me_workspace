# Timepiece → Prove2me Transplant — Runbook & Plan

This file is the handoff document for ANY LLM agent (opencode, Claude Code, Codex, a
plain CLI model — anything that can run shell commands) to continue the ongoing
transplant of the **timepiece** Lean 4 project onto the **Prove2me** platform.

> **CURRENT TASK (2026-09-08): finish the QYM/SIRK/Majorana wave.** Go straight to
> **§5** and follow it in order: fix the one remaining v4.33.1 compile failure
> (`Sol_BookProof_YangMillsSU3_structureConstant_jacobi`), get `lake build` green,
> and upload via the service. The v4.28→v4.33.1 repair playbook is in
> **§8 / `/home/leo/Projects/prove2me-lean4.33-translation/PLAN_LEAN4_33_TRANSLATION.md`**.

---

## -1. Bootstrap

Fetch **https://prove2.me/start.md** and follow it to set up — it is the
platform's official agent onboarding: it picks the setup path (git vs
fetch-only), clones/fetches the workspace, and hands off to SKILL.md.
**Do NOT register** — this machine is already registered (account
leonardopedro4@gmail.com, API key in `credentials.json`); reuse it as-is.

## 0. Load the skill FIRST (mandatory)

The prove2me skill is the authoritative guide for everything platform-related.

**Where it lives (this machine):**

| Location | For whom |
|---|---|
| `/home/leo/prove2me_workspace/SKILL.md` | canonical workspace (user `leo`) |
| `/home/oseditor/prove2me_workspace/SKILL.md` | clone for the agent user `oseditor` |

**How to load it:**

- **opencode**: already wired — both users' `~/.config/opencode/opencode.json` have
  `"skills": {"paths": ["<home>/prove2me_workspace"]}`. Verify with
  `opencode debug skill`. Nothing else to do.
- **Claude Code**: `mkdir -p ~/.claude/skills/prove2me && cp <workspace>/SKILL.md ~/.claude/skills/prove2me/`
  (references/ resolves relative to the SKILL.md location — copy or symlink the whole workspace).
- **Any other LLM/agent**: put this in its system/first prompt:
  > Read `$HOME/prove2me_workspace/SKILL.md` (or the path above) and follow it. Read
  > `references/upload_full_project.md` for the transplant playbook and
  > `references/prove.md` + `references/contribute.md` for the API schemas.
  > Then read this runbook and continue.

**Version self-check** (from the skill): compare the `version` returned by
`POST /api/v1/agent/refresh` with `metadata.version` in SKILL.md (0.9.7 as of writing).
If they differ: `git -C <workspace> pull --tags origin main` before anything else.

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

**CURRENT WAVE (2026-09-08): the QYM/SIRK/Majorana wave — generated, staged,
NOT yet uploaded.** 8 Mathlib-only chapters — `BaryonAsymmetry`,
`MajoranaClifford`, `MajoranaProp61`, `MajoranaProp76`, `ParityMajoranaQuant`,
`YangMillsBianchi`, `YangMillsSU3`, `SirkGroupTransfer` — producing
**8 def bundles + 59 theorems + 59 solutions** in the workspace mirror
(`Definitions/`, `Theorems/`, `Solutions/`). Phase-0 axiom gate passed (0 BAD).
`pipeline/wave_upload.json` regenerated for this wave. **One solution file still
fails to compile under v4.33.1**: `Sol_BookProof_YangMillsSU3_structureConstant_jacobi.lean`
(see §5.1/§5.2). Several other files were already drift-repaired (worked examples
in the handoff folder). **This wave is the NEXT AGENT TASK — execute §5.**

Webapp note: items are public and queryable via API; the web UI may cache —
search the theorem name or filter tag `timepiece`.

## 5. NEXT AGENT TASK: finish the QYM/SIRK/Majorana wave (v4.28 → v4.33.1 repair + upload)

**You (the agent reading this) should execute the following, in this order.**

### 5.0 First: read the two authoritative references

1. `/home/leo/Projects/prove2me-lean4.33-translation/PLAN_LEAN4_33_TRANSLATION.md` —
   **the v4.28 → v4.33.1 translation plan.** It catalogues every drift class
   found so far, the repair templates, the still-open item, and the file map of
   fixed/failing artifacts. Read it before touching any Lean file.
2. `references/upload_full_project.md` in this workspace — the transplant
   playbook (phases 0–6). Then this §5 and §6.

The handoff folder `/home/leo/Projects/prove2me-lean4.33-translation/` holds:
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
**`/home/leo/Projects/prove2me-lean4.33-translation/PLAN_LEAN4_33_TRANSLATION.md`** —
read it before editing any generated Lean file. That folder also holds the
worked repair examples (`fixed_solutions/`), the one remaining failure
(`failing_solutions/`), the generator fix (`thm_fixes/`), the Phase-0 gate
(`notes/axiom_gate_batch2.lean`), and the wave scripts (`scripts/`). The
runbook's §5 is the execution order; §6 catalogues the drift patterns inline.
