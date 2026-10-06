-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.hasDerivAt_dampedEnergy
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution {lam omega : ℝ} {x v a : ℝ → ℝ}
    (hx : ∀ t, HasDerivAt x (v t) t) (hv : ∀ t, HasDerivAt v (a t) t)
    (heq : ∀ t, a t + lam * v t + omega ^ 2 * x t = 0) (t : ℝ) :
    HasDerivAt (dampedEnergy omega x v) (-(lam * v t ^ 2)) t := by

  have hderiv : HasDerivAt (dampedEnergy omega x v)
      (v t * a t + omega ^ 2 * (x t * v t)) t := by
    have h1 : HasDerivAt (fun s => v s ^ 2 / 2) (v t * a t) t := by
      have h := ((hv t).pow 2).div_const 2
      convert h using 1 <;> first | rfl | ring
    have h2 : HasDerivAt (fun s => omega ^ 2 * x s ^ 2 / 2) (omega ^ 2 * (x t * v t)) t := by
      have h := (((hx t).pow 2).const_mul (omega ^ 2)).div_const 2
      convert h using 1 <;> first | rfl | ring
    exact h1.add h2
  have hrate : v t * a t + omega ^ 2 * (x t * v t) = -(lam * v t ^ 2) := by
    have ha : a t = -(lam * v t) - omega ^ 2 * x t := by linarith [heq t]
    rw [ha]; ring
  rwa [hrate] at hderiv
