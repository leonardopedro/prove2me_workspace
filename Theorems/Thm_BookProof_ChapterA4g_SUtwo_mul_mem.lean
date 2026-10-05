-- Generated from ChapterA4g.lean — theorem BookProof.ChapterA4g.SUtwo_mul_mem
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA4g
import Definitions.Def_ChapterA4c
open BookProof.ChapterA4g


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

theorem BookProof.ChapterA4g.SUtwo_mul_mem {S T : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SUtwo) (hT : T ∈ SUtwo) : S * T ∈ SUtwo := by sorry
