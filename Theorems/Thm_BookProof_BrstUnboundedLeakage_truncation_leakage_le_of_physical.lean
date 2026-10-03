-- Generated from ChapterBrstUnboundedLeakage.lean — theorem BookProof.BrstUnboundedLeakage.truncation_leakage_le_of_physical
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Definitions.Def_ChapterBrstTruncationLeakage
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4
open BookProof.BrstLeakage

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)


open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent


theorem BookProof.BrstUnboundedLeakage.truncation_leakage_le_of_physical {Om : H →L[ℂ] H}
    (hcomm : ∀ (s : ℝ) (y : H), Om (T.stoneU s y) = T.stoneU s (Om y))
    (t : ℝ) (ht : 0 ≤ t) {x : H} (hx : x ∈ V) (hOm : Om x = 0) :
    ‖Om (flow (truncGen T V hV) t x)‖ ≤ ‖Om‖ * (‖truncDefect T V hV‖ * ‖x‖ * t) := by sorry
