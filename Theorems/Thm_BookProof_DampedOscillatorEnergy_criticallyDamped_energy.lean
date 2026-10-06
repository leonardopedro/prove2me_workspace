-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.criticallyDamped_energy
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.criticallyDamped_energy (t : ℝ) :
    dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s)) t
      = Real.exp (-t) ^ 2 := by sorry
