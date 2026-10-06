-- Generated from ChapterA3b.lean — theorem BookProof.ChapterA3.exists_real_of_conj_fixed
import Mathlib
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.exists_real_of_conj_fixed {N : Matrix (Fin 4) (Fin 4) ℂ}
    (hN : N.map (starRingEnd ℂ) = N) : ∃ M : Matrix (Fin 4) (Fin 4) ℝ, toC M = N := by sorry
