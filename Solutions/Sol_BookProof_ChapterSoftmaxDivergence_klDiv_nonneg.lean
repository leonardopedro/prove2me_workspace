-- Generated from ChapterSoftmaxDivergence.lean — solution of BookProof.ChapterSoftmaxDivergence.klDiv_nonneg
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
import Theorems.Thm_BookProof_ChapterSoftmaxDivergence_klDiv_eq_crossEntropy_sub_shannonEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_shannonEntropy_le_crossEntropy
open BookProof.ChapterSoftmaxDivergence



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p q : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hpsum : ∑ j, p j = 1)
    (hq0 : ∀ j, 0 < q j) (hqsum : ∑ j, q j ≤ 1) : 0 ≤ klDiv p q := by

  have := shannonEntropy_le_crossEntropy hp0 hpsum hq0 hqsum
  rw [klDiv_eq_crossEntropy_sub_shannonEntropy hq0]
  linarith
