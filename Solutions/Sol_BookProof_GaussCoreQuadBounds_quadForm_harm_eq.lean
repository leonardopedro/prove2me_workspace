-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.quadForm_harm_eq
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_norm_pgLp_sq
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterFarisLavine
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩
      = ∑ j : Fin D, (‖pgLp (coreD j p)‖ ^ 2 + ‖pgLp (X j * p)‖ ^ 2 / 4) := by

  have hharm : cpoly p * (harmPoly * p)
      = ∑ j : Fin D, ((1 / 4 : ℂ)) • (cpoly (X j * p) * (X j * p)) := by
    rw [harmPoly, Finset.sum_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [cpoly_mul, cpoly_X, MvPolynomial.smul_eq_C_mul]
    ring
  have hkey : gaussInt (cpoly p * (kinPoly p + harmPoly * p))
      = (∑ j : Fin D, gaussInt (cpoly (coreD j p) * coreD j p))
        + ∑ j : Fin D, (1 / 4 : ℂ) * gaussInt (cpoly (X j * p) * (X j * p)) := by
    rw [mul_add, gaussInt_add, gaussInt_kinPoly, hharm, gaussInt_sum]
    congr 1
    exact Finset.sum_congr rfl fun j _ => gaussInt_smul _ _
  rw [quadForm, harmCore_pgLp, inner_pgLp_pgLp, hkey]
  rw [Complex.add_re, Complex.re_sum, Complex.re_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [norm_pgLp_sq, norm_pgLp_sq]
  simp [Complex.mul_re]
  ring
