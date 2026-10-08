-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_add
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.weakValue_add (i f : Fin n → ℂ) (A B : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (A + B) = weakValue i f A + weakValue i f B := by sorry
