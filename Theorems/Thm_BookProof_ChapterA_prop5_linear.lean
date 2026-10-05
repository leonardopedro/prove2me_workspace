-- Generated from ChapterA1Prop5.lean — theorem BookProof.ChapterA.prop5_linear
import Mathlib
import Definitions.Def_ChapterA1Prop5
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {H₁ H₂ : Type*} [NormedAddCommGroup H₁] [InnerProductSpace ℂ H₁]
  [NormedAddCommGroup H₂] [InnerProductSpace ℂ H₂]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace





attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.prop5_linear (U : H₁ →ₗ[ℂ] H₂) :
    (Function.Surjective U ∧ ∀ x, (inner ℂ (U x) (U x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (Function.Surjective U ∧ ∀ x, (inner ℝ (U x) (U x) : ℝ) = (inner ℝ x x : ℝ)) := by sorry
