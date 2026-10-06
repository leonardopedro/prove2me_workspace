-- Generated from ChapterSymmetryEntropy.lean — solution of BookProof.SymmetryEntropy.entropy_pointMass
import Mathlib
import Definitions.Def_ChapterSymmetryEntropy
open BookProof.SymmetryEntropy




open Finset
open BookProof.ChapterMarkovEntropy (entropy)
open BookProof.ChapterReconstruct (IsDeterministicCol)

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin n) :
    entropy (fun k => if k = a then (1 : ℝ) else 0) = 0 := by

  refine Finset.sum_eq_zero fun k _ => ?_
  by_cases hk : k = a <;> simp [hk, Real.negMulLog]
