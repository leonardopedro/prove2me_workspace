-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.Coherent.additive
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]


open scoped BigOperators
open Finset



theorem BookProof.ChapterDutchBook.Coherent.additive {Pr : Finset Ω → ℝ} (h : Coherent Pr)
    {A B : Finset Ω} (hAB : Disjoint A B) :
    Pr (A ∪ B) = Pr A + Pr B := by sorry
