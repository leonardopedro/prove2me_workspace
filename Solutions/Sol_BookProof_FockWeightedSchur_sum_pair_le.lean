-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.sum_pair_le
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {f : ℕ → ℝ} {S : Finset ℕ} {a b : ℕ} {C : ℝ} (hS : S ⊆ {a, b})
    (hf : ∀ j, 0 ≤ f j) (hC : ∀ j, f j ≤ C) (hC0 : 0 ≤ C) : ∑ j ∈ S, f j ≤ 2 * C := by

  classical
  have hcard : ((({a, b} : Finset ℕ)).card : ℝ) ≤ 2 := by
    have : (({a, b} : Finset ℕ)).card ≤ 2 := (Finset.card_insert_le _ _).trans (by simp)
    exact_mod_cast this
  calc ∑ j ∈ S, f j ≤ ∑ j ∈ ({a, b} : Finset ℕ), f j :=
        Finset.sum_le_sum_of_subset_of_nonneg hS fun j _ _ => hf j
    _ ≤ ∑ _j ∈ ({a, b} : Finset ℕ), C := Finset.sum_le_sum fun j _ => hC j
    _ ≤ 2 * C := by
        simp only [Finset.sum_const, nsmul_eq_mul]
        nlinarith [hC0, hcard]
