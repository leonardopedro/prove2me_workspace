-- Generated from ChapterGradedBandSchurEsa.lean — theorem BookProof.GradedBandSchur.wRow_of_gradedBand
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterGradedBandSchurEsa
open BookProof.GradedBandSchur

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}



open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section


theorem BookProof.GradedBandSchur.wRow_of_gradedBand (hC : 0 ≤ C)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    WRowBound (degW deg) col (C * M) := by sorry
