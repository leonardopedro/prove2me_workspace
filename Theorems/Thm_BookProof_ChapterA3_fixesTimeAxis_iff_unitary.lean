-- Generated from ChapterA4c.lean — theorem BookProof.ChapterA3.fixesTimeAxis_iff_unitary
import Mathlib
import Definitions.Def_ChapterA4c
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.fixesTimeAxis_iff_unitary (T : Matrix (Fin 2) (Fin 2) ℂ) :
    FixesTimeAxis (Upsilon T) ↔ Tᴴ * T = 1 := by sorry
