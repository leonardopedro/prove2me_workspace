-- Generated from ChapterDampedOscillatorEnergy.lean — theorem BookProof.DampedOscillatorEnergy.hasDerivAt_dampedEnergy
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy



open MeasureTheory

theorem BookProof.DampedOscillatorEnergy.hasDerivAt_dampedEnergy {lam omega : ℝ} {x v a : ℝ → ℝ}
    (hx : ∀ t, HasDerivAt x (v t) t) (hv : ∀ t, HasDerivAt v (a t) t)
    (heq : ∀ t, a t + lam * v t + omega ^ 2 * x t = 0) (t : ℝ) :
    HasDerivAt (dampedEnergy omega x v) (-(lam * v t ^ 2)) t := by sorry
