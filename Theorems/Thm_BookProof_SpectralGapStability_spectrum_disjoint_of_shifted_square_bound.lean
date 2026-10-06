-- Generated from ChapterSpectralGapStability.lean — theorem BookProof.SpectralGapStability.spectrum_disjoint_of_shifted_square_bound
import Mathlib
import Definitions.Def_ChapterSpectralGapStability
open BookProof.SpectralGapStability

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open scoped InnerProductSpace
open Filter Topology


theorem BookProof.SpectralGapStability.spectrum_disjoint_of_shifted_square_bound {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {c q : ℝ} (hq : 0 < q)
    (hbound : ∀ x : F, q * ‖x‖ ^ 2 ≤ ‖(A - (c : ℂ) • (1 : F →L[ℂ] F)) x‖ ^ 2) :
    ∀ lam ∈ Set.Ioo (c - Real.sqrt q) (c + Real.sqrt q),
      (lam : ℂ) ∉ spectrum ℂ A := by sorry
