-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.criticallyDamped_energy_strictAnti
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_energy
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution :
    StrictAnti (dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s))) := by

  intro s t hst
  rw [criticallyDamped_energy, criticallyDamped_energy]
  have h : Real.exp (-t) < Real.exp (-s) := Real.exp_lt_exp.mpr (by linarith)
  have hpos : 0 < Real.exp (-t) := Real.exp_pos _
  nlinarith [Real.exp_pos (-s)]
