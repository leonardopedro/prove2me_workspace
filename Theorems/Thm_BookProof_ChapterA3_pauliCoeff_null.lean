-- Generated from ChapterA4d.lean — theorem BookProof.ChapterA3.pauliCoeff_null
import Mathlib
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.pauliCoeff_null (μ : Fin 4) :
    pauliCoeff (pauliσ 0 + pauliσ 3) μ =
      (if μ = 0 then 1 else 0) + (if μ = 3 then 1 else 0) := by sorry
