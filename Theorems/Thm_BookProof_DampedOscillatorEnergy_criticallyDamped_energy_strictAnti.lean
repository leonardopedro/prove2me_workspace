-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.criticallyDamped_energy_strictAnti
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.criticallyDamped_energy_strictAnti :
    StrictAnti (dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s))) := by sorry
