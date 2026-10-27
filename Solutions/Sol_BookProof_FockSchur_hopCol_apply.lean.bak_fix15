-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.hopCol_apply
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (k j : ℕ) : (hopCol k) j = if j = k + 1 ∨ k = j + 1 then 1 else 0 := by

  classical
  rcases Nat.eq_zero_or_pos k with hk | hk
  · subst hk
    have hcond : (j = 0 + 1 ∨ 0 = j + 1) ↔ (1 = j) := by omega
    rw [hopCol, if_pos rfl, Finsupp.single_apply, if_congr hcond rfl rfl]
  · have hcond : (j = k + 1 ∨ k = j + 1) ↔ (k + 1 = j ∨ k - 1 = j) := by omega
    rw [hopCol, if_neg (by omega), Finsupp.add_apply, Finsupp.single_apply,
      Finsupp.single_apply, if_congr hcond rfl rfl]
    by_cases h1 : k + 1 = j
    · have h2 : ¬ (k - 1 = j) := by omega
      simp [h1, h2]
    · by_cases h2 : k - 1 = j
      · simp [h1, h2]
      · simp [h1, h2]
