-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.upsilon_metric
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilon_metric (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) :
    (Upsilon T)ᵀ * minkowskiMat * Upsilon T = minkowskiMat := by sorry
