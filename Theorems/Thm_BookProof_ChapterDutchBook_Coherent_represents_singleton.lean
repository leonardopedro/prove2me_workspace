-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.Coherent.represents_singleton
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook


open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]


theorem BookProof.ChapterDutchBook.Coherent.represents_singleton {Pr : Finset Ω → ℝ} (h : Coherent Pr)
    (A : Finset Ω) : Pr A = ∑ ω ∈ A, Pr {ω} := by sorry
