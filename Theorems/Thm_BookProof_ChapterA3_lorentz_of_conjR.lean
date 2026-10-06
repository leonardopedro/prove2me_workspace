-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.lorentz_of_conjR
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lorentz_of_conjR (S : Matrix (Fin 4) (Fin 4) ℝ) (hS : IsUnit S.det)
    (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : HasLambda S Λ) :
    Λ * minkowskiMat * Λᵀ = minkowskiMat := by sorry
