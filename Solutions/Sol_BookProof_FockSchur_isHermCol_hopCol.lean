-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.isHermCol_hopCol
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_hopCol_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution : IsHermCol hopCol := by

  intro j k
  rw [hopCol_apply, hopCol_apply]
  by_cases h : k = j + 1 ∨ j = k + 1
  · have h' : j = k + 1 ∨ k = j + 1 := h.symm
    simp [h, h']
  · have h' : ¬ (j = k + 1 ∨ k = j + 1) := fun hc => h hc.symm
    simp [h, h']
