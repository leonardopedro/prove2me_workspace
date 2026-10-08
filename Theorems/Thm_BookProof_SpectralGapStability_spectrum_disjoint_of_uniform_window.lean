-- Generated from ChapterSpectralGapStability.lean — theorem BookProof.SpectralGapStability.spectrum_disjoint_of_uniform_window
import Mathlib
import Definitions.Def_ChapterSpectralGapStability
open BookProof.SpectralGapStability


noncomputable section


open scoped InnerProductSpace
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.SpectralGapStability.spectrum_disjoint_of_uniform_window {A : ℕ → F →L[ℂ] F} {B : F →L[ℂ] F}
    (hB : IsSelfAdjoint B) {a b : ℝ}
    (hgap : ∀ lam ∈ Set.Ioo a b, ∀ m, GapAt (A m) lam (min (lam - a) (b - lam)))
    (hconv : Tendsto (fun m => ‖A m - B‖) atTop (𝓝 0)) :
    ∀ lam ∈ Set.Ioo a b, (lam : ℂ) ∉ spectrum ℂ B := by sorry
