-- Generated from ChapterA1.lean — solution of BookProof.ChapterA.conjugation_smul_I_of_neg
import Mathlib
import Definitions.Def_ChapterA1
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) {y : V} (hy : θ y = -y) :
    θ (Complex.I • y) = Complex.I • y := by

  convert θ.map_smulₛₗ ( Complex.I : ℂ ) y using 1
  simp [ hy ]
