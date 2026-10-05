-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.sign_pair_expectation
import Mathlib
import Definitions.Def_ChapterF4
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct
open BookProof.ChapterF4

variable {d k : ℕ}


open scoped BigOperators Matrix

theorem BookProof.ChapterF4.sign_pair_expectation (c c' : Fin d) :
    (∑ ω : Fin d → Bool, sgn (ω c) * sgn (ω c')) = if c = c' then (2 ^ d : ℝ) else 0 := by sorry
