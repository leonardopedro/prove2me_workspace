-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.redPiN_parcel
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
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
    redPiN n (finProdFinEquiv (p, i)) = parcelPi n p i := by

  simp only [redPiN, parcelPi, Equiv.symm_apply_apply, redIdx]
