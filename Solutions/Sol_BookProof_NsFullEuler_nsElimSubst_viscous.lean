-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsElimSubst_viscous
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_nsElimHom_C
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    nsElimHom k n (C (((-nu : ℝ)) : ℂ) * X (ycoord p (wIdx i)))
      = liftParcel p (C (((nu * ∑ j : Fin 3, (k j) ^ 2 : ℝ)) : ℂ) * X (ruIdx6 i)) := by

  have hcoef : (C (((-nu : ℝ)) : ℂ) : MvPolynomial (Fin (n * 6)) ℂ)
      * (-C (((∑ j : Fin 3, (k j) ^ 2 : ℝ)) : ℂ))
      = C (((nu * ∑ j : Fin 3, (k j) ^ 2 : ℝ)) : ℂ) := by
    rw [Complex.ofReal_neg, Complex.ofReal_mul, map_neg, map_mul]
    ring
  rw [map_mul, nsElimHom_C, nsElimHom_X_w, map_mul, liftParcel_C, liftParcel_X, ruIdx,
    ← mul_assoc, hcoef]
