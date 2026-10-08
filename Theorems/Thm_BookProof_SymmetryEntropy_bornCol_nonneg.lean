-- Generated from ChapterSymmetryEntropy.lean — theorem BookProof.SymmetryEntropy.bornCol_nonneg
import Definitions.Def_ChapterMarkovEntropy
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
open BookProof.SymmetryEntropy



open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}


theorem BookProof.SymmetryEntropy.bornCol_nonneg (U : Fin n → Fin n → ℂ) (a : Fin n) (k : Fin n) :
    0 ≤ bornCol U a k := by sorry
