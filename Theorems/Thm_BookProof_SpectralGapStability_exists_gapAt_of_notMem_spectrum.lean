-- Generated from ChapterSpectralGapStability.lean — theorem BookProof.SpectralGapStability.exists_gapAt_of_notMem_spectrum
import Mathlib
import Definitions.Def_ChapterSpectralGapStability
open BookProof.SpectralGapStability


noncomputable section


open scoped InnerProductSpace
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.SpectralGapStability.exists_gapAt_of_notMem_spectrum {A : F →L[ℂ] F} {lam : ℝ}
    (h : (lam : ℂ) ∉ spectrum ℂ A) : ∃ d > 0, GapAt A lam d := by sorry
