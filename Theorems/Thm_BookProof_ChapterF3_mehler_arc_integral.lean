-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.mehler_arc_integral
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped BigOperators
open Polynomial


noncomputable section

theorem BookProof.ChapterF3.mehler_arc_integral (w : ℝ) (hw : 0 < w) :
    (∫ _x in (0 : ℝ)..w, Real.sqrt (1 / w) * Real.sqrt (1 / (2 * Real.pi)))
      = Real.sqrt (w / (2 * Real.pi)) := by sorry
