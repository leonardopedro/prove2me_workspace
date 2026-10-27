-- Generated from ChapterPauliGrover.lean — solution of BookProof.ChapterPauliGrover.pauliX_conjTranspose
import Mathlib
import Definitions.Def_ChapterPauliGrover
open BookProof.ChapterPauliGrover



open scoped BigOperators Matrix ComplexConjugate
open Matrix
open BookProof.ChapterConditional

set_option maxHeartbeats 1000000 in
theorem solution : pauliX.conjTranspose = pauliX := by

  ext i j
  fin_cases i <;> fin_cases j <;> simp [pauliX, Matrix.conjTranspose_apply]
