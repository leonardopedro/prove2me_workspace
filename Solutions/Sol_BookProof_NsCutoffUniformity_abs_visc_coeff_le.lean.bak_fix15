-- Generated from ChapterNsCutoffUniformity.lean — solution of BookProof.NsCutoffUniformity.abs_visc_coeff_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity




open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {n : ℕ}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {nu Λ : ℝ} {k : Fin 3 → ℝ} (hΛ : 0 ≤ Λ) (hk : ∀ j, |k j| ≤ Λ) :
    |nu * ∑ j : Fin 3, (k j) ^ 2| ≤ 3 * |nu| * Λ ^ 2 := by

  have hsum : ∑ j : Fin 3, (k j) ^ 2 ≤ 3 * Λ ^ 2 := by
    have hbound : ∀ j : Fin 3, (k j) ^ 2 ≤ Λ ^ 2 := by
      intro j
      have := hk j
      nlinarith [abs_nonneg (k j), sq_abs (k j)]
    calc ∑ j : Fin 3, (k j) ^ 2 ≤ ∑ _j : Fin 3, Λ ^ 2 := Finset.sum_le_sum fun j _ => hbound j
      _ = 3 * Λ ^ 2 := by simp [Finset.sum_const]
  have hnonneg : 0 ≤ ∑ j : Fin 3, (k j) ^ 2 := Finset.sum_nonneg fun j _ => sq_nonneg _
  rw [abs_mul, abs_of_nonneg hnonneg]
  calc |nu| * ∑ j : Fin 3, (k j) ^ 2 ≤ |nu| * (3 * Λ ^ 2) := by
        exact mul_le_mul_of_nonneg_left hsum (abs_nonneg nu)
    _ = 3 * |nu| * Λ ^ 2 := by ring
