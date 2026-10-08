-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.csketch_add
import Mathlib
import Definitions.Def_ChapterF4
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}

theorem BookProof.ChapterF4.csketch_add (h : Fin d → Fin k) (ω : Fin d → Bool) (x y : Fin d → ℝ) :
    csketch h ω (x + y) = csketch h ω x + csketch h ω y := by sorry
