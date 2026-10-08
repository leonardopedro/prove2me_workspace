-- Generated from ChapterA4d.lean — theorem BookProof.ChapterA3.nullConj_iff_form
import Mathlib
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.nullConj_iff_form (T : Matrix (Fin 2) (Fin 2) ℂ) :
    Tᴴ * (pauliσ 0 + pauliσ 3) * T = pauliσ 0 + pauliσ 3 ↔
      T 0 1 = 0 ∧ Complex.normSq (T 0 0) = 1 := by sorry
