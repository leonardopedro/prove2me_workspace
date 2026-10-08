-- Generated from ChapterGradedBandSchurEsa.lean — theorem BookProof.GradedBandSchur.wComm_of_gradedBand
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterGradedBandSchurEsa
open BookProof.GradedBandSchur



open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}


theorem BookProof.GradedBandSchur.wComm_of_gradedBand (hC : 0 ≤ C)
    (hcard : ∀ k, (col k).support.card ≤ M)
    (hband : ∀ k, ∀ j ∈ (col k).support, ((deg j : ℤ) - (deg k : ℤ)).natAbs ≤ D)
    (hent : ∀ k j, ‖(col k) j‖ ≤ C * ((deg k : ℝ) + 1)) :
    WCommBound (degW deg) col (C * M * D * (D + 2)) := by sorry
