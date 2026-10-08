-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.coherent_exists_prob
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook


open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]


theorem BookProof.ChapterDutchBook.coherent_exists_prob [Fintype Ω] {Pr : Finset Ω → ℝ} (h : Coherent Pr) :
    ∃ p : Ω → ℝ, IsProb p ∧ Represents Pr p := by sorry
