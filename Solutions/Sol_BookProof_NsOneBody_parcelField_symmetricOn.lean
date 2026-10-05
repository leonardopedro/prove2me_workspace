-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.parcelField_symmetricOn
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_realCoeff_liftParcel_spFormPoly
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
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
    SymmetricOn (polyGaussCore (d := n * 6))
      ((polyGaussCore (d := n * 6)).subtype.comp (parcelField nu k n p r)) := (coreRepPoly (n * 6)).symmetricOn_op (mulOp_polySym (realCoeff_liftParcel_spFormPoly nu k n p r))
