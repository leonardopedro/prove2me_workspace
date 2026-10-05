-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.realCommutes_neg
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S) :
    RealCommutes M (-S) := by

  intro m hm x
  simp only [ContinuousLinearMap.neg_apply, map_neg, hS m hm x]
