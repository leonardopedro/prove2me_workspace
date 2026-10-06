-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.criticallyDamped_hasDerivAt_energy
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.criticallyDamped_hasDerivAt_energy (t : ℝ) :
    HasDerivAt (dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s)))
      (-(2 * (-Real.exp (-t)) ^ 2)) t := by sorry
