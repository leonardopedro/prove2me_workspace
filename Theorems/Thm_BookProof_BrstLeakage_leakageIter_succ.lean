-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.leakageIter_succ
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.leakageIter_succ (B : ℕ → E →L[ℂ] E) (τ : ℝ) (x : E) (n : ℕ) :
    leakageIter B τ x (n + 1) = flow (B n) τ (leakageIter B τ x n) := by sorry
