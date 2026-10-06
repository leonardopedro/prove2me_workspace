-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.lambdaOf_neg
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lambdaOf_neg {S : Matrix (Fin 4) (Fin 4) ℝ} (h : IsPin S) :
    LambdaOf (-S) = LambdaOf S := by sorry
