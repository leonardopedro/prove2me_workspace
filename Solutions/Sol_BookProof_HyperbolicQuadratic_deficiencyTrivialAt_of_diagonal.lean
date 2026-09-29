import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.deficiencyTrivialAt_of_diagonal
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (v : ι → E) (lam : ι → ℝ)
    (htot : ∀ w : E, (∀ i, (inner ℂ (v i) w : ℂ) = 0) → w = 0)
    {D : Submodule ℂ E} (T : D →ₗ[ℂ] E) (hmem : ∀ i, v i ∈ D)
    (hT : ∀ (i : ι) (h : v i ∈ D), T ⟨v i, h⟩ = ((lam i : ℝ) : ℂ) • v i)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt D T z := by

  intro w hw
  refine htot w fun i => ?_
  have h := hw ⟨v i, hmem i⟩
  rw [hT i (hmem i), inner_smul_left, Complex.conj_ofReal] at h
  have hne : ((lam i : ℝ) : ℂ) - z ≠ 0 := by
    intro hc
    have hzi : z = ((lam i : ℝ) : ℂ) := by linear_combination -hc
    rw [hzi] at hz
    simp at hz
  have hprod : (((lam i : ℝ) : ℂ) - z) * (inner ℂ (v i) w : ℂ) = 0 := by linear_combination h
  exact (mul_eq_zero.mp hprod).resolve_left hne
