-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.mean_add_const
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterTotalVariance
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) (x : Fin d → ℝ) (c : ℝ) :
    mean (fun i => x i + c) = mean x + c := by

  have hd' : (d : ℝ) ≠ 0 := by positivity
  simp only [mean, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  field_simp
