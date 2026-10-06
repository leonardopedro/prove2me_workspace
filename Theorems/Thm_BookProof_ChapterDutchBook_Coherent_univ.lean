-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.Coherent.univ
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]


open scoped BigOperators
open Finset



theorem BookProof.ChapterDutchBook.Coherent.univ [Fintype Ω] {Pr : Finset Ω → ℝ} (h : Coherent Pr) :
    Pr (Finset.univ : Finset Ω) = 1 := by sorry
