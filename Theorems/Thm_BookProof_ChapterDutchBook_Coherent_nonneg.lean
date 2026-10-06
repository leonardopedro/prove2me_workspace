-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.Coherent.nonneg
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]


open scoped BigOperators
open Finset



theorem BookProof.ChapterDutchBook.Coherent.nonneg {Pr : Finset Ω → ℝ} (h : Coherent Pr) (A : Finset Ω) :
    0 ≤ Pr A := by sorry
