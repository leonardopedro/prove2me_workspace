-- Generated from ChapterA4d.lean — theorem BookProof.ChapterA3.massless_little_group
import Mathlib
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.massless_little_group :
    {T : Matrix (Fin 2) (Fin 2) ℂ | T.det = 1 ∧ FixesNullAxis (Upsilon T)} = SEtwo := by sorry
