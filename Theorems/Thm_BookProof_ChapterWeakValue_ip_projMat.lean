-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.ip_projMat
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterWeakValue.ip_projMat (a : Fin n) (f v : Fin n → ℂ) :
    ip f (projMat a *ᵥ v) = starRingEnd ℂ (f a) * v a := by sorry
