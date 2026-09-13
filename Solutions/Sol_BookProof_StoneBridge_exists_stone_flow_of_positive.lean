-- Generated from ChapterStoneBridge.lean — solution of BookProof.StoneBridge.exists_stone_flow_of_positive
import Mathlib
import Definitions.Def_ChapterStoneBridge
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_selfAdjointExtension
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
theorem solution {D Dom : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (hdense : Dense ((D : Submodule ℂ F) : Set F))
    (h : IsPositiveSelfAdjointExtension Hc A) :
    ∃ (T : UnboundedSelfAdjoint F) (U : ℝ → (F →L[ℂ] F)),
      T.domain = Dom ∧ HEq T.op A ∧ IsStoneFlow T U := exists_stone_flow_of_selfAdjointExtension hdense (isSelfAdjointExtension_of_positive h)
