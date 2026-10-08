-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_smul
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.weakValue_smul (c : ℂ) (i f : Fin n → ℂ) (A : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (c • A) = c * weakValue i f A := by sorry
