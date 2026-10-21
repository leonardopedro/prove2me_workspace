-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.scoreSoftmax_layerNorm_ge
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_abs_inner_layerNorm_le
import Theorems.Thm_BookProof_ChapterAttentionRetrieval_scoreSoftmax_ge_of_spread
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {beta : ℝ} (hb : 0 ≤ beta) (hd : 0 < d)
    {q : Fin d → ℝ} {k : Fin m → (Fin d → ℝ)} (hq : 0 < variance q)
    (hk : ∀ j, 0 < variance (k j)) (j : Fin m) :
    Real.exp (-(beta * (2 * d))) / (m : ℝ)
      ≤ scoreSoftmax beta (fun l => ∑ i, layerNorm q i * layerNorm (k l) i) j := by

  refine scoreSoftmax_ge_of_spread hb _ j fun l => ?_
  have h1 := abs_inner_layerNorm_le hd hq (hk l)
  have h2 := abs_inner_layerNorm_le hd hq (hk j)
  have h1' := abs_le.mp h1
  have h2' := abs_le.mp h2
  linarith [h1'.2, h2'.1]
