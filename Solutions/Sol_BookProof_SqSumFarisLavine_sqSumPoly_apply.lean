-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.sqSumPoly_apply
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterFarisLavine
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (kappa : Fin D → ℝ) (v : R → Fin D → ℝ)
    (p : MvPolynomial (Fin D) ℂ) :
    sqSumPoly kappa v p = kinPart kappa p + potPoly v * p := by

  have hmom : ∀ (j : Fin D) (q : MvPolynomial (Fin D) ℂ),
      YangMillsHermite.momOp j q = (-Complex.I) • coreD j q := by
    intro j q
    have hc : coreD j q = pderiv j q - ((1 / 2 : ℝ) : ℂ) • (X j * q) := by
      rw [coreD, MvPolynomial.smul_eq_C_mul]
      norm_num
    rw [YangMillsHermite.momOp_apply, hc]
  have hsq : ∀ j : Fin D, YangMillsHermite.momOp j (YangMillsHermite.momOp j p)
      = -(coreD j (coreD j p)) := by
    intro j
    rw [hmom, hmom, coreD_smul, smul_smul]
    rw [show (-Complex.I) * (-Complex.I) = (-1 : ℂ) by
      rw [neg_mul_neg, Complex.I_mul_I]]
    rw [neg_one_smul]
  have hlhs : sqSumPoly kappa v p
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j : Fin D, ((kappa j : ℝ) : ℂ)
              • YangMillsHermite.momOp j (YangMillsHermite.momOp j p))
            + ∑ r : R, linForm (v r) * (linForm (v r) * p)) := by
    simp [sqSumPoly]
  rw [hlhs, kinPart, potPoly, smul_add]
  congr 1
  · rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [hsq j, smul_smul, smul_neg, ← neg_smul]
    congr 1
    push_cast
    ring
  · rw [Finset.smul_sum, smul_mul_assoc, Finset.sum_mul, Finset.smul_sum]
    exact Finset.sum_congr rfl fun r _ => by rw [mul_assoc]
