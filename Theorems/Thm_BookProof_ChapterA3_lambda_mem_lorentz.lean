-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.lambda_mem_lorentz
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lambda_mem_lorentz (S : Matrix (Fin 4) (Fin 4) ℝ) (hS : IsPin S) :
    LambdaOf S ∈ LorentzO := by sorry
