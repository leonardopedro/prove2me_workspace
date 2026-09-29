-- Generated from ChapterGradedBandSchurEsa.lean — solution of BookProof.GradedBandSchur.wCol_of_gradedBand
import Mathlib
import Definitions.Def_ChapterGradedBandSchurEsa
import Theorems.Thm_BookProof_GradedBandSchur_degW_pos
open BookProof.GradedBandSchur









open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hC : 0 ≤ C) (hherm : IsHermCol col)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    WColBound (degW deg) col (C * M) := by

  intro j
  have hterm : ∀ k ∈ (col j).support, ‖(col j) k‖ / degW deg k ≤ C := by
    intro k _
    have hsym : ‖(col j) k‖ = ‖(col k) j‖ := by rw [hherm j k]; simp
    have hk : ‖(col k) j‖ ≤ C * degW deg k := by
      simpa [degW] using hent k j
    rw [hsym, div_le_iff₀ (degW_pos deg k)]
    linarith
  calc ∑ k ∈ (col j).support, ‖(col j) k‖ / degW deg k
      ≤ (col j).support.card • C := Finset.sum_le_card_nsmul _ _ _ hterm
    _ = (col j).support.card * C := by rw [nsmul_eq_mul]
    _ ≤ M * C := mul_le_mul_of_nonneg_right (by exact_mod_cast hcard j) hC
    _ = C * M := by ring
