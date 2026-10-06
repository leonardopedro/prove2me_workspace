-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.criticallyDamped_isSolution
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    (Real.exp (-t)) + 2 * (-Real.exp (-t)) + 1 ^ 2 * Real.exp (-t) = 0 := by

  ring
