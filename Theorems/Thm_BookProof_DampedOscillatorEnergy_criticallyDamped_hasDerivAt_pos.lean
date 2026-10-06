-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.criticallyDamped_hasDerivAt_pos
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.criticallyDamped_hasDerivAt_pos (t : ℝ) :
    HasDerivAt (fun s => Real.exp (-s)) (-Real.exp (-t)) t := by sorry
