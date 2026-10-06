-- Generated from ChapterSymmetryEntropy.lean — theorem BookProof.SymmetryEntropy.isDeterministicCol_of_entropy_eq_zero
import Definitions.Def_ChapterMarkovEntropy
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
import Definitions.Def_ChapterIrreversible
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterIrreversible
open BookProof.ChapterReconstruct
open BookProof.SymmetryEntropy

variable {n : ℕ}



open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)


theorem BookProof.SymmetryEntropy.isDeterministicCol_of_entropy_eq_zero {U : Fin n → Fin n → ℂ} {a : Fin n}
    (hcol : ∑ k, ‖U k a‖ ^ 2 = 1) (h : entropy (bornCol U a) = 0) :
    IsDeterministicCol U a := by sorry
