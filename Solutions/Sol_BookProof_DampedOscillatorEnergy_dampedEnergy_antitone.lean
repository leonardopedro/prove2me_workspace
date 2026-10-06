-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.dampedEnergy_antitone
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
import Theorems.Thm_BookProof_DampedOscillatorEnergy_hasDerivAt_dampedEnergy
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution {lam omega : ℝ} {x v a : ℝ → ℝ} (hlam : 0 ≤ lam)
    (hx : ∀ t, HasDerivAt x (v t) t) (hv : ∀ t, HasDerivAt v (a t) t)
    (heq : ∀ t, a t + lam * v t + omega ^ 2 * x t = 0) :
    Antitone (dampedEnergy omega x v) := by

  refine antitone_of_deriv_nonpos
    (fun t => (hasDerivAt_dampedEnergy hx hv heq t).differentiableAt) (fun t => ?_)
  rw [(hasDerivAt_dampedEnergy hx hv heq t).deriv]
  have : 0 ≤ lam * v t ^ 2 := mul_nonneg hlam (sq_nonneg _)
  linarith
