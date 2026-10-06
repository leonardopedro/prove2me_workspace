-- Generated from ChapterHowlandAutonomization.lean — solution of BookProof.Howland.hasDerivAt_autonomize
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland




open MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℝ → E → E) (x : ℝ → E) (t : ℝ)
    (hx : HasDerivAt x (f t (x t)) t) :
    HasDerivAt (fun s : ℝ => ((s, x s) : ℝ × E)) (autonomize f (t, x t)) t := by

  simpa [autonomize] using (hasDerivAt_id t).prodMk hx
