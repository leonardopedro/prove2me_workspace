-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.criticallyDamped_hasDerivAt_pos
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    HasDerivAt (fun s => Real.exp (-s)) (-Real.exp (-t)) t := by

  have h := (Real.hasDerivAt_exp (-t)).comp t ((hasDerivAt_id t).neg)
  simp at h
  exact h
