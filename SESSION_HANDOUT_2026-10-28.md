# Session handout — def-bundle regate campaign (2026-10-28)

Read this first in a new session, then `AGENTS.md`, then the tail of
`PIPELINE_PLAN.md` (Session 27 entries give the canonical mirror recipe).

## 1. What this work is

Goal: drive `state/def_gate.json` (694 entries) from
`448 OK / 206 BLOCKED / 38 FAIL / 1 NOSRC` toward all-OK, by repairing the
failing `Definitions/Def_Chapter*.lean` bundles and re-gating them. A green
def gate is the binding constraint on thm/sol uploads (see
`PIPELINE_PLAN.md` Session 27 tail: thm/sol uploadable = 0, gated on def
bundles).

## 2. The loop (canonical commands)

Every round is: **audit → edit → regate**.

```bash
export PROVE2ME_SKIP_LOCAL_COMPILE=1
export TIMEPIECE_PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331  # v4.33.1 — NOT the v4.28 checkout
export CANDIDATE_MIRROR=$(pwd)/state/mirror

# 1. audit: all missing decls for one failing bundle, one pass
python3 debug/audit2.py Definitions/Def_ChapterFoo.lean
#    (audit_chain.py = same without the own-chapter scan; both copied into
#     debug/ this session from /tmp)

# 2. edit the bundle (see §4 recipes)

# 3. regate serially, targets in a file, report + per-target logs
python3 debug/regate_bundles.py --targets-file /tmp/rNN.txt --report /tmp/regate_rNN.tsv
#    → /tmp/regate_rNN.tsv (status<TAB>target), logs in /tmp/regate_rNN.tsv.logs/
```

Key facts about `regate_bundles.py` (read its source; 188 lines):
- Stages workspace copies into the mirror before compiling; updates
  `state/def_gate.json` for requested targets only (sha1 stamp per target).
- Default timeout 1800 s; override with `REGATE_TIMEOUT=7200` for monsters.
- `--jobs N` exists but **run with jobs=1** (see §6 OOM).
- `TIMEPIECE_PROJ` default is `../timepiece331` — correct.
- The full-mirror rebuild (`debug/build_candidate_mirror.py`, ~4.5 h) is
  **not** needed unless the mirror itself is stale/missing.

## 3. Immediate in-flight work (do this first)

1. **ChapterFockWeightedSchurEsa** — I inserted a local copy of
   `theorem oscCol_entries_unbounded` (with docstring) from source
   `BookProof/ChapterFockWeightedSchurEsa.lean:805–819`, immediately before
   `oscCol_not_schurBound`, in the bundle (now at bundle line 819). It has
   **not been regated yet** (the r26 run was killed by OOM/session end).
   → regate `ChapterFockWeightedSchurEsa` first.
2. **ChapterGradedBandSchurEsa** — verdict is STALE (stamp mismatch); last
   error was `38:58 unknown namespace BookProof.FockWeightedSchur`. The bundle
   *does* declare `namespace BookProof.FockWeightedSchur` at line 76, so this
   is expected to clear once FockWeightedSchurEsa compiles to a fresh olean.
   → regate it second, behind #1.
3. r26 target file already exists: `/tmp/r26.txt` (those two targets).
   `/tmp` may be wiped by an OOM reboot (happened in Session 27) — recreate
   from this section if gone.
4. Session todos at handoff: (a) round-5/6 wave targets → done for 9/21, see
   §5; (b) fix remaining failures iteratively; (c) final verification + report
   of the session's original three user requests (the request text itself was
   lost to context compaction — **ask the user to restate them** before
   writing any final report).

## 4. Failure classes and recipes (learned the hard way this session)

