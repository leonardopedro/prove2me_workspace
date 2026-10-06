-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.leakageIter_succ
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (B : ℕ → E →L[ℂ] E) (τ : ℝ) (x : E) (n : ℕ) :
    leakageIter B τ x (n + 1) = flow (B n) τ (leakageIter B τ x n) := rfl
