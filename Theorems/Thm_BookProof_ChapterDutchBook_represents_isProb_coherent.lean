-- Generated from ChapterDutchBook.lean — theorem BookProof.ChapterDutchBook.represents_isProb_coherent
import Mathlib
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook


open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]


theorem BookProof.ChapterDutchBook.represents_isProb_coherent [Fintype Ω] {Pr : Finset Ω → ℝ} {p : Ω → ℝ}
    (hp : IsProb p) (hrep : Represents Pr p) : Coherent Pr := by sorry
