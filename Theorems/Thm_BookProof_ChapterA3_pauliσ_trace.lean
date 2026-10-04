-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.pauliσ_trace
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.pauliσ_trace (μ ν : Fin 4) :
    (pauliσ μ * pauliσ ν).trace = if μ = ν then 2 else 0 := by sorry
