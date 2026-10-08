-- Generated from ChapterA1Prop5.lean — theorem BookProof.ChapterA.inner_self_complex_iff_real
import Mathlib
import Definitions.Def_ChapterA1Prop5
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace





attribute [local instance] InnerProductSpace.rclikeToReal

variable {H₁ H₂ : Type*} [NormedAddCommGroup H₁] [InnerProductSpace ℂ H₁]
  [NormedAddCommGroup H₂] [InnerProductSpace ℂ H₂]


theorem BookProof.ChapterA.inner_self_complex_iff_real (T : H₁ → H₂) :
    (∀ x, (inner ℂ (T x) (T x) : ℂ) = (inner ℂ x x : ℂ)) ↔
    (∀ x, (inner ℝ (T x) (T x) : ℝ) = (inner ℝ x x : ℝ)) := by sorry
