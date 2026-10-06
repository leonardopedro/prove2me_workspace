-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.negMulLog_sub_le
import Mathlib
import Definitions.Def_ChapterMaxEntropy
open BookProof.ChapterMaxEntropy

variable {α : Type*} [Fintype α]


open Real BigOperators Finset



theorem BookProof.ChapterMaxEntropy.negMulLog_sub_le (n : ℕ) (hn : 0 < n) {x : ℝ} (hx : 0 ≤ x) :
    Real.negMulLog x - x * Real.log n ≤ (n : ℝ)⁻¹ - x := by sorry
