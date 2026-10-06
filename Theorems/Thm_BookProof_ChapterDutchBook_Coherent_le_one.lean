-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.Coherent.le_one
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]


open scoped BigOperators
open Finset



theorem BookProof.ChapterDutchBook.Coherent.le_one {Pr : Finset Ω → ℝ} (h : Coherent Pr) (A : Finset Ω) :
    Pr A ≤ 1 := by sorry
