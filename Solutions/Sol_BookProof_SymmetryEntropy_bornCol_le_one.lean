-- Generated from ChapterSymmetryEntropy.lean — solution of BookProof.SymmetryEntropy.bornCol_le_one
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
open BookProof.SymmetryEntropy




open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {U : Fin n → Fin n → ℂ} {a : Fin n}
    (hcol : ∑ k, ‖U k a‖ ^ 2 = 1) (k : Fin n) : bornCol U a k ≤ 1 := by

  have := Finset.single_le_sum (f := fun j => ‖U j a‖ ^ 2)
    (fun j _ => by positivity : ∀ j ∈ (univ : Finset (Fin n)), 0 ≤ ‖U j a‖ ^ 2) (mem_univ k)
  rw [hcol] at this
  exact this
