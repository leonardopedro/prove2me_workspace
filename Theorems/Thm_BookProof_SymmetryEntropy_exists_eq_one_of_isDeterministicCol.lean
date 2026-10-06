-- Generated from ChapterSymmetryEntropy.lean — theorem BookProof.SymmetryEntropy.exists_eq_one_of_isDeterministicCol
import Definitions.Def_ChapterMarkovEntropy
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct
open BookProof.SymmetryEntropy

variable {n : ℕ}



open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)


theorem BookProof.SymmetryEntropy.exists_eq_one_of_isDeterministicCol {U : Fin n → Fin n → ℂ} {a : Fin n}
    (hcol : ∑ k, ‖U k a‖ ^ 2 = 1) (hdet : IsDeterministicCol U a) :
    ∃ k, bornCol U a k = 1 ∧ ∀ l, l ≠ k → bornCol U a l = 0 := by sorry
