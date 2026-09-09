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
summands at `N = 4`

Source: `book.tex` §A.3, Note 50 (Weyl complete reducibility) and Lemma 52.

`ChapterA3r` computed the ranks (traces) of the complete-reducibility projectors
`{projSym N, projAnti N, projMixed N}` at `N = 2`, and `ChapterA3s` did `N = 3`
(the first case with a nonzero mixed piece).  This file takes the next case
`N = 4`.

Each projector is idempotent, so its trace equals its rank (the dimension of the
summand).  For the `4`-dimensional Dirac spinor `V` (`dim V^{⊗4} = 4⁴ = 256`) the
counts are

  `dim Sym⁴V = 35`,   `dim Λ⁴V = 1`,   `dim(mixed) = 220`,   `35 + 1 + 220 = 256`.

Concretely `tr (projSym 4) = (4!)⁻¹ Σ_{σ∈S₄} tr(permMat σ)`, where by
`ChapterA3r.trace_permMat` each `tr(permMat σ)` counts the tuples fixed by `σ`,
i.e. `4^{(number of cycles of σ)}`.  By cycle type in `S₄`:

* identity (`4` cycles): `4⁴ = 256`;
* the six transpositions (`3` cycles each): `4³ = 64`;
* the eight `3`-cycles (`2` cycles each): `4² = 16`;
* the three `(2,2)` double transpositions (`2` cycles each): `4² = 16`;
* the six `4`-cycles (`1` cycle each): `4¹ = 4`.

So `Σ_σ tr(permMat σ) = 256 + 6·64 + 8·16 + 3·16 + 6·4 = 840` and
`tr(projSym 4) = 840/24 = 35 = C(7,4)`, while the signed sum is
`256 − 6·64 + 8·16 + 3·16 − 6·4 = 24` and `tr(projAnti 4) = 24/24 = 1 = C(4,4)`.
The mixed piece is `256 − 35 − 1 = 220`.

Everything is proved **without** the `EXTERNAL` Weyl hypothesis, `sorry`-free /
`axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`).

## Deliverables

* `trace_projSym_four` — `tr (projSym 4) = 35` (`= dim Sym⁴V`).
* `trace_projAnti_four` — `tr (projAnti 4) = 1` (`= dim Λ⁴V`).
* `trace_projMixed_four` — `tr (projMixed 4) = 220` (the mixed-symmetry piece).
* `trace_decomposition_four` — `35 + 1 + 220 = 256 = dim (V ⊗ V ⊗ V ⊗ V)`.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3t

open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxRecDepth 10000 in
/-- **Dimension of `Sym⁴V`.**  The symmetric-fourth-power projector has rank `35`. -/
theorem trace_projSym_four : Matrix.trace (projSym 4) = 35 := by
  unfold projSym; norm_num;
  rw [ Finset.sum_congr rfl fun x _ => trace_permMat x ] ; norm_cast;
  field_simp;
  exact mod_cast by decide

set_option maxRecDepth 10000 in
/-- **Dimension of `Λ⁴V`.**  The antisymmetric-fourth-power projector has rank `1`. -/
theorem trace_projAnti_four : Matrix.trace (projAnti 4) = 1 := by
  unfold projAnti;
  simp only [signC, trace_smul, trace_sum, trace_permMat, smul_eq_mul];
  rw [ inv_mul_eq_div, div_eq_iff ] <;> norm_cast

/-- **Dimension of the mixed-symmetry piece at `N = 4`.**  Its projector has
rank `220 = 256 − 35 − 1`. -/
theorem trace_projMixed_four : Matrix.trace (projMixed 4) = 220 := by
  unfold projMixed; norm_num;
  rw [ trace_projSym_four, trace_projAnti_four ] ; norm_num

/-- **Dimension count of the complete-reducibility decomposition** at `N = 4`:
`dim Sym⁴V + dim Λ⁴V + dim(mixed) = 35 + 1 + 220 = 256 = dim (V ⊗ V ⊗ V ⊗ V)`. -/
theorem trace_decomposition_four :
    Matrix.trace (projSym 4) + Matrix.trace (projAnti 4)
        + Matrix.trace (projMixed 4) = 256 := by
  rw [trace_projSym_four, trace_projAnti_four, trace_projMixed_four]
  norm_num

end BookProof.ChapterA3t
