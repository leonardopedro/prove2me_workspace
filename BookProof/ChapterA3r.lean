import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n
import BookProof.ChapterA3o
import BookProof.ChapterA3p
import BookProof.ChapterA3q

/-!
# Chapter A, §A.3 — Note 50 / Lemma 52: dimensions of the complete-reducibility
summands (the ranks of the symmetric / antisymmetric / mixed projectors)

Source: `book.tex` §A.3, Note 50 (Weyl complete reducibility) and Lemma 52.

`ChapterA3n`/`ChapterA3o`/`ChapterA3q` built, for arbitrary `N`, the complete
system of pairwise orthogonal idempotent full-Lorentz–invariant projectors
`{projSym N, projAnti N, projMixed N}` realizing
`V^{⊗N} = Sym^N V ⊕ Λ^N V ⊕ (mixed symmetry)`.

Because each of these is an **idempotent** endomorphism of a finite-dimensional
space, its **trace equals its rank**, i.e. the dimension of the summand it
projects onto.  This file computes those traces in the base case `N = 2`
(the tensor square of the `4`-dimensional Dirac spinor `V`), giving the concrete
dimension count

  `dim (V ⊗ V) = 16 = 10 + 6`,   `dim Sym²V = 10`,   `dim Λ²V = 6`,

with the mixed piece vanishing.  Everything is proved **without** the `EXTERNAL`
Weyl hypothesis.

## Deliverables

* `trace_permMat` — the trace of a braiding matrix `permMat σ` is the number of
  index tuples fixed by `σ` (general `N`).
* `trace_projSym_two` — `tr (projSym 2) = 10` (`= dim Sym²V`).
* `trace_projAnti_two` — `tr (projAnti 2) = 6` (`= dim Λ²V`, the Def 57 pair).
* `trace_projMixed_two` — `tr (projMixed 2) = 0` (no mixed piece for `N = 2`).
* `trace_decomposition_two` — the dimension count `10 + 6 + 0 = 16 = dim (V ⊗ V)`.

Everything is `sorry`-free / `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`), with **no `EXTERNAL` hypothesis**.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3r

open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

/-- **Trace of a braiding matrix.**  The trace of `permMat σ` counts the index
tuples `a : Fin N → Fin 4` fixed by the slot permutation `σ`. -/
theorem trace_permMat {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    Matrix.trace (permMat σ) =
      ((Finset.univ.filter (fun a : Idx N => a ∘ σ = a)).card : ℂ) := by
  simp only [Matrix.trace, Matrix.diag, permMat, Matrix.of_apply]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero,
    nsmul_eq_mul, mul_one]
  congr 2
  ext a
  simp [eq_comm]

/-- **Dimension of `Sym²V`.**  The symmetric-square projector has rank `10`. -/
theorem trace_projSym_two : Matrix.trace (projSym 2) = 10 := by
  unfold projSym; norm_num;
  rw [ Finset.sum_congr rfl fun σ _ => trace_permMat σ ];
  rw [ div_mul_eq_mul_div, div_eq_iff ] <;> norm_cast

/-- **Dimension of `Λ²V`.**  The antisymmetric-square projector has rank `6`
(the Def 57 pinor pair). -/
theorem trace_projAnti_two : Matrix.trace (projAnti 2) = 6 := by
  unfold projAnti; norm_num;
  simp only [one_div, signC, trace_permMat];
  rw [ inv_mul_eq_div, div_eq_iff ] <;> norm_cast

/-- **No mixed piece at `N = 2`.**  The mixed-symmetry projector vanishes. -/
theorem trace_projMixed_two : Matrix.trace (projMixed 2) = 0 := by
  rw [projMixed_two_eq_zero, Matrix.trace_zero]

/-- **Dimension count of the complete-reducibility decomposition** at `N = 2`:
`dim Sym²V + dim Λ²V + dim(mixed) = 10 + 6 + 0 = 16 = dim (V ⊗ V)`. -/
theorem trace_decomposition_two :
    Matrix.trace (projSym 2) + Matrix.trace (projAnti 2)
        + Matrix.trace (projMixed 2) = 16 := by
  rw [trace_projSym_two, trace_projAnti_two, trace_projMixed_two]
  norm_num

end BookProof.ChapterA3r
