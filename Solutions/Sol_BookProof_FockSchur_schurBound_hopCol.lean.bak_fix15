-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.schurBound_hopCol
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_hopCol_apply
import Theorems.Thm_BookProof_FockSchur_support_hopCol_subset
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution : SchurBound hopCol 2 := by

  classical
  intro k
  have hle : ∀ j, ‖(hopCol k) j‖ ≤ 1 := by
    intro j
    rw [hopCol_apply]
    by_cases h : j = k + 1 ∨ k = j + 1 <;> simp [h]
  calc ∑ j ∈ (hopCol k).support, ‖(hopCol k) j‖
      ≤ ∑ j ∈ ({k + 1, k - 1} : Finset ℕ), ‖(hopCol k) j‖ :=
        Finset.sum_le_sum_of_subset_of_nonneg (support_hopCol_subset k)
          (fun j _ _ => norm_nonneg _)
    _ ≤ ∑ _j ∈ ({k + 1, k - 1} : Finset ℕ), (1:ℝ) := Finset.sum_le_sum fun j _ => hle j
    _ ≤ 2 := by
        simp only [Finset.sum_const, nsmul_eq_mul, mul_one]
        have : (({k + 1, k - 1} : Finset ℕ)).card ≤ 2 := Finset.card_insert_le _ _ |>.trans
          (by simp)
        exact_mod_cast this
