-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.criticallyDamped_energy_not_constant
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
import Theorems.Thm_BookProof_DampedOscillatorEnergy_dampedEnergy_not_constant_of_damped
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_hasDerivAt_pos
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_hasDerivAt_vel
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_isSolution
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ E : ℝ, ∀ t, dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s)) t = E :=
  dampedEnergy_not_constant_of_damped (by norm_num) criticallyDamped_hasDerivAt_pos
      criticallyDamped_hasDerivAt_vel criticallyDamped_isSolution (t₀ := 0)
      (by simp)
