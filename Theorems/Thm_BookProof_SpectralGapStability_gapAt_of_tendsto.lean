-- Generated from ChapterSpectralGapStability.lean — theorem BookProof.SpectralGapStability.gapAt_of_tendsto
import Mathlib
import Definitions.Def_ChapterSpectralGapStability
open BookProof.SpectralGapStability


noncomputable section


open scoped InnerProductSpace
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.SpectralGapStability.gapAt_of_tendsto {A : ℕ → F →L[ℂ] F} {B : F →L[ℂ] F} {lam d : ℝ}
    (hA : ∀ m, GapAt (A m) lam d)
    (hconv : Tendsto (fun m => ‖A m - B‖) atTop (𝓝 0)) : GapAt B lam d := by sorry
