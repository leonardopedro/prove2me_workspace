-- Generated from ChapterBrstReducedTransfer.lean — theorem BookProof.BrstReducedTransfer.infDist_exactStates_stoneU_eq
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.BrstReducedTransfer

variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]
variable (Om : H →L[ℂ] H)
variable {Om}
variable (Om)
variable (U : ℝ → (H →L[ℂ] H)) (hcomm : ∀ (t : ℝ) (y : H), U t (Om y) = Om (U t y))
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) (Om : H →L[ℂ] H)
variable (hcomm : ∀ (t : ℝ) (y : H), T.stoneU t (Om y) = Om (T.stoneU t y))



open BookProof BookProof.ChapterStoneResolvent




theorem BookProof.BrstReducedTransfer.infDist_exactStates_stoneU_eq (t : ℝ) (x : H) :
    Metric.infDist (T.stoneU t x) (exactStates Om) = Metric.infDist x (exactStates Om) := by sorry
