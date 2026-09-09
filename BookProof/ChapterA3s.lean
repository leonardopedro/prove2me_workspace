import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n
import BookProof.ChapterA3o
import BookProof.ChapterA3p
import BookProof.ChapterA3q
import BookProof.ChapterA3r

/-!
# Chapter A, §A.3 — Note 50 / Lemma 52: dimensions of the complete-reducibility
summands at `N = 3` (the first case with a nonzero mixed-symmetry piece)

Source: `book.tex` §A.3, Note 50 (Weyl complete reducibility) and Lemma 52.

`ChapterA3r` computed the ranks (traces) of the complete-reducibility projectors
`{projSym N, projAnti N, projMixed N}` in the base case `N = 2`, where the mixed
piece vanishes.  This file takes the next case `N = 3` — the **first** where the
symmetric and antisymmetric pieces no longer exhaust `V^{⊗3}` and the
mixed-symmetry summand is nonzero.

Each projector is idempotent, so its trace equals its rank (the dimension of the
summand).  For the `4`-dimensional Dirac spinor `V` (`dim V^{⊗3} = 4³ = 64`) the
counts are

  `dim Sym³V = 20`,   `dim Λ³V = 4`,   `dim(mixed) = 40`,   `20 + 4 + 40 = 64`.

Concretely `tr (projSym 3) = (3!)⁻¹ Σ_{σ∈S₃} tr(permMat σ)`, where by
`ChapterA3r.trace_permMat` each `tr(permMat σ)` counts the tuples fixed by `σ`,
i.e. `4^{(number of cycles of σ)}`:

* identity (`3` cycles): `4³ = 64`;
* the three transpositions (`2` cycles each): `4² = 16`;
* the two `3`-cycles (`1` cycle each): `4¹ = 4`.

So `Σ_σ tr(permMat σ) = 64 + 3·16 + 2·4 = 120` and `tr(projSym 3) = 120/6 = 20`,
while `Σ_σ sgn(σ)·tr(permMat σ) = 64 − 3·16 + 2·4 = 24` and
`tr(projAnti 3) = 24/6 = 4`.  The mixed piece is `64 − 20 − 4 = 40`.

Everything is proved **without** the `EXTERNAL` Weyl hypothesis, `sorry`-free /
`axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`).

## Deliverables

* `trace_projSym_three` — `tr (projSym 3) = 20` (`= dim Sym³V`).
* `trace_projAnti_three` — `tr (projAnti 3) = 4` (`= dim Λ³V`).
* `trace_projMixed_three` — `tr (projMixed 3) = 40` (the mixed-symmetry piece).
* `trace_decomposition_three` — `20 + 4 + 40 = 64 = dim (V ⊗ V ⊗ V)`.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3s

open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

/-- **Dimension of `Sym³V`.**  The symmetric-cube projector has rank `20`. -/
theorem trace_projSym_three : Matrix.trace (projSym 3) = 20 := by
  unfold projSym; norm_num;
  rw [ Finset.sum_congr rfl fun x _ => trace_permMat x ] ; norm_cast;
  field_simp;
  exact mod_cast by decide

/-- **Dimension of `Λ³V`.**  The antisymmetric-cube projector has rank `4`. -/
theorem trace_projAnti_three : Matrix.trace (projAnti 3) = 4 := by
  unfold projAnti;
  -- Expand the trace using linearity.
  simp only [signC, trace_smul, trace_sum, trace_permMat, smul_eq_mul];
  rw [ inv_mul_eq_div, div_eq_iff ] <;> norm_cast

/-- **Dimension of the mixed-symmetry piece at `N = 3`.**  Its projector has
rank `40 = 64 − 20 − 4`. -/
theorem trace_projMixed_three : Matrix.trace (projMixed 3) = 40 := by
  unfold projMixed; norm_num;
  rw [ trace_projSym_three, trace_projAnti_three ] ; norm_num

/-- **Dimension count of the complete-reducibility decomposition** at `N = 3`:
`dim Sym³V + dim Λ³V + dim(mixed) = 20 + 4 + 40 = 64 = dim (V ⊗ V ⊗ V)`. -/
theorem trace_decomposition_three :
    Matrix.trace (projSym 3) + Matrix.trace (projAnti 3)
        + Matrix.trace (projMixed 3) = 64 := by
  rw [trace_projSym_three, trace_projAnti_three, trace_projMixed_three]
  norm_num

end BookProof.ChapterA3s
