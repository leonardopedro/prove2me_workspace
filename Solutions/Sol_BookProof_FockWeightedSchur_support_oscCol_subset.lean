-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.support_oscCol_subset
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
theorem solution (k : ℕ) : (oscCol k).support ⊆ {k + 1, k - 1} := by

  classical
  intro j hj
  have hne : (oscCol k) j ≠ 0 := Finsupp.mem_support_iff.mp hj
  rw [oscCol_apply] at hne
  by_cases h1 : j = k + 1
  · simp [h1]
  · by_cases h2 : k = j + 1
    · have : j = k - 1 := by omega
      simp [this]
    · rw [if_neg h1, if_neg h2] at hne
      exact absurd rfl hne
