-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.pauli_expand
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.pauli_expand (M : Matrix (Fin 2) (Fin 2) ℂ) :
    M = ∑ μ, pauliCoeff M μ • pauliσ μ := by sorry
