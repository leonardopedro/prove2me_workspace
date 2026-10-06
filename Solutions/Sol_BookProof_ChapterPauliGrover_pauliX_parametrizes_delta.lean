-- Generated from ChapterPauliGrover.lean — solution of BookProof.ChapterPauliGrover.pauliX_parametrizes_delta
import Mathlib
import Definitions.Def_ChapterPauliGrover
open BookProof.ChapterPauliGrover



open scoped BigOperators Matrix ComplexConjugate
open Matrix
open BookProof.ChapterConditional

set_option maxHeartbeats 1000000 in
theorem solution (y : Fin 2) :
    ‖pauliX y 0‖ ^ 2 = (if y = 1 then 1 else 0 : ℝ) := by

  fin_cases y <;> simp [pauliX]
