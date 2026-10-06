-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.criticallyDamped_hasDerivAt_vel
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_hasDerivAt_pos
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    HasDerivAt (fun s => -Real.exp (-s)) (Real.exp (-t)) t := by

  have h := (criticallyDamped_hasDerivAt_pos t).neg
  simp at h
  exact h
