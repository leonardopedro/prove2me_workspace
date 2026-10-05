-- Generated from ChapterF1.lean — theorem BookProof.ChapterF1.bargmann_monomial
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1


open Polynomial Finset
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF1.bargmann_monomial (m n : ℕ) :
    bargmann (X ^ m) (X ^ n) = if m = n then (n.factorial : ℂ) else 0 := by sorry
