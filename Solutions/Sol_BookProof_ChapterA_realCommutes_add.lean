-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.realCommutes_add
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {S T : V →L[ℝ] V}
    (hS : RealCommutes M S) (hT : RealCommutes M T) : RealCommutes M (S + T) := by

  intro m hm x
  simp only [ContinuousLinearMap.add_apply, map_add, hS m hm x, hT m hm x]
