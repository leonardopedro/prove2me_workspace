-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.countsketch_unbiased
import Mathlib
import Definitions.Def_ChapterF4
import Definitions.Def_ChapterObservableOperator
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterObservableOperator
open BookProof.ChapterScaledDotProduct
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}

theorem BookProof.ChapterF4.countsketch_unbiased (h : Fin d → Fin k) (x y : Fin d → ℝ) :
    expectation (fun ω => ∑ j, csketch h ω x j * csketch h ω y j) = ∑ c, x c * y c := by sorry
