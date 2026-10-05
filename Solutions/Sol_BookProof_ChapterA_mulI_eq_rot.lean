-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.mulI_eq_rot
import Mathlib
import Definitions.Def_ChapterA2e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary H) : (mulI : H →L[ℝ] H) = rot θ Complex.I 0 := by

  ext w; simp
