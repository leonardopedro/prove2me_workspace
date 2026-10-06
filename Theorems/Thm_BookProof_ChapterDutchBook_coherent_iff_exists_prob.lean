-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.coherent_iff_exists_prob
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]


open scoped BigOperators
open Finset



theorem BookProof.ChapterDutchBook.coherent_iff_exists_prob [Fintype Ω] (Pr : Finset Ω → ℝ) :
    Coherent Pr ↔ ∃ p : Ω → ℝ, IsProb p ∧ Represents Pr p := by sorry
