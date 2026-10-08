-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.Coherent.empty
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook


open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]


theorem BookProof.ChapterDutchBook.Coherent.empty {Pr : Finset Ω → ℝ} (h : Coherent Pr) : Pr (∅ : Finset Ω) = 0 := by sorry
