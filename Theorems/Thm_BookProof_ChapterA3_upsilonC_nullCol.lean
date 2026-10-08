-- Generated from ChapterA4d.lean — theorem BookProof.ChapterA3.upsilonC_nullCol
import Mathlib
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilonC_nullCol (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    UpsilonC T μ 0 + UpsilonC T μ 3 = pauliCoeff (Tᴴ * (pauliσ 0 + pauliσ 3) * T) μ := by sorry
