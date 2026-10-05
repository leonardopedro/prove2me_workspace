-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.realCommutes_mulI
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) : RealCommutes M (mulI : V →L[ℝ] V) := by

  intro m _ x
  simp only [mulI_apply]
  rw [map_smul]
