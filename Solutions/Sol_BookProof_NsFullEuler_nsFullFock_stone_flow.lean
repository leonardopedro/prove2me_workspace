-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullFock_stone_flow
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_nsFockCore_dense
import Theorems.Thm_BookProof_NsFullEuler_nsFullFock_friedrichs_extension
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_positive
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.StoneBridge
open BookProof.YangMillsFriedrichs

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) :
    ∃ (T : UnboundedSelfAdjoint nsFockSpace) (U : ℝ → (nsFockSpace →L[ℂ] nsFockSpace)),
      IsStoneFlow T U := by

  obtain ⟨Dom, A, hA⟩ := nsFullFock_friedrichs_extension nu lam mu gg
  obtain ⟨T, U, _, _, hflow⟩ := exists_stone_flow_of_positive nsFockCore_dense hA
  exact ⟨T, U, hflow⟩
