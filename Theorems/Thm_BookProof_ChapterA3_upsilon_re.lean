-- Generated from ChapterA4c.lean — theorem BookProof.ChapterA3.upsilon_re
import Mathlib
import Definitions.Def_ChapterA4c
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilon_re (T : Matrix (Fin 2) (Fin 2) ℂ) (μ ν : Fin 4) :
    ((Upsilon T μ ν : ℝ) : ℂ) = UpsilonC T μ ν := by sorry
