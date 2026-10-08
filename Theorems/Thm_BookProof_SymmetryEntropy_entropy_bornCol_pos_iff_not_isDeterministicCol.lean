-- Generated from ChapterSymmetryEntropy.lean — theorem BookProof.SymmetryEntropy.entropy_bornCol_pos_iff_not_isDeterministicCol
import Definitions.Def_ChapterMarkovEntropy
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
import Definitions.Def_ChapterIrreversible
import Definitions.Def_ChapterReconstruct
open BookProof.ChapterReconstruct
open BookProof.SymmetryEntropy



open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}


theorem BookProof.SymmetryEntropy.entropy_bornCol_pos_iff_not_isDeterministicCol {U : Fin n → Fin n → ℂ} {a : Fin n}
    (hcol : ∑ k, ‖U k a‖ ^ 2 = 1) :
    0 < entropy (bornCol U a) ↔ ¬ IsDeterministicCol U a := by sorry
