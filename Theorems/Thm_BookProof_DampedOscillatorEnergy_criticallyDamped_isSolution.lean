-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.criticallyDamped_isSolution
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.criticallyDamped_isSolution (t : ℝ) :
    (Real.exp (-t)) + 2 * (-Real.exp (-t)) + 1 ^ 2 * Real.exp (-t) = 0 := by sorry
