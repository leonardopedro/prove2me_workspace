-- Generated from ChapterA4c.lean — theorem BookProof.ChapterA3.pauliCoeff_one
import Mathlib
import Definitions.Def_ChapterA4c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.pauliCoeff_one (μ : Fin 4) :
    pauliCoeff (1 : Matrix (Fin 2) (Fin 2) ℂ) μ = if μ = 0 then 1 else 0 := by sorry
