-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spAdvect_symmetricOn
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_spFieldAdv_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn
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
theorem solution (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    SymmetricOn D (spAdvect Φ nu k) := weylOpDom_symmetricOn (fun i => i.elim0) (spFieldAdv_symmetricOn Φ nu k)
