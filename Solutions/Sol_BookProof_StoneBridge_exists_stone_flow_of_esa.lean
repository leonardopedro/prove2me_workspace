-- Generated from ChapterStoneBridge.lean — solution of BookProof.StoneBridge.exists_stone_flow_of_esa
import Mathlib
import Definitions.Def_ChapterStoneBridge
import Theorems.Thm_BookProof_StoneBridge_isStoneFlow_stoneU
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
open BookProof.StoneBridge







open Filter Topology
open scoped InnerProductSpace


open BookProof.FarisLavine BookProof.EsaClosure BookProof.YangMillsFriedrichs
open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]










variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} (Hc : D →ₗ[ℂ] F)
    (hdense : Dense ((D : Submodule ℂ F) : Set F)) (hsym : SymmetricOn D Hc)
    (hesa : EssentiallySelfAdjointOn D Hc) :
    ∃ (T : UnboundedSelfAdjoint F) (U : ℝ → (F →L[ℂ] F)),
      IsSelfAdjointExtension Hc T.op ∧ IsStoneFlow T U := by

  obtain ⟨Dom, A, hA⟩ := exists_isSelfAdjointExtension_of_esa Hc hdense hsym hesa
  exact ⟨unboundedSelfAdjointOf hdense hA, _, hA,
    isStoneFlow_stoneU (unboundedSelfAdjointOf hdense hA)⟩
