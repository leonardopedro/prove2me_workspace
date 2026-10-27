-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spHam_quadForm_split
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_spHam_eq_visc_add_advect
import Theorems.Thm_BookProof_NsOneBody_quadForm_add
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
theorem solution (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    quadForm (spHam Φ nu k) x = quadForm (spVisc Φ nu k) x + quadForm (spAdvect Φ nu k) x := by

  rw [spHam_eq_visc_add_advect, quadForm_add]
