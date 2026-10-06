-- Generated from ChapterA4d.lean — theorem BookProof.ChapterA3.SEtwo_lower_triangular
import Mathlib
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.SEtwo_lower_triangular (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SEtwo) :
    T 0 1 = 0 ∧ T 1 1 = (T 0 0)⁻¹ ∧ Complex.normSq (T 0 0) = 1 := by sorry
