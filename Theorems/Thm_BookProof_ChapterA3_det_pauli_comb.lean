-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.det_pauli_comb
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.det_pauli_comb (x : Fin 4 → ℂ) :
    (∑ μ, x μ • pauliσ μ).det = Qc x := by sorry