| Class | Signature | Recipe |
|---|---|---|
| Stale olean | error points at a decl the bundle *does* have; or "already declared" for a decl you deduped | regate the **host** bundle to refresh its mirror olean; no edit needed |
| Missing decl from imported bundle | `Unknown identifier x` | `audit2.py` locates host; **cycle-check first** (BFS over `^import` both directions incl. Thm stubs). If safe: add `import Theorems.Thm_...` stub line. If cyclic: **local copy** the decl from source into the bundle |
| Own-chapter missing decl | audit prints `OWN-MISSING` | A Thm stub of your own chapter imports your own bundle → **always a cycle** → local copy from `BookProof/<Chapter>.lean` |
| Import cycles through third bundles | stub import compiles into a text-level cycle (e.g. QgOuterFock → … → back) | drop the stub import; find a bundle that already carries the decl in a fresh olean, or local copy |
| Bundle corruption | `unexpected token`, comment-balance off, decls truncated, imports inside module comment | run a systematic bundle-vs-source diff (did this for QG3DGauge, FockSecondQuantization, FockSchurEsa): compare line-by-line against `BookProof/<Chapter>.lean`, restore real spans |
| Duplicate decl | `has already been declared` | dedup: your copy vs a freshly-built imported bundle; delete the copy that the import already provides (e.g. `up_self`, `inner_pgLp_pgLp`, LeafGaps' YMH cluster) |
| Self-import | line 1 `import Definitions.Def_<itself>` | delete the line (QgOuterFock had this) |
| `environment already contains 'X' from <other bundle>` | two bundles both ship copy of X; importer pulls both (LeafGaps vs NavierStokesShiftHamiltonian `conj_mul_hFun`) | remove the copy from the *weaker*/downstream bundle |
| Doc/decl adjacency | `unexpected identifier; expected command` right after a docstring | two consecutive `/-- -/` blocks or a doc separated from its decl — keep exactly one blank line, doc immediately before decl |
| Stub name typo | stub theorem name ≠ source name (`memLp` vs `memℓp`) | fix the stub, delete its stale `.olean` in `state/mirror/Theorems/` so it recompiles |

Copy-editing rules that bit us: byte/line offsets from source must be
verified with an assert before writing (off-by-one landed content in the
wrong spot once); never insert `import` lines by index arithmetic inside the
module comment block — anchor on the existing `^import` group.

## 5. r5 wave status (21 targets; 9 OK as of handoff)

OK: ChapterH9, ChapterHermiteGalerkinFriedrichs, ChapterHashimotoShiftInvert,
ChapterFriedrichsExtension, ChapterQgHermiteFriedrichs,
ChapterDegSchrodingerCore, ChapterDegKatoEsa, ChapterFockSchurEsa,
ChapterHermiteRelativeBound.

Still FAIL (in gate now): ChapterLeafGaps (`365:16 starP_mul already
declared` — bundle no longer declares it; verdict likely stale, regate),
ChapterH1 (`71:0 unexpected identifier` — H1.3 heading region looks clean on
inspection; regate to see real error), ChapterFockWeightedSchurEsa,
ChapterGradedBandSchurEsa, ChapterYangMillsAbelianEsa
(`momPoly_eq_ymMomOp`), ChapterYangMillsAbelianNoGap
(`BookProof.YangMillsHermite.RealCoeff.sum`), ChapterBddBelowFiberSumEsa
(`wallHamBddBelow_semibounded`), ChapterQgBrstDerivativeGauge,
ChapterQgTimeIndependentFlow, ChapterFiniteSectionSingleTime (all three:
LeafGaps/ShiftHamiltonian `conj_mul_hFun` clash), ChapterQymTimeIndependentFlow
(missing FiniteSectionSingleTime olean), ChapterQuantumGravity3DGauge
(`229:19 unexpected token 'at'`).

## 6. Full remaining FAIL inventory (38, from `state/def_gate.json`)

10 of these have a **STALE stamp** (edited since last gate — regate first,
may already pass): DiagonalDGammaEsa, FiniteSectionSingleTime,
QgFullEliminated, CarlemanSimplex, CarlemanTwoStep, GradedBandSchurEsa,
ModeQuadraticEsa, NavierStokesCauchy, NavierStokesMomentumPerturbation,
QgBrstDerivativeGauge, QgTimeIndependentFlow, QymTimeIndependentFlow,
SmHamiltonian. (Actually 13 — see `stamp` compare below.)

Remaining CURRENT failures grouped:

- **Syntax/corruption suspects**: ChapterA (`31:18 unknown System`),
  ChapterContinuityUnitaryInfinite (`54:39 unexpected token import`),
  ChapterH1 (`71:0`), ChapterNavierStokesCauchy (`96:0`),
  ChapterQuantumGravity3DGauge (`229:19 unexpected token 'at'`),
  ChapterSchrodingerCutoffEsa (`693:59 unexpected ','`),
  ChapterWeakSecondDerivative (`108:0`), ChapterWeylHamiltonian (`65:0`).
- **Duplicate decls**: ChapterA3h (`pauliσ`), ChapterF4 (`sgn`),
  ChapterPinOmega (`qi`), ChapterSmBrstGhost (`sumStruct`), ChapterLeafGaps.
- **Missing identifiers**: BddBelowFiberSumEsa, CarlemanTwoStep (`mem_cube`),
  DiagonalDGammaEsa, EulerGenericDensity (`n`), GroupAverageEsa
  (`UnitaryRep`), MackeyImprimitivity (`ImprimitivitySystem`),
  NavierStokesMomentumPerturbation (`SymmetricOn`), SirkCertifiedGap
  (`rflruncated` — likely a *typo'd* identifier, check source),
  SmHamiltonian (`starP_sub`), StatementOperator (`ModelStatement`),
  StoneMeasurable (`WeakMeasurableUnitaryGroup`), WeylCauchyRiemann,
  WeylSL2Unipotent (`isExpOfSl2_stdRep.expE`), YangMillsAbelianEsa,
  YangMillsAbelianNoGap, HermiteFunctions (`711:2 overloaded, errors`).
- **Unknown namespace**: CarlemanSimplex, ModeQuadraticEsa
  (`BookProof.CarlemanTwoStep` — that bundle is itself FAIL:Blocked class),
  GradedBandSchurEsa, QgFullEliminated
  (`BookProof.QgVielbeinScalaronGaugeFL` — no published bundle provides it;
  needs the new-name def route, see PIPELINE_PLAN §3).
- **Import clash**: FiniteSectionSingleTime, QgBrstDerivativeGauge,
  QgTimeIndependentFlow (LeafGaps `conj_mul_hFun` vs
  NavierStokesShiftHamiltonian), QymTimeIndependentFlow (missing olean).
- **NOSRC**: Def_ChapterGradedFock (no workspace source — generator artifact).

Re-derive this list any time with:

```bash
python3 - <<'EOF'
import json, hashlib, os
g=json.load(open('state/def_gate.json'))
for k,v in sorted(g.items()):
    if k.startswith('_') or not isinstance(v,dict): continue
    s=v.get('status','')
    if not s.startswith('FAIL'): continue
    p=f"Definitions/Def_{k}.lean"; st=None
    if os.path.exists(p): st=hashlib.sha1(open(p,'rb').read()).hexdigest()[:16]
    print(('STALE' if st==v.get('stamp') else 'CURR '), k, '|', s[:110])
EOF
```

## 7. OOM constraint (user-reported 2026-10-28)

The machine has **15 GB RAM** and Lean bundle compiles are heavy. OOM events
were observed while regate rounds were running — likely from **two regate
processes alive at once** (a nohup'd copy survived a session end alongside a
new launch).

Rules:
- **One regate at a time.** Before launching: `ps aux | grep regate_bundles`.
  Kill stragglers with `pkill -f regate_bundles.py`.
- Launch long runs with `setsid nohup … < /dev/null &` so they survive
  session end, but note the session end may still kill tool-managed
  background processes — re-check with `ps` on resume.
- `--jobs 1` (default) only. Never parallel lean compiles.
- If OOM persists on one bundle, suspect a pathological `isDefEq` (Session
  27: 184 s unifier timeout → fixed with a fully explicit type ascription;
  see PIPELINE_PLAN tail).

## 8. Repository state / cautions

- **~2793 uncommitted changes** in git (all bundle edits from this long
  campaign). Nothing was committed or pushed this session. Committing is a
  user decision — ask.
- Never touch `credentials.json` (gitignored), never send keys anywhere but
  `https://prove2.me/api/v1`. Push only established sync targets (this repo,
  `../timepiece`, `../test`, `../unfer`).
- Sibling repos are read-only; source of truth for decls is
  `$TIMEPIECE_PROJ/BookProof/<Chapter>.lean`.
- `state/` is regenerable — never hand-edit `def_gate.json` or oleans; the
  only legit olean deletion is to force a recompile of a *repaired* stub.
- Verdicts are only comparable if compiled with the same flags — don't change
  `regate_bundles.py`'s lean invocation.
