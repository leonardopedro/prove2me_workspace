-- Generated from ChapterStoneBridge.lean — theorem BookProof.StoneBridge.exists_stone_flow_of_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.EsaClosure
open BookProof.StoneBridge

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]


open Filter Topology
open scoped InnerProductSpace


open BookProof.FarisLavine BookProof.EsaClosure BookProof.YangMillsFriedrichs
open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent


theorem BookProof.StoneBridge.exists_stone_flow_of_esa {D : Submodule ℂ F} (Hc : D →ₗ[ℂ] F)
    (hdense : Dense ((D : Submodule ℂ F) : Set F)) (hsym : SymmetricOn D Hc)
    (hesa : EssentiallySelfAdjointOn D Hc) :
    ∃ (T : UnboundedSelfAdjoint F) (U : ℝ → ( := by sorry
