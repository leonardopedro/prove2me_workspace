-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.misraGries_bound
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem BookProof.ChapterF4.misraGries_bound (k : ℕ) (hk : 0 < k) (xs : List ι) (x : ι) :
    (mgRun k xs).1 x ≤ xs.count x ∧
      xs.count x ≤ (mgRun k xs).1 x + xs.length / k := by sorry
