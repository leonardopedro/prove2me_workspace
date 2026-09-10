-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.norm_weighted_kin_sq
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_norm_pgLp_sq
import Theorems.Thm_BookProof_GaussCoreQuadBounds_cpoly_real_smul
import Theorems.Thm_BookProof_GaussCoreQuadBounds_gaussInt_coreD_sq_pair
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin D → ℝ) (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (∑ j : Fin D, ((c j : ℝ) : ℂ) • coreD j (coreD j p))‖ ^ 2
      = ∑ j : Fin D, ∑ k : Fin D, c j * c k * ‖pgLp (coreD k (coreD j p))‖ ^ 2 := by

  have hexp : cpoly (∑ j : Fin D, ((c j : ℝ) : ℂ) • coreD j (coreD j p))
        * (∑ k : Fin D, ((c k : ℝ) : ℂ) • coreD k (coreD k p))
      = ∑ j : Fin D, ∑ k : Fin D, (((c j * c k : ℝ) : ℂ))
          • (cpoly (coreD j (coreD j p)) * coreD k (coreD k p)) := by
    rw [cpoly_sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [cpoly_real_smul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    simp only [MvPolynomial.smul_eq_C_mul, Complex.ofReal_mul, map_mul]
    ring
  rw [norm_pgLp_sq, hexp, gaussInt_sum]
  rw [Complex.re_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [gaussInt_sum, Complex.re_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [gaussInt_smul, gaussInt_coreD_sq_pair, ← Complex.ofReal_mul, Complex.ofReal_re]
