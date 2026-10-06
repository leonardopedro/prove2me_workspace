-- Generated from ChapterWignerLittleGroup.lean — solution of BookProof.ChapterWignerLittleGroup.hermOfMom_trace
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterWignerLittleGroup



open Matrix Complex

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin 4 → ℝ) :
    (hermOfMom p).trace = ((2 * p 0 : ℝ) : ℂ) := by

  simp [hermOfMom, Matrix.trace_fin_two_of]
  ring
