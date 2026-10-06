-- Generated from ChapterA1.lean — solution of BookProof.ChapterA.conjugation_decomp
import Mathlib
import Definitions.Def_ChapterA1
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) (x : V) :
    x = (2⁻¹ : ℂ) • (x + θ x) + (2⁻¹ : ℂ) • (x - θ x) := by

  rw [ ← smul_add, add_comm ];
  simp [ ← two_smul ℂ ]
