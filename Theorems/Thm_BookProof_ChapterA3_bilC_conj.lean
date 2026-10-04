-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.bilC_conj
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.bilC_conj (A M : Matrix (Fin 4) (Fin 4) ℂ) (x : Fin 4 → ℂ) :
    bilC (Aᵀ * M * A) x = bilC M (fun i => ∑ j, A i j * x j) := by sorry
