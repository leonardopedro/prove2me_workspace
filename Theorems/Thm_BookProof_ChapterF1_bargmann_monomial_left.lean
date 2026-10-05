-- Generated from ChapterF1.lean — theorem BookProof.ChapterF1.bargmann_monomial_left
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1


open Polynomial Finset
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF1.bargmann_monomial_left (m : ℕ) (q : ℂ[X]) :
    bargmann (X ^ m) q = (m.factorial : ℂ) * q.coeff m := by sorry
