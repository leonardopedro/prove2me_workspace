-- Generated from ChapterSpectralGapStability.lean — theorem BookProof.SpectralGapStability.notMem_spectrum_of_gapAt
import Mathlib
import Definitions.Def_ChapterSpectralGapStability
open BookProof.SpectralGapStability

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open scoped InnerProductSpace
open Filter Topology


theorem BookProof.SpectralGapStability.notMem_spectrum_of_gapAt {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {lam d : ℝ}
    (hd : 0 < d) (h : GapAt A lam d) : (lam : ℂ) ∉ spectrum ℂ A := by sorry
