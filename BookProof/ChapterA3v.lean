import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n
import BookProof.ChapterA3o
import BookProof.ChapterA3p
import BookProof.ChapterA3q
import BookProof.ChapterA3r
import BookProof.ChapterA3u

/-!
# Chapter A, §A.3 — Note 50 / Lemma 52: dimensions of the complete-reducibility
summands at `N = 6`

Source: `book.tex` §A.3, Note 50 (Weyl complete reducibility) and Lemma 52.

`ChapterA3r`/`ChapterA3s`/`ChapterA3t`/`ChapterA3u` computed the ranks (traces)
of the complete-reducibility projectors `{projSym N, projAnti N, projMixed N}`
at `N = 2, 3, 4, 5`.  This file takes the next case `N = 6`.  As at `N = 5`, the
totally antisymmetric summand `Λ⁶V` vanishes — a `4`-dimensional space has no
nonzero `6`-fold exterior power.

The base tool is the general **orbit-count** lemma `card_fixedTuples` from
`ChapterA3u`: by `ChapterA3r.trace_permMat`, `tr (permMat σ)` counts the index
tuples `a : Fin N → Fin 4` fixed by `σ`, and there are `4^{c(σ)}` of them, where
`c(σ) = (N − Σ cycleType) + (#cycleType)` is the number of orbits of `σ`.  So
`tr (permMat σ) = 4^{c(σ)}` (`ChapterA3u.trace_permMat_pow`), and the traces of
the two averaged projectors are finite sums over `S₆` of small numbers,
discharged by kernel `decide` (no `native_decide`):

* `Σ_{σ∈S₆} 4^{c(σ)} = 60480`, so `tr (projSym 6) = 60480 / 6! = 60480 / 720 = 84`
  (`= dim Sym⁶V = C(9,6)`);
* `Σ_{σ∈S₆} sgn(σ)·4^{c(σ)} = 0`, so `tr (projAnti 6) = 0` (`= dim Λ⁶V = C(4,6) = 0`);
* the mixed piece is `4⁶ − 84 − 0 = 4096 − 84 = 4012`.

Everything is proved **without** the `EXTERNAL` Weyl hypothesis, `sorry`-free /
`axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`).

## Deliverables

* `trace_projSym_six` — `tr (projSym 6) = 84` (`= dim Sym⁶V`).
* `trace_projAnti_six` — `tr (projAnti 6) = 0` (`= dim Λ⁶V`, vacuous exterior power).
* `trace_projMixed_six` — `tr (projMixed 6) = 4012` (the mixed-symmetry piece).
* `trace_decomposition_six` — `84 + 0 + 4012 = 4096 = dim (V^{⊗6})`.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3v

open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r
open BookProof.ChapterA3u

set_option maxRecDepth 100000 in
set_option maxHeartbeats 4000000 in
-- kernel `decide` over the `720` permutations of `S₆` needs the raised limit
/-- **Dimension of `Sym⁶V`.**  The symmetric-sixth-power projector has rank `84`. -/
theorem trace_projSym_six : Matrix.trace (projSym 6) = 84 := by
  unfold projSym; norm_num;
  rw [ Finset.sum_congr rfl fun x _ => trace_permMat_pow x ] ; norm_cast;
  field_simp;
  exact mod_cast by decide

set_option maxRecDepth 100000 in
set_option maxHeartbeats 4000000 in
-- kernel `decide` over the `720` permutations of `S₆` needs the raised limit
/-- **Dimension of `Λ⁶V`.**  The antisymmetric-sixth-power projector has rank `0`:
a `4`-dimensional space has no nonzero `6`-fold exterior power. -/
theorem trace_projAnti_six : Matrix.trace (projAnti 6) = 0 := by
  unfold projAnti;
  simp [signC, trace_permMat_pow];
  norm_cast

/-- **Dimension of the mixed-symmetry piece at `N = 6`.**  Its projector has
rank `4012 = 4096 − 84 − 0`. -/
theorem trace_projMixed_six : Matrix.trace (projMixed 6) = 4012 := by
  unfold projMixed; norm_num;
  rw [ trace_projSym_six, trace_projAnti_six ] ; norm_num

/-- **Dimension count of the complete-reducibility decomposition** at `N = 6`:
`dim Sym⁶V + dim Λ⁶V + dim(mixed) = 84 + 0 + 4012 = 4096 = dim (V^{⊗6})`. -/
theorem trace_decomposition_six :
    Matrix.trace (projSym 6) + Matrix.trace (projAnti 6)
        + Matrix.trace (projMixed 6) = 4096 := by
  rw [trace_projSym_six, trace_projAnti_six, trace_projMixed_six]
  norm_num

end BookProof.ChapterA3v
