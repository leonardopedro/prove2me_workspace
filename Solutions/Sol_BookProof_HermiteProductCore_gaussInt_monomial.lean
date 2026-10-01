-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussInt_monomial
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_integral_prod_coord
import Theorems.Thm_BookProof_HermiteProductCore_gaussWD_eq_prod
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
Moment (k + 1) = (k : ℝ) * gaussMoment (k - 1) := by
  have h := gint_ibp ((Polynomial.X : Polynomial ℝ) ^ k) 1
  rw [Polynomial.derivative_X_pow, mul_one, Polynomial.derivative_one, sub_zero, mul_one] at h
  r :=
  w [gint_C_mul] at h
    rw [gaussMoment, gaussMoment, h, pow_succ]
  
  /-- The Gaussian integral of a monomial factorizes into one-dimensional moments. -/
  theorem gaussInt_monomial (a : Fin d →₀ ℕ) :
      gaussInt (monomial a (1 : ℂ)) = ∏ i, ((gaussMoment (a i) : ℝ) : ℂ) := by
    have hpt : ∀ x : Vd d,
        MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (monomial a (1 : ℂ)) * (gaussWD x : ℂ)
          = ∏ i, (((x i) ^ (a i) * Real.exp (-(x i) ^ 2 / 2) : ℝ) : ℂ) := by
      intro x
      rw [MvPolynomial.eval_monomial, one_mul, gaussWD_eq_prod,
        Finsupp.prod_of_support_subset a (Finset.subset_univ _) _ (fun i _ => by simp)]
      push_cast
      rw [← Finset.prod_mul_distrib]
    rw [gaussInt]
    simp_rw [hpt]
    rw [integra
