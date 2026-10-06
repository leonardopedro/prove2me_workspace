-- Generated from ChapterPauliGrover.lean — solution of BookProof.ChapterPauliGrover.pauliX_unitary
import Mathlib
import Definitions.Def_ChapterPauliGrover
import Theorems.Thm_BookProof_ChapterPauliGrover_pauliX_conjTranspose
import Theorems.Thm_BookProof_ChapterPauliGrover_pauliX_sq
open BookProof.ChapterPauliGrover



open scoped BigOperators Matrix ComplexConjugate
open Matrix
open BookProof.ChapterConditional

set_option maxHeartbeats 1000000 in
theorem solution : pauliX ∈ Matrix.unitaryGroup (Fin 2) ℂ := by

  rw [Matrix.mem_unitaryGroup_iff, star_eq_conjTranspose, pauliX_conjTranspose]
  exact pauliX_sq
