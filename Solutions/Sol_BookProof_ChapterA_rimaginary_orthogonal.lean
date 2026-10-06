-- Generated from ChapterA1.lean — solution of BookProof.ChapterA.rimaginary_orthogonal
import Mathlib
import Definitions.Def_ChapterA1
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (J : W ≃ₗᵢ[ℝ] W) (hJ : ∀ x, J (J x) = -x) (x : W) :
    inner ℝ (J x) x = 0 := by

  have := J.inner_map_map ( J x ) x; simp_all [ inner_neg_left ] ;
  linarith [ real_inner_comm x ( J x ) ]
