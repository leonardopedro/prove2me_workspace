-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.lambdaOf_mul
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lambdaOf_mul {S₁ S₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : IsPin S₁) (h2 : IsPin S₂) :
    LambdaOf (S₁ * S₂) = LambdaOf S₁ * LambdaOf S₂ := by sorry
