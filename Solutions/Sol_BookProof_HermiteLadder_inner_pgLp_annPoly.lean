-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.inner_pgLp_annPoly
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_annPoly_eq_coreD
import Theorems.Thm_BookProof_HermiteLadder_crePoly_eq_coreD
import Theorems.Thm_BookProof_HermiteLadder_gaussInt_sub_prime
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_add
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_C
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_X
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_mul
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_sub
import Theorems.Thm_BookProof_QgHermiteFriedrichs_gaussInt_coreD
import Theorems.Thm_BookProof_QgHermiteFriedrichs_inner_pgLp_pgLp
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp q) (pgLp (annPoly i p)) : ℂ) = inner ℂ (pgLp (crePoly i q)) (pgLp p) := by

  rw [inner_pgLp_pgLp, inner_pgLp_pgLp, annPoly_eq_coreD, crePoly_eq_coreD, mul_add,
    gaussInt_add, cpoly_sub, sub_mul, gaussInt_sub_prime]
  have h1 : gaussInt (cpoly q * coreD i p) = -gaussInt (cpoly (coreD i q) * p) := by
    rw [gaussInt_coreD, neg_neg]
  have hhalf : (starRingEnd ℂ) (1 / 2 : ℂ) = 1 / 2 := by norm_num [Complex.ext_iff]
  have h2 : cpoly q * (C (1 / 2 : ℂ) * (X i * p)) = cpoly (C (1 / 2 : ℂ) * (X i * q)) * p := by
    simp only [cpoly_mul, cpoly_C, cpoly_X, hhalf]
    ring
  rw [h1, h2]
  ring
