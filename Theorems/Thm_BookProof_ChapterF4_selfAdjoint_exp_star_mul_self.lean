-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.selfAdjoint_exp_star_mul_self
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]

theorem BookProof.ChapterF4.selfAdjoint_exp_star_mul_self (h : selfAdjoint A) :
    star ((selfAdjoint.expUnitary h : A)) * (selfAdjoint.expUnitary h : A) = 1 := by sorry
