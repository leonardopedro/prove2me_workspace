-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.sub_add_singleK
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep











open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} (h : k ≤ a i) :
    (a - Finsupp.single i k) + Finsupp.single i k = a := by

  ext j
  by_cases hj : j = i
  · subst hj; simp; omega
  · simp [hj]
