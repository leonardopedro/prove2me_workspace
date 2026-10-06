-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.chargeConj_involutive
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution : Function.Involutive chargeConj := by

  intro v; funext i; simp [chargeConj]
