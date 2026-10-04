-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.pauliCoeff_comb
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.pauliCoeff_comb (c : Fin 4 → ℂ) (μ : Fin 4) :
    pauliCoeff (∑ ν, c ν • pauliσ ν) μ = c μ := by sorry
