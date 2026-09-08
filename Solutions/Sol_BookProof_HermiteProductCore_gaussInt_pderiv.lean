-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussInt_pderiv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_smul
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_sum
import Theorems.Thm_BookProof_HermiteProductCore_gaussMoment_succ
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_monomial
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin d) (r : MvPolynomial (Fin d) ℂ) :
    gaussInt (pderiv j r) = gaussInt (X j * r) := by

  classical
  have hmono : ∀ a : Fin d →₀ ℕ,
      gaussInt (pderiv j (monomial a (1 : ℂ))) = gaussInt (X j * monomial a (1 : ℂ)) := by
    intro a
    have hL : pderiv j (monomial a (1 : ℂ))
        = ((a j : ℂ)) • monomial (a - Finsupp.single j 1) 1 := by
      rw [MvPolynomial.pderiv_monomial, one_mul]
      rw [MvPolynomial.smul_monomial, smul_eq_mul, mul_one]
    have hR : (X j : MvPolynomial (Fin d) ℂ) * monomial a 1
        = monomial (a + Finsupp.single j 1) 1 := by
      rw [X, monomial_mul]
      simp [add_comm]
    rw [hL, hR, gaussInt_smul, gaussInt_monomial, gaussInt_monomial]
    have hsplit : ∀ b : Fin d →₀ ℕ, ∏ i, ((gaussMoment (b i) : ℝ) : ℂ)
        = ((gaussMoment (b j) : ℝ) : ℂ)
          * ∏ i ∈ Finset.univ.erase j, ((gaussMoment (b i) : ℝ) : ℂ) := by
      intro b
      rw [← Finset.mul_prod_erase _ _ (Finset.mem_univ j)]
    have hprod_eq : ∏ i ∈ Finset.univ.erase j,
          ((gaussMoment ((a - Finsupp.single j 1 : Fin d →₀ ℕ) i) : ℝ) : ℂ)
        = ∏ i ∈ Finset.univ.erase j,
          ((gaussMoment ((a + Finsupp.single j 1 : Fin d →₀ ℕ) i) : ℝ) : ℂ) := by
      refine Finset.prod_congr rfl fun i hi => ?_
      have hij : i ≠ j := Finset.ne_of_mem_erase hi
      have h1 : ((a - Finsupp.single j 1 : Fin d →₀ ℕ) i) = a i := by
        simp [Finsupp.tsub_apply, hij]
      have h2 : ((a + Finsupp.single j 1 : Fin d →₀ ℕ) i) = a i := by
        simp [hij]
      rw [h1, h2]
    rw [hsplit (a - Finsupp.single j 1), hsplit (a + Finsupp.single j 1), hprod_eq]
    have hj1 : ((a - Finsupp.single j 1 : Fin d →₀ ℕ) j) = a j - 1 := by
      simp [Finsupp.tsub_apply]
    have hj2 : ((a + Finsupp.single j 1 : Fin d →₀ ℕ) j) = a j + 1 := by simp
    rw [hj1, hj2, gaussMoment_succ]
    push_cast
    ring
  have hsum : r = ∑ v ∈ r.support, (MvPolynomial.coeff v r) • monomial v (1 : ℂ) := by
    nth_rewrite 1 [← MvPolynomial.support_sum_monomial_coeff r]
    exact Finset.sum_congr rfl fun v _ => by
      rw [MvPolynomial.smul_monomial, smul_eq_mul, mul_one]
  rw [hsum]
  rw [map_sum, Finset.mul_sum, gaussInt_sum, gaussInt_sum]
  refine Finset.sum_congr rfl fun v _ => ?_
  rw [Derivation.map_smul, gaussInt_smul, mul_smul_comm, gaussInt_smul, hmono v]
