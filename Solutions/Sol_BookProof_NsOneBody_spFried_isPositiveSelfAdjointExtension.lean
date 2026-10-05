-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spFried_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_polyGaussCore_le_spFriedDom
import Theorems.Thm_BookProof_NsOneBody_spFried_op_core
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
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
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    IsPositiveSelfAdjointExtension (spHam (coreRepPoly 6) nu k) (spFried nu k).op :=
  (spFried nu k).isPositiveSelfAdjointExtension (spHam (coreRepPoly 6) nu k)
      (fun x => ⟨polyGaussCore_le_spFriedDom nu k x.2, spFried_op_core nu k x _⟩)
