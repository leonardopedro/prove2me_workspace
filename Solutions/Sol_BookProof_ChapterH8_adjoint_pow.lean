-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.adjoint_pow
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
open ContinuousLinearMap in
theorem solution (A : F →L[ℂ] F) (k : ℕ) : adjoint (A ^ k) = (adjoint A) ^ k := by

  simp [← ContinuousLinearMap.star_eq_adjoint, star_pow]
