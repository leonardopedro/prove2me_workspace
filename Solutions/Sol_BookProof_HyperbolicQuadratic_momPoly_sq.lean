-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.momPoly_sq
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_momPoly_apply'
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i (momPoly i p)
      = -(pderiv i (pderiv i p)) + (1/2 : ℂ) • p + X i * pderiv i p
        - (1/4 : ℂ) • (X i * (X i * p)) := by

  have hlei : ∀ q : MvPolynomial (Fin d) ℂ, pderiv i (X i * q) = q + X i * pderiv i q := by
    intro q
    rw [Derivation.leibniz, pderiv_X_self]
    simp [smul_eq_mul]
    ring
  set q : MvPolynomial (Fin d) ℂ := pderiv i p - (1/2 : ℂ) • (X i * p) with hq
  have h1 : momPoly i p = (-Complex.I) • q := momPoly_apply' i p
  have h2 : momPoly i ((-Complex.I) • q) = (-Complex.I) • (momPoly i q) := map_smul _ _ _
  have h3 : momPoly i q = (-Complex.I) • (pderiv i q - (1/2 : ℂ) • (X i * q)) :=
    momPoly_apply' i q
  have hdq : pderiv i q = pderiv i (pderiv i p) - (1/2 : ℂ) • (p + X i * pderiv i p) := by
    rw [hq, map_sub, Derivation.map_smul_of_tower, hlei]
  have hxq : X i * q = X i * pderiv i p - (1/2 : ℂ) • (X i * (X i * p)) := by
    rw [hq, mul_sub, mul_smul_comm]
  have hinner : pderiv i q - (1/2 : ℂ) • (X i * q)
      = pderiv i (pderiv i p) - (1/2 : ℂ) • p - X i * pderiv i p
        + (1/4 : ℂ) • (X i * (X i * p)) := by
    rw [hdq, hxq]
    module
  have hII : (-Complex.I) * (-Complex.I) = (-1 : ℂ) := by simp [Complex.I_mul_I]
  rw [h1, h2, h3, hinner, smul_smul, hII]
  module
