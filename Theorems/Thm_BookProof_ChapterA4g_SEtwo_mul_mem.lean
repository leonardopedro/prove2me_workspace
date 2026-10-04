-- Generated from ChapterA4g.lean — theorem BookProof.ChapterA4g.SEtwo_mul_mem
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA4g
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA4
open BookProof.ChapterA4g


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

theorem BookProof.ChapterA4g.SEtwo_mul_mem {S T : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SEtwo) (hT : T ∈ SEtwo) : S * T ∈ SEtwo := by sorry
