-- Generated from ChapterBrstUnboundedLeakage.lean — theorem BookProof.BrstUnboundedLeakage.norm_omega_stoneU_eq
import Definitions.Def_ChapterBrstTruncationLeakage
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent


theorem BookProof.BrstUnboundedLeakage.norm_omega_stoneU_eq {Om : H →L[ℂ] H}
    (hcomm : ∀ (s : ℝ) (y : H), Om (T.stoneU s y) = T.stoneU s (Om y)) (t : ℝ) (x : H) :
    ‖Om (T.stoneU t x)‖ = ‖Om x‖ := by sorry
