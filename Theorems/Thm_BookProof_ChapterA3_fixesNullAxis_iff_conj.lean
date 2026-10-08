-- Generated from ChapterA4d.lean — theorem BookProof.ChapterA3.fixesNullAxis_iff_conj
import Mathlib
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.fixesNullAxis_iff_conj (T : Matrix (Fin 2) (Fin 2) ℂ) :
    FixesNullAxis (Upsilon T) ↔ Tᴴ * (pauliσ 0 + pauliσ 3) * T = pauliσ 0 + pauliσ 3 := by sorry
