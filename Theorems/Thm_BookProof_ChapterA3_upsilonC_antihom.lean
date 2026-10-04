-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.upsilonC_antihom
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilonC_antihom (T U : Matrix (Fin 2) (Fin 2) ℂ) :
    UpsilonC (T * U) = UpsilonC U * UpsilonC T := by sorry
