-- Generated from ChapterStoneBridge.lean — solution of BookProof.StoneBridge.isStoneFlow_stoneU
import Mathlib
import Definitions.Def_ChapterStoneBridge
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
theorem solution (T : UnboundedSelfAdjoint F) : IsStoneFlow T T.stoneU := by

  refine ⟨T.stoneU_zero, ?_, ?_, ?_⟩
  · intro s t
    exact T.stoneU_add s t
  · intro t x
    exact T.norm_stoneU_apply t x
  · intro x hx t
    exact ⟨T.stoneU_mem_domain t ⟨x, hx⟩, T.hasDerivAt_stoneU_op ⟨x, hx⟩ t⟩
