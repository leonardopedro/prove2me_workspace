-- Generated from ChapterSpectralGapStability.lean — theorem BookProof.SpectralGapStability.gapAt_perturb
import Mathlib
import Definitions.Def_ChapterSpectralGapStability
open BookProof.SpectralGapStability

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open scoped InnerProductSpace
open Filter Topology


theorem BookProof.SpectralGapStability.gapAt_perturb {A B : F →L[ℂ] F} {lam d eps : ℝ}
    (h : GapAt A lam d) (hAB : ‖A - B‖ ≤ eps) : GapAt B lam (d - eps) := by sorry
