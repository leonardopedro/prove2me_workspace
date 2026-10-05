-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.orderings_differ
import Mathlib
import Definitions.Def_ChapterF1
import Theorems.Thm_BookProof_ChapterF1_quadratic_ordering_vacuum
import Theorems.Thm_BookProof_ChapterF1_symmetric_ordering_vacuum
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : hamiltonian (1 : ℂ[X]) ≠ hamiltonianSym (1 : ℂ[X]) := by

  rw [ quadratic_ordering_vacuum, symmetric_ordering_vacuum ];
  exact ne_of_apply_ne ( fun p => p.coeff 0 ) ( by norm_num )
