-- Generated from ChapterHowlandAutonomization.lean — theorem BookProof.Howland.hasDerivAt_of_autonomize
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland



open MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

theorem BookProof.Howland.hasDerivAt_of_autonomize (f : ℝ → E → E) (x : ℝ → E) (t : ℝ)
    (h : HasDerivAt (fun s : ℝ => ((s, x s) : ℝ × E)) (autonomize f (t, x t)) t) :
    HasDerivAt x (f t (x t)) t := by sorry
