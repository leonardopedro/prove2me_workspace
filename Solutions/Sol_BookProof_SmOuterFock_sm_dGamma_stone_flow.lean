-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.sm_dGamma_stone_flow
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_SmOuterFock_smFockCore_dense
import Theorems.Thm_BookProof_SmOuterFock_sm_dGamma_friedrichs_extension
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_positive
open BookProof.SmOuterFock




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) :
    ∃ (T : UnboundedSelfAdjoint smFockSpace) (U : ℝ → (smFockSpace →L[ℂ] smFockSpace)),
      IsStoneFlow T U := by

  obtain ⟨Dom, A, hA⟩ := sm_dGamma_friedrichs_extension P
  obtain ⟨T, U, _, _, hflow⟩ := exists_stone_flow_of_positive smFockCore_dense hA
  exact ⟨T, U, hflow⟩
