-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.projMat_mulVec
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.projMat_mulVec (a : Fin n) (v : Fin n → ℂ) (b : Fin n) :
    (projMat a *ᵥ v) b = if b = a then v a else 0 := by sorry
