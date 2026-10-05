-- Generated from ChapterF2.lean — solution of BookProof.ChapterF2.mass_gap_attained
import Mathlib
import Definitions.Def_ChapterF2
import Theorems.Thm_BookProof_ChapterF1_numberOp_monomial
open BookProof.ChapterF2



open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : bargmann X (hamiltonian X) = bargmann X X := by

  have hX : hamiltonian (X : ℂ[X]) = X := by
    change numberOp X = X
    simpa using numberOp_monomial 1
  rw [hX]
