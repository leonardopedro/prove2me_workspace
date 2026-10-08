-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.deficiencyTrivialAt_of_diagonal
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}

theorem BookProof.HyperbolicQuadratic.deficiencyTrivialAt_of_diagonal (v : ι → E) (lam : ι → ℝ)
    (htot : ∀ w : E, (∀ i, (inner ℂ (v i) w : ℂ) = 0) → w = 0)
    {D : Submodule ℂ E} (T : D →ₗ[ℂ] E) (hmem : ∀ i, v i ∈ D)
    (hT : ∀ (i : ι) (h : v i ∈ D), T ⟨v i, h⟩ = ((lam i : ℝ) : ℂ) • v i)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt D T z := by sorry
