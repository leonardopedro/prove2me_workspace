-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.norm_sq_le_quadForm_harm
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_norm_pgLp_sq
import Theorems.Thm_BookProof_GaussCoreQuadBounds_coreD_X_comm
import Theorems.Thm_BookProof_GaussCoreQuadBounds_quadForm_harm_eq
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    ((D : ℝ) / 2) * ‖pgLp p‖ ^ 2 ≤ quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ := by

  have hstep : ∀ j : Fin D, ‖pgLp p‖ ^ 2 / 2
      ≤ ‖pgLp (coreD j p)‖ ^ 2 + ‖pgLp (X j * p)‖ ^ 2 / 4 := by
    intro j
    have hid : cpoly p * p
        = cpoly p * coreD j (X j * p) - cpoly (X j * p) * coreD j p := by
      have h := coreD_X_comm j p
      have hc : cpoly (X j * p) = X j * cpoly p := by rw [cpoly_mul, cpoly_X]
      rw [hc]
      calc cpoly p * p = cpoly p * (coreD j (X j * p) - X j * coreD j p) := by rw [h]
        _ = cpoly p * coreD j (X j * p) - X j * cpoly p * coreD j p := by ring
    have h1 : gaussInt (cpoly p * coreD j (X j * p))
        = -(inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ) := by
      rw [inner_pgLp_pgLp, gaussInt_coreD j p (X j * p), neg_neg]
    have h2 : gaussInt (cpoly (X j * p) * coreD j p)
        = (inner ℂ (pgLp (X j * p)) (pgLp (coreD j p)) : ℂ) := (inner_pgLp_pgLp _ _).symm
    have hns : ‖pgLp p‖ ^ 2
        = -2 * (inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ).re := by
      rw [norm_pgLp_sq, hid, gaussInt_sub, h1, h2]
      have hswap : (inner ℂ (pgLp (X j * p)) (pgLp (coreD j p)) : ℂ).re
          = (inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ).re := by
        rw [← inner_conj_symm (𝕜 := ℂ) (pgLp (coreD j p)) (pgLp (X j * p)), Complex.conj_re]
      rw [Complex.sub_re, Complex.neg_re, hswap]
      ring
    have hcs : |(inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ).re|
        ≤ ‖pgLp (coreD j p)‖ * ‖pgLp (X j * p)‖ :=
      le_trans (Complex.abs_re_le_norm _) (by
        simpa using norm_inner_le_norm (𝕜 := ℂ) (pgLp (coreD j p)) (pgLp (X j * p)))
    have habs := abs_le.mp hcs
    nlinarith [sq_nonneg (‖pgLp (coreD j p)‖ - ‖pgLp (X j * p)‖ / 2),
      norm_nonneg (pgLp (coreD j p)), norm_nonneg (pgLp (X j * p))]
  rw [quadForm_harm_eq]
  have hsum : ∑ _j : Fin D, ‖pgLp p‖ ^ 2 / 2
      ≤ ∑ j : Fin D, (‖pgLp (coreD j p)‖ ^ 2 + ‖pgLp (X j * p)‖ ^ 2 / 4) :=
    Finset.sum_le_sum fun j _ => hstep j
  have hconst : ∑ _j : Fin D, ‖pgLp p‖ ^ 2 / 2 = ((D : ℝ) / 2) * ‖pgLp p‖ ^ 2 := by
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    ring
  rw [← hconst]
  exact hsum
