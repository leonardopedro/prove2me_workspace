-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.criticallyDamped_hasDerivAt_energy
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
import Theorems.Thm_BookProof_DampedOscillatorEnergy_hasDerivAt_dampedEnergy
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_hasDerivAt_pos
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_hasDerivAt_vel
import Theorems.Thm_BookProof_DampedOscillatorEnergy_criticallyDamped_isSolution
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    HasDerivAt (dampedEnergy 1 (fun s => Real.exp (-s)) (fun s => -Real.exp (-s)))
      (-(2 * (-Real.exp (-t)) ^ 2)) t :=
  hasDerivAt_dampedEnergy criticallyDamped_hasDerivAt_pos criticallyDamped_hasDerivAt_vel
      criticallyDamped_isSolution t
