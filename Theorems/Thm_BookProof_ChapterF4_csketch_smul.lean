-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.csketch_smul
import Mathlib
import Definitions.Def_ChapterF4
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct
open BookProof.ChapterF4

variable {d k : ℕ}


open scoped BigOperators Matrix

theorem BookProof.ChapterF4.csketch_smul (h : Fin d → Fin k) (ω : Fin d → Bool) (a : ℝ) (x : Fin d → ℝ) :
    csketch h ω (a • x) = a • csketch h ω x := by sorry
