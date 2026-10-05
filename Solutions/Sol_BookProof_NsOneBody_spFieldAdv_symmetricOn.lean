-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spFieldAdv_symmetricOn
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_symmetricOn_zero
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
theorem solution (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    SymmetricOn D (D.subtype.comp (spFieldAdv Φ nu k r)) := by

  rw [spFieldAdv]
  split
  · exact spField_symmetricOn Φ nu k r
  · exact symmetricOn_zero
