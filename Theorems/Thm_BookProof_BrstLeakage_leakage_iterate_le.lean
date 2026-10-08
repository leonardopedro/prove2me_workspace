-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.leakage_iterate_le
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.leakage_iterate_le {H Om : E →L[ℂ] E} {B : ℕ → E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : ∀ i, IsSelfAdjoint (B i)) (hcomm : Commute H Om) (τ : ℝ) (hτ : 0 ≤ τ) (x : E)
    (K : ℝ) (hK : ∀ i, ‖H - B i‖ ≤ K) :
    ∀ n : ℕ, ‖Om (leakageIter B τ x n)‖ ≤ ‖Om x‖ + n * (‖Om‖ * (K * ‖x‖ * τ))
  | 0 => by simp
  | n + 1 => by
      have hxn : ‖leakageIter B τ x n‖ = ‖x‖ := by sorry
