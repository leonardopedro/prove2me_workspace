-- Generated from ChapterGradedBandSchurEsa.lean — solution of BookProof.GradedBandSchur.degW_ge_one
import Mathlib
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.GradedBandSchur




open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

set_option maxHeartbeats 1000000 in

theorem solution (deg : ℕ → ℕ) (k : ℕ) : 1 ≤ degW deg k := by
  simp only [degW]
  have : (0:ℝ) ≤ (deg k : ℝ) := Nat.cast_nonneg _
  linarith
