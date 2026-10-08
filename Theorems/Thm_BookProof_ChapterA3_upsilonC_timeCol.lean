-- Generated from ChapterA4c.lean — theorem BookProof.ChapterA3.upsilonC_timeCol
import Mathlib
import Definitions.Def_ChapterA4c
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilonC_timeCol (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    UpsilonC T μ 0 = pauliCoeff (Tᴴ * T) μ := by sorry
