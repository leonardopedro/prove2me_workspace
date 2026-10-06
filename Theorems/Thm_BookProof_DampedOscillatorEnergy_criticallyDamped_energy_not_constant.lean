-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.criticallyDamped_energy_not_constant
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.criticallyDamped_energy_not_constant :
    ¬ ∃ E : ℝ, ∀ t, dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s)) t = E := by sorry
