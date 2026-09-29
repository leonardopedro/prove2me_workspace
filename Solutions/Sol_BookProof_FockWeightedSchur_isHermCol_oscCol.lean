-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.isHermCol_oscCol
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
theorem solution : IsHermCol oscCol := by

  intro j k
  rw [oscCol_apply, oscCol_apply]
  by_cases h1 : k = j + 1
  · have h2 : ¬(j = k + 1) := by omega
    rw [if_pos h1, if_neg h2, if_pos h1, Complex.conj_ofReal]
    have : ((k : ℝ)) = (j : ℝ) + 1 := by rw [h1]; push_cast; ring
    rw [this]
  · by_cases h2 : j = k + 1
    · rw [if_neg h1, if_pos h2, if_pos h2, Complex.conj_ofReal]
      have : ((j : ℝ)) = (k : ℝ) + 1 := by rw [h2]; push_cast; ring
      rw [this]
    · rw [if_neg h1, if_neg h2, if_neg h1, if_neg h2]
      simp
