-- Generated from ChapterBrstUnboundedLeakage.lean — solution of BookProof.BrstUnboundedLeakage.flow_truncGen_mem_domain
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Theorems.Thm_BookProof_BrstUnboundedLeakage_flow_truncGen_mem
open BookProof.BrstUnboundedLeakage



open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) {x : H} (hx : x ∈ V) :
    flow (truncGen T V hV) t x ∈ T.domain := hV (flow_truncGen_mem T V hV t hx)
