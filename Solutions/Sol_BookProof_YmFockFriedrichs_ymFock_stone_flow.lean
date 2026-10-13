-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFock_stone_flow
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFockCore_dense
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFock_friedrichs_extension
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_positive
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.StoneBridge
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint ymFockSpace) (U : ℝ → (ymFockSpace →L[ℂ] ymFockSpace)),
      IsStoneFlow T U := by

  obtain ⟨Dom, A, hA⟩ := ymFock_friedrichs_extension fabc
  obtain ⟨T, U, _, _, hflow⟩ := exists_stone_flow_of_positive ymFockCore_dense hA
  exact ⟨T, U, hflow⟩
