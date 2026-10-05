-- Generated from ChapterHermiteLadderShift.lean — theorem BookProof.HermiteLadder.norm_shift_le_of_diagonal
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterHermiteLadderShift
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QgHermiteOscillator
open BookProof.HyperbolicQuadratic

noncomputable section

theorem BookProof.HermiteLadder.norm_shift_le_of_diagonal (v : ι → E) (hv : Orthonormal ℂ v) {D : Submodule ℂ E}
    (hD : Submodule.span ℂ (Set.range v) = D)
    (T : D →ₗ[ℂ] E) (σ : ι → ι) (s : ι → ℂ)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = s a • v (σ a))
    (hinj : ∀ a b : ι, s a ≠ 0 → s b ≠ 0 → σ a = σ b → a = b)
    (N : D →ₗ[ℂ] E) (w : ι → ℝ) (hw : ∀ a, 0 ≤ w a)
    (hN : ∀ (a : ι) (h : v a ∈ D), N ⟨v a, h⟩ = ((w a : ℝ) : ℂ) • v a)
    (K : ℝ) (hK : 0 ≤ K) (hs : ∀ a, ‖s a‖ ≤ K * (w a + 1)) (u : D) :
    ‖T u‖ ≤ K * ‖N u + (u : E)‖ := by sorry
