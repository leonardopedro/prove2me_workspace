-- Generated from ChapterF3.lean — solution of BookProof.ChapterF3.mehler_arc_integral
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3



open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (w : ℝ) (hw : 0 < w) :
    (∫ _x in (0 : ℝ)..w, Real.sqrt (1 / w) * Real.sqrt (1 / (2 * Real.pi)))
      = Real.sqrt (w / (2 * Real.pi)) := by

  norm_num [ hw.le, mul_div_mul_comm, Real.mul_self_sqrt, Real.pi_pos.le ];
  grind
