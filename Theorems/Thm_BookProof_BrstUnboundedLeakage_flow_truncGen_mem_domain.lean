-- Generated from ChapterBrstUnboundedLeakage.lean — theorem BookProof.BrstUnboundedLeakage.flow_truncGen_mem_domain
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Definitions.Def_ChapterBrstTruncationLeakage
import Definitions.Def_ChapterStoneResolvent
open BookProof.BrstLeakage
open BookProof.BrstUnboundedLeakage

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)


open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent


theorem BookProof.BrstUnboundedLeakage.flow_truncGen_mem_domain (t : ℝ) {x : H} (hx : x ∈ V) :
    flow (truncGen T V hV) t x ∈ T.domain := by sorry
