-- Generated from ChapterSymmetryEntropy.lean — solution of BookProof.SymmetryEntropy.entropy_bornCol_pos_iff_not_isDeterministicCol
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
import Theorems.Thm_BookProof_SymmetryEntropy_entropy_nonneg
import Theorems.Thm_BookProof_SymmetryEntropy_bornCol_nonneg
import Theorems.Thm_BookProof_SymmetryEntropy_bornCol_le_one
import Theorems.Thm_BookProof_SymmetryEntropy_isDeterministicCol_iff_entropy_eq_zero
open BookProof.SymmetryEntropy




open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {U : Fin n → Fin n → ℂ} {a : Fin n}
    (hcol : ∑ k, ‖U k a‖ ^ 2 = 1) :
    0 < entropy (bornCol U a) ↔ ¬ IsDeterministicCol U a := by

  have hnn : 0 ≤ entropy (bornCol U a) :=
    entropy_nonneg (bornCol_nonneg U a) (bornCol_le_one hcol)
  rw [isDeterministicCol_iff_entropy_eq_zero hcol]
  constructor
  · intro hpos hzero
    exact absurd hzero (ne_of_gt hpos)
  · intro hne
    exact lt_of_le_of_ne hnn (fun h => hne h.symm)
