-- Generated from ChapterA3i.lean — theorem BookProof.ChapterA3.spinorInv_conj_mgamma
import Mathlib
import Definitions.Def_ChapterA3i
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.spinorInv_conj_mgamma (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    SpinorInv T * mgamma μ * Spinor T = ∑ ν, UpsilonC T ν μ • mgamma ν := by sorry
