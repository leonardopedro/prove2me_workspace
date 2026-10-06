-- Generated from ChapterA1.lean — solution of BookProof.ChapterA.conjugation_avg_antifixed
import Mathlib
import Definitions.Def_ChapterA1
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = x) (x : V) :
    θ ((2⁻¹ : ℂ) • (x - θ x)) = -((2⁻¹ : ℂ) • (x - θ x)) := by

  have key : θ ( x - θ x ) = - ( x - θ x ) := by
    have := θ.map_sub x ( θ x ) ; simp_all [ sub_eq_add_neg ]
  convert congr_arg ( fun y => ( 2⁻¹ : ℂ ) • y ) key using 1;
  · convert θ.map_smulₛₗ ( 2⁻¹ : ℂ ) ( x - θ x ) using 1;
    erw [ Complex.conj_inv, Complex.conj_ofReal ] ; norm_num;
  · rw [ smul_neg ]
