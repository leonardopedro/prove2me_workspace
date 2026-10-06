-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.lambda_surjective
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lambda_surjective (hpf : PauliFundamental)
    (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : Λ ∈ LorentzO) :
    ∃ S : Matrix (Fin 4) (Fin 4) ℝ, IsPin S ∧ LambdaOf S = Λ := by sorry
