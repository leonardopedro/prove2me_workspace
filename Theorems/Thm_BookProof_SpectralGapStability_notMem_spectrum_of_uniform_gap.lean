-- Generated from ChapterSpectralGapStability.lean — theorem BookProof.SpectralGapStability.notMem_spectrum_of_uniform_gap
import Mathlib
import Definitions.Def_ChapterSpectralGapStability
open BookProof.SpectralGapStability


noncomputable section


open scoped InnerProductSpace
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.SpectralGapStability.notMem_spectrum_of_uniform_gap {A : ℕ → F →L[ℂ] F} {B : F →L[ℂ] F}
    (hB : IsSelfAdjoint B) {lam d : ℝ} (hd : 0 < d) (hgap : ∀ m, GapAt (A m) lam d)
    (hconv : Tendsto (fun m => ‖A m - B‖) atTop (𝓝 0)) : (lam : ℂ) ∉ spectrum ℂ B := by sorry
