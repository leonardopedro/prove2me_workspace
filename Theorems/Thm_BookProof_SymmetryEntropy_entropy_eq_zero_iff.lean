-- Generated from ChapterSymmetryEntropy.lean — theorem BookProof.SymmetryEntropy.entropy_eq_zero_iff
import Definitions.Def_ChapterMarkovEntropy
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
import Definitions.Def_ChapterIrreversible
open BookProof.SymmetryEntropy



open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}


theorem BookProof.SymmetryEntropy.entropy_eq_zero_iff {p : Fin n → ℝ} (h0 : ∀ k, 0 ≤ p k) (h1 : ∀ k, p k ≤ 1) :
    entropy p = 0 ↔ ∀ k, p k = 0 ∨ p k = 1 := by sorry
