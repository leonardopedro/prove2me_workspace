-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.quadratic_ordering_vacuum
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : hamiltonian (1 : ℂ[X]) = 0 := by

  unfold hamiltonian; simp [annih, creat]
