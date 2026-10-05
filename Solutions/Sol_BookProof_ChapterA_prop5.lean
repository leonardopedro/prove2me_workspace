-- Generated from ChapterA1Prop5.lean — solution of BookProof.ChapterA.prop5
import Mathlib
import Definitions.Def_ChapterA1Prop5
import Theorems.Thm_BookProof_ChapterA_inner_self_complex_iff_real
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace





attribute [local instance] InnerProductSpace.rclikeToReal

variable {H₁ H₂ : Type*} [NormedAddCommGroup H₁] [InnerProductSpace ℂ H₁]
  [NormedAddCommGroup H₂] [InnerProductSpace ℂ H₂]

variable {H₁ H₂ : Type*} [NormedAddCommGroup H₁] [InnerProductSpace ℂ H₁]
  [NormedAddCommGroup H₂] [InnerProductSpace ℂ H₂]

set_option maxHeartbeats 1000000 in
theorem solution (U : H₁ → H₂) :
    (Function.Surjective U ∧ ∀ x, (inner ℂ (U x) (U x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (Function.Surjective U ∧ ∀ x, (inner ℝ (U x) (U x) : ℝ) = (inner ℝ x x : ℝ)) := and_congr Iff.rfl (inner_self_complex_iff_real U)
