-- Generated from ChapterHermiteLadderShift.lean — theorem BookProof.HermiteLadder.apply_sum_of_shift
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

theorem BookProof.HermiteLadder.apply_sum_of_shift (v : ι → E) (σ : ι → ι) (s : ι → ℂ) {D : Submodule ℂ E}
    (hvD : ∀ a, v a ∈ D) (T : D →ₗ[ℂ] E)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = s a • v (σ a))
    (S : Finset ι) (f : ι → ℂ) :
    ∀ hu : (∑ a ∈ S, f a • v a) ∈ D,
      T ⟨∑ a ∈ S, f a • v a, hu⟩ = ∑ a ∈ S, (f a * s a) • v (σ a) := by sorry
