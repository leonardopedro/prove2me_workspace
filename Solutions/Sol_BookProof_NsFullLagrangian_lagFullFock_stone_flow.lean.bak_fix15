-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.lagFullFock_stone_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_NsFullLagrangian_lagFockCore_dense
import Theorems.Thm_BookProof_NsFullLagrangian_lagFullFock_friedrichs_extension
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_positive
open BookProof.NsFullLagrangian




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) :
    ∃ (T : UnboundedSelfAdjoint lagFockSpace) (U : ℝ → (lagFockSpace →L[ℂ] lagFockSpace)),
      IsStoneFlow T U := by

  obtain ⟨Dom, A, hA⟩ := lagFullFock_friedrichs_extension lam lam' mu gg
  obtain ⟨T, U, _, _, hflow⟩ := exists_stone_flow_of_positive lagFockCore_dense hA
  exact ⟨T, U, hflow⟩
