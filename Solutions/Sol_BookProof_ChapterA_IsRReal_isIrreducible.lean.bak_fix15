-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.IsRReal.isIrreducible
import Mathlib
import Definitions.Def_ChapterA1c
import Theorems.Thm_BookProof_Complexification_irreducible_iff_no_conj_subsystem
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℝ W} (h : IsRReal M) :
    M.IsIrreducible := by

  rw [irreducible_iff_no_conj_subsystem]
  intro X hX _
  exact h X hX
