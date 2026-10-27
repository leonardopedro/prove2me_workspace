-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullFock_stone_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_nsFockCore_dense
import Theorems.Thm_BookProof_NsFullEuler_nsFullFock_friedrichs_extension
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_positive
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) :
    ∃ (T : UnboundedSelfAdjoint nsFockSpace) (U : ℝ → (nsFockSpace →L[ℂ] nsFockSpace)),
      IsStoneFlow T U := by

  obtain ⟨Dom, A, hA⟩ := nsFullFock_friedrichs_extension nu lam mu gg
  obtain ⟨T, U, _, _, hflow⟩ := exists_stone_flow_of_positive nsFockCore_dense hA
  exact ⟨T, U, hflow⟩
