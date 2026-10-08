-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.mgRun_support_le
import Mathlib
import Definitions.Def_ChapterF4
import Definitions.Def_ChapterF6
open BookProof.ChapterF6
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem BookProof.ChapterF4.mgRun_support_le (k : ℕ) (xs : List ι) :
    mgSupport (mgRun k xs).1 ≤ k := by sorry
