-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.Coherent.additive
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook


open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]


theorem BookProof.ChapterDutchBook.Coherent.additive {Pr : Finset Ω → ℝ} (h : Coherent Pr)
    {A B : Finset Ω} (hAB : Disjoint A B) :
    Pr (A ∪ B) = Pr A + Pr B := by sorry
