-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.mgRun_sum
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

theorem BookProof.ChapterF4.mgRun_sum (k : ℕ) (xs : List ι) :
    (∑ a, (mgRun k xs).1 a) + (k + 1) * (mgRun k xs).2 = xs.length := by sorry
