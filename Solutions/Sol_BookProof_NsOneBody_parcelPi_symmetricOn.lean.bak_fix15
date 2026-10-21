-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.parcelPi_symmetricOn
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_momOp_polySym
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
theorem solution (n : ℕ) (p : Fin n) (i : Fin 6) :
    SymmetricOn (polyGaussCore (d := n * 6))
      ((polyGaussCore (d := n * 6)).subtype.comp (parcelPi n p i)) := (coreRepPoly (n * 6)).symmetricOn_op (momOp_polySym _)
