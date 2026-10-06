-- Generated from ChapterSymmetryEntropy.lean — solution of BookProof.SymmetryEntropy.bornCol_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
open BookProof.SymmetryEntropy




open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Fin n → Fin n → ℂ) (a k : Fin n) :
    bornCol U a k = 0 ↔ U k a = 0 := by

  simp [bornCol, pow_eq_zero_iff]
