-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.re_inner_sum_of_diagonal
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative









open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}

theorem BookProof.HermiteRelative.re_inner_sum_of_diagonal (v : ι → E) (hv : Orthonormal ℂ v) (lam : ι → ℝ)
    {D : Submodule ℂ E} (hvD : ∀ a, v a ∈ D) (T : D →ₗ[ℂ] E)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = ((lam a : ℝ) : ℂ) • v a)
    (s : Finset ι) (f : ι → ℂ) (hu : (∑ a ∈ s, f a • v a) ∈ D) :
    (inner ℂ (∑ a ∈ s, f a • v a) (T ⟨∑ a ∈ s, f a • v a, hu⟩) : ℂ).re
      = ∑ a ∈ s, lam a * ‖f a‖ ^ 2 := by sorry
