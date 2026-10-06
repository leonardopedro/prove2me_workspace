-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.norm_oscCol_apply
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_oscCol_apply
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (k j : ℕ) : ‖(oscCol k) j‖ =
    if j = k + 1 then Real.sqrt ((k : ℝ) + 1)
    else if k = j + 1 then Real.sqrt (k : ℝ) else 0 := by

  rw [oscCol_apply]
  by_cases h1 : j = k + 1
  · rw [if_pos h1, if_pos h1, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (Real.sqrt_nonneg _)]
  · by_cases h2 : k = j + 1
    · rw [if_neg h1, if_pos h2, if_neg h1, if_pos h2, Complex.norm_real, Real.norm_eq_abs,
        abs_of_nonneg (Real.sqrt_nonneg _)]
    · rw [if_neg h1, if_neg h2, if_neg h1, if_neg h2, norm_zero]
