-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.criticallyDamped_energy
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s)) t
      = Real.exp (-t) ^ 2 := by

  simp [dampedEnergy]
