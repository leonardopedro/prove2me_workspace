-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_linear
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.weakValue_linear (c d : ℂ) (i f : Fin n → ℂ)
    (A B : Matrix (Fin n) (Fin n) ℂ) :
    weakValue i f (c • A + d • B) =
      c * weakValue i f A + d * weakValue i f B := by sorry
