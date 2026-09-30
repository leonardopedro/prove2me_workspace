-- Generated from ChapterGradedBandSchurEsa.lean — theorem BookProof.GradedBandSchur.wCol_of_gradedBand
import Mathlib
import Definitions.Def_ChapterGradedBandSchurEsa
open BookProof.GradedBandSchur








open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

theorem BookProof.GradedBandSchur.wCol_of_gradedBand (hC : 0 ≤ C) (hherm : IsHermCol col)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    WColBound (degW deg) col (C * M) := by sorry
