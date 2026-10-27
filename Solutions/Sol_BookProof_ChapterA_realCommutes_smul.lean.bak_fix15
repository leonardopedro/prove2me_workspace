-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.realCommutes_smul
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S)
    (r : ℝ) : RealCommutes M (r • S) := by

  intro m hm x
  simp only [ContinuousLinearMap.smul_apply]
  rw [hS m hm x]
  exact (ContinuousLinearMap.map_smul_of_tower m r (S x)).symm
