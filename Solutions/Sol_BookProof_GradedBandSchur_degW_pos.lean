-- Generated from ChapterGradedBandSchurEsa.lean — solution of BookProof.GradedBandSchur.degW_pos
import Mathlib
import Definitions.Def_ChapterGradedBandSchurEsa
import Theorems.Thm_BookProof_GradedBandSchur_degW_ge_one
open BookProof.GradedBandSchur









open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (deg : ℕ → ℕ) (k : ℕ) : 0 < degW deg k := lt_of_lt_of_le zero_lt_one (degW_ge_one deg k)
