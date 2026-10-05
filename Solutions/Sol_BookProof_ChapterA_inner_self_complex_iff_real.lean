-- Generated from ChapterA1Prop5.lean — solution of BookProof.ChapterA.inner_self_complex_iff_real
import Mathlib
import Definitions.Def_ChapterA1Prop5
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace





attribute [local instance] InnerProductSpace.rclikeToReal

variable {H₁ H₂ : Type*} [NormedAddCommGroup H₁] [InnerProductSpace ℂ H₁]
  [NormedAddCommGroup H₂] [InnerProductSpace ℂ H₂]

variable {H₁ H₂ : Type*} [NormedAddCommGroup H₁] [InnerProductSpace ℂ H₁]
  [NormedAddCommGroup H₂] [InnerProductSpace ℂ H₂]

set_option maxHeartbeats 1000000 in
theorem solution (T : H₁ → H₂) :
    (∀ x, (inner ℂ (T x) (T x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (∀ x, (inner ℝ (T x) (T x) : ℝ) = (inner ℝ x x : ℝ)) := by

  constructor
  · intro h x
    rw [real_inner_eq_re_inner ℂ, real_inner_eq_re_inner ℂ, h]
  · intro h x
    have hr := h x
    rw [real_inner_eq_re_inner ℂ, real_inner_eq_re_inner ℂ] at hr
    apply RCLike.ext
    · exact hr
    · rw [inner_self_im, inner_self_im]
