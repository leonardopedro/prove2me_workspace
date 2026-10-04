-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.upsilonC_Qc
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilonC_Qc (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) (x : Fin 4 → ℂ) :
    Qc (fun μ => ∑ ν, UpsilonC T μ ν * x ν) = Qc x := by sorry
