-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.leakage_le_of_physical
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.leakage_le_of_physical {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hcomm : Commute H Om) (t : ℝ) (ht : 0 ≤ t) {x : E} (hx : Om x = 0) (K : ℝ)
    (hK : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖(H - B) (flow B s x)‖ ≤ K) :
    ‖Om (flow B t x)‖ ≤ ‖Om‖ * (K * t) := by sorry
