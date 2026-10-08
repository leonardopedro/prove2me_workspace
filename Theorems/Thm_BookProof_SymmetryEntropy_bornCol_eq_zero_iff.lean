-- Generated from ChapterSymmetryEntropy.lean — theorem BookProof.SymmetryEntropy.bornCol_eq_zero_iff
import Definitions.Def_ChapterMarkovEntropy
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
open BookProof.SymmetryEntropy



open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}


theorem BookProof.SymmetryEntropy.bornCol_eq_zero_iff (U : Fin n → Fin n → ℂ) (a k : Fin n) :
    bornCol U a k = 0 ↔ U k a = 0 := by sorry
