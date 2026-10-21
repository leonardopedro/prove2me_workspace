-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.support_hopCol_subset
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
theorem solution (k : ℕ) : (hopCol k).support ⊆ {k + 1, k - 1} := by

  classical
  intro j hj
  have hne : (hopCol k) j ≠ 0 := Finsupp.mem_support_iff.mp hj
  rw [hopCol_apply] at hne
  by_cases h : j = k + 1 ∨ k = j + 1
  · rcases h with h | h
    · simp [h]
    · have : j = k - 1 := by omega
      simp [this]
  · rw [if_neg h] at hne
    exact absurd rfl hne
