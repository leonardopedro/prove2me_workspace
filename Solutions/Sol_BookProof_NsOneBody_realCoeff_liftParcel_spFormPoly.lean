-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.realCoeff_liftParcel_spFormPoly
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_redFormPoly_eq_liftParcel
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}
variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    RealCoeff (liftParcel p (spFormPoly nu k r) : MvPolynomial (Fin (n * 6)) ℂ) := by

  rw [← redFormPoly_eq_liftParcel]
  exact realCoeff_redFormPoly nu k n p r
