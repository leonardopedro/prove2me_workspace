-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.redFormPoly_eq_liftParcel
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsFullEuler_redAdvectPoly_eq_liftParcel
import Theorems.Thm_BookProof_NsFullEuler_redMomentumPoly_eq_liftParcel
import Theorems.Thm_BookProof_NsFullEuler_redVisc_eq_liftParcel
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (r : Fin 7) :
    redFormPoly nu k n p r = liftParcel p (spFormPoly nu k r) := by

  rw [redFormPoly, spFormPoly]
  split
  · exact redVisc_eq_liftParcel nu k n p _
  · split
    · exact redAdvectPoly_eq_liftParcel k n p _
    · exact redMomentumPoly_eq_liftParcel k n p
