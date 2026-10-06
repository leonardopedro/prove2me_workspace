-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.lambda_two_to_one
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lambda_two_to_one (hpf : PauliFundamental)
    {S S' : Matrix (Fin 4) (Fin 4) ℝ} (hS : IsPin S) (hS' : IsPin S')
    (h : LambdaOf S = LambdaOf S') : S' = S ∨ S' = -S := by sorry
