-- Generated from ChapterBrstUnboundedLeakage.lean — theorem BookProof.BrstUnboundedLeakage.opProj_apply_of_mem
import Definitions.Def_ChapterBrstTruncationLeakage
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)


open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent


theorem BookProof.BrstUnboundedLeakage.opProj_apply_of_mem {x : H} (hx : x ∈ V) :
    opProj T V hV x = T.op ⟨x, hV hx⟩ := by sorry
