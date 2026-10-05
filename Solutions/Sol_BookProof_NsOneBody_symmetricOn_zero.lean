-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.symmetricOn_zero
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

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn D (D.subtype.comp (0 : D →ₗ[ℂ] D)) := by

  intro x y
  simp
