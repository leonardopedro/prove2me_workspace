-- Generated from ChapterPauliGrover.lean — solution of BookProof.ChapterPauliGrover.pauliGrover_joint_one
import Mathlib
import Definitions.Def_ChapterPauliGrover
open BookProof.ChapterPauliGrover



open scoped BigOperators Matrix ComplexConjugate
open Matrix
open BookProof.ChapterConditional

set_option maxHeartbeats 1000000 in
theorem solution : pJoint pauliX (0 : Fin 2) 1 = 1 := by

  simp [pJoint, pauliX]
