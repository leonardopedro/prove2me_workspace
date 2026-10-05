-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spHam_stone_flow
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_spHam_esa_farisLavine
import Theorems.Thm_BookProof_NsOneBody_spFried_dom_dense
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
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
    ∃ (T : UnboundedSelfAdjoint (L2d 6)) (U : ℝ → (L2d 6 →L[ℂ] L2d 6)),
      IsSelfAdjointExtension (spFried nu k).op T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (spFried_dom_dense nu k) (spFried nu k).sym
      (spHam_esa_farisLavine nu k)
