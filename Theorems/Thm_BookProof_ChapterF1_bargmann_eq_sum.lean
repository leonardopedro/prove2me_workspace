-- Generated from ChapterF1.lean — theorem BookProof.ChapterF1.bargmann_eq_sum
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1


open Polynomial Finset
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF1.bargmann_eq_sum (p q : ℂ[X]) {s : Finset ℕ}
    (hp : p.support ⊆ s) (hq : q.support ⊆ s) :
    bargmann p q = ∑ n ∈ s, (n.factorial : ℂ) * (starRingEnd ℂ) (p.coeff n) * q.coeff n := by sorry
